import { useState, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useLessonDetail } from '../hooks/useLessons';
import { Button, Badge, Spinner } from '../../../design-system';
import { ExerciseCard } from '../../exercises/components/ExerciseCard';
import { useUserStore } from '../../../core/store/userStore';
import type { SlideDto } from '../../../shared/types';

/* ────────────────────────────────────────────────────────────────
   Content JSON shapes (all possible from migration)
──────────────────────────────────────────────────────────────── */
type SectionShape = { title?: string; formula?: string; examples?: string[]; example?: string; note?: string };
type RuleShape    = { rule?: string; examples?: string[]; note?: string; number?: number };
type WordShape    = { en: string; pt: string };
type ActivityShape = { number?: number; text: string };
type ContractionShape = { full: string; short: string; example?: string };

type SlideContentParsed =
  | { kind: 'intro';        heading: string; subtitle?: string; lesson?: string }
  | { kind: 'closing';      heading: string; subtitle?: string }
  | { kind: 'list';         heading: string; points: string[]; examples?: string[] }
  | { kind: 'table';        heading: string; headers: string[]; rows: string[][]; subheading?: string }
  | { kind: 'sections';     heading: string; sections: SectionShape[] }
  | { kind: 'rules';        heading: string; rules: RuleShape[] }
  | { kind: 'words';        heading: string; description?: string; words: WordShape[]; example?: string }
  | { kind: 'practice';     heading: string; activities: ActivityShape[] }
  | { kind: 'contractions'; heading: string; items: ContractionShape[] }
  | { kind: 'pairs';        heading: string; pairs: [string, string][] }
  | { kind: 'example';      heading: string; example: string; explanation?: string }
  | { kind: 'generic';      heading?: string; text: string }
  | { kind: 'plain';        text: string };

function parseSlideContent(raw: string): SlideContentParsed {
  try {
    const p = JSON.parse(raw);
    if (!p || typeof p !== 'object') throw new Error();
    const h = (p.heading as string) ?? '';

    // closing: has subtitle but no lesson, and no other content arrays
    if (
      p.subtitle !== undefined && p.lesson === undefined &&
      !p.points && !p.sections && !p.rules && !p.words && !p.activities && !p.headers
    ) {
      return { kind: 'closing', heading: h, subtitle: p.subtitle };
    }

    // intro
    if (p.subtitle !== undefined || p.lesson !== undefined) {
      return { kind: 'intro', heading: h, subtitle: p.subtitle, lesson: p.lesson };
    }

    // table (standard headers+rows)
    if (Array.isArray(p.headers) && Array.isArray(p.rows)) {
      return {
        kind: 'table',
        heading: h,
        headers: p.headers as string[],
        rows: p.rows as string[][],
        subheading: p.subheading as string | undefined,
      };
    }

    // pairs (irregular verbs: [["to be","was"],…]) → 2-col table
    if (Array.isArray(p.pairs)) {
      return { kind: 'pairs', heading: h, pairs: p.pairs as [string, string][] };
    }

    // contractions
    if (Array.isArray(p.contractions)) {
      return { kind: 'contractions', heading: h, items: p.contractions as ContractionShape[] };
    }

    // sections (examples slides)
    if (Array.isArray(p.sections)) {
      return { kind: 'sections', heading: h, sections: p.sections as SectionShape[] };
    }

    // flat formula+examples (L1 slide 6 format: {heading, subheading?, formula, examples:[…]})
    if (p.formula !== undefined && Array.isArray(p.examples)) {
      return {
        kind: 'sections',
        heading: h,
        sections: [{ title: p.subheading as string | undefined, formula: p.formula as string, examples: p.examples as string[] }],
      };
    }

    // rules (theory -ing rules)
    if (Array.isArray(p.rules)) {
      return { kind: 'rules', heading: h, rules: p.rules as RuleShape[] };
    }

    // words (vocabulary slides)
    if (Array.isArray(p.words)) {
      return {
        kind: 'words',
        heading: h,
        description: p.description as string | undefined,
        words: p.words as WordShape[],
        example: p.example as string | undefined,
      };
    }

    // practice
    if (Array.isArray(p.activities)) {
      return { kind: 'practice', heading: h, activities: p.activities as ActivityShape[] };
    }

    // list (theory with points)
    if (Array.isArray(p.points) && p.points.length > 0) {
      return {
        kind: 'list',
        heading: h,
        points: p.points as string[],
        examples: Array.isArray(p.examples) ? (p.examples as string[]) : undefined,
      };
    }

    // example (single sentence)
    if (p.example !== undefined && !Array.isArray(p.example)) {
      return { kind: 'example', heading: h, example: String(p.example), explanation: p.explanation };
    }

    // generic fallback
    if (h || p.text) {
      return { kind: 'generic', heading: h || undefined, text: (p.text as string) ?? '' };
    }
  } catch {
    /* fall through */
  }
  return { kind: 'plain', text: raw };
}

/* ────────────────────────────────────────────────────────────────
   Slide type → accent gradient
──────────────────────────────────────────────────────────────── */
const slideAccent: Record<string, string> = {
  intro:    'var(--gradient-brand)',
  theory:   'var(--gradient-preview)',
  table:    'var(--gradient-develop)',
  examples: 'var(--gradient-ship)',
  practice: 'var(--gradient-develop)',
  closing:  'var(--gradient-brand)',
  Intro:    'var(--gradient-brand)',
  Theory:   'var(--gradient-preview)',
  Table:    'var(--gradient-develop)',
  Examples: 'var(--gradient-ship)',
  Practice: 'var(--gradient-develop)',
  Closing:  'var(--gradient-brand)',
};

function getSlideAccent(type: string) {
  return slideAccent[type] ?? 'var(--gradient-preview)';
}

/* ────────────────────────────────────────────────────────────────
   Web Speech API — pronunciação em inglês
──────────────────────────────────────────────────────────────── */

// Inject keyframes once
if (typeof document !== 'undefined' && !document.getElementById('le-speak-styles')) {
  const style = document.createElement('style');
  style.id = 'le-speak-styles';
  style.textContent = `
    @keyframes le-speaker-pulse {
      0%,100% { transform: scale(1); opacity: 1; }
      50%      { transform: scale(1.35); opacity: 0.7; }
    }
    @keyframes le-reveal {
      from { opacity: 0; transform: translateY(4px); }
      to   { opacity: 1; transform: translateY(0); }
    }
  `;
  document.head.appendChild(style);
}

function speak(text: string, onEnd?: () => void) {
  if (!('speechSynthesis' in window)) { onEnd?.(); return; }
  window.speechSynthesis.cancel();
  const utt = new SpeechSynthesisUtterance(text);
  utt.lang = 'en-US';
  utt.rate = 0.85;
  utt.pitch = 1;
  if (onEnd) utt.onend = onEnd;
  window.speechSynthesis.speak(utt);
}

/** Hook: returns a speak fn that tracks which key is currently playing */
function useSpeaking() {
  const [playing, setPlaying] = useState<string | null>(null);
  const speakKey = useCallback((text: string, key: string) => {
    setPlaying(key);
    speak(text, () => setPlaying(null));
  }, []);
  return { playing, speakKey };
}

function SpeakerIcon({
  size = 14,
  color = 'currentColor',
  isPlaying = false,
}: {
  size?: number;
  color?: string;
  isPlaying?: boolean;
}) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 24 24"
      fill="none"
      stroke={color}
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
      style={{
        flexShrink: 0,
        animation: isPlaying ? 'le-speaker-pulse 0.6s ease-in-out infinite' : 'none',
      }}
    >
      <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5" />
      <path d="M19.07 4.93a10 10 0 0 1 0 14.14" />
      <path d="M15.54 8.46a5 5 0 0 1 0 7.07" />
    </svg>
  );
}

/* ────────────────────────────────────────────────────────────────
   Sub-components
──────────────────────────────────────────────────────────────── */

function SlideHeading({ text }: { text: string }) {
  if (!text) return null;
  return (
    <h2
      style={{
        fontSize: 'var(--text-xl)',
        fontWeight: 'var(--weight-semibold)',
        color: 'var(--color-ink)',
        letterSpacing: '-0.03em',
        lineHeight: 'var(--leading-snug)',
        margin: 0,
      }}
    >
      {text}
    </h2>
  );
}

function IntroSlide({ heading, subtitle, lesson, title }: { heading: string; subtitle?: string; lesson?: string; title: string }) {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-3)', paddingTop: 'var(--space-2)' }}>
      <h2
        style={{
          fontSize: 'var(--text-3xl)',
          fontWeight: 'var(--weight-semibold)',
          color: 'var(--color-ink)',
          letterSpacing: '-0.04em',
          lineHeight: 'var(--leading-tight)',
          margin: 0,
        }}
      >
        {heading || title}
      </h2>
      {subtitle && (
        <p style={{ fontSize: 'var(--text-base)', color: 'var(--color-ink-secondary)', lineHeight: 'var(--leading-relaxed)', margin: 0 }}>
          {subtitle}
        </p>
      )}
      {lesson && (
        <span
          style={{
            display: 'inline-flex',
            alignSelf: 'flex-start',
            padding: '4px var(--space-3)',
            fontSize: 'var(--text-xs)',
            fontFamily: 'var(--font-mono)',
            color: 'var(--color-ink-secondary)',
            background: 'var(--color-canvas-subtle)',
            borderRadius: 'var(--radius-full)',
            border: '1px solid var(--color-border)',
            marginTop: 'var(--space-2)',
          }}
        >
          {lesson}
        </span>
      )}
    </div>
  );
}

function ClosingSlide({ heading, subtitle }: { heading: string; subtitle?: string }) {
  return (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        gap: 'var(--space-3)',
        flex: 1,
        textAlign: 'center',
        padding: 'var(--space-8)',
      }}
    >
      <span style={{ fontSize: 40 }}>🎉</span>
      <h2
        style={{
          fontSize: 'var(--text-3xl)',
          fontWeight: 'var(--weight-semibold)',
          color: 'var(--color-ink)',
          letterSpacing: '-0.04em',
          lineHeight: 'var(--leading-tight)',
          margin: 0,
        }}
      >
        {heading}
      </h2>
      {subtitle && (
        <p style={{ fontSize: 'var(--text-base)', color: 'var(--color-ink-secondary)', margin: 0 }}>
          {subtitle}
        </p>
      )}
    </div>
  );
}

function ListSlide({ heading, points, examples }: { heading: string; points: string[]; examples?: string[] }) {
  const { playing, speakKey } = useSpeaking();

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      <SlideHeading text={heading} />
      <ul style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-2)', listStyle: 'none', padding: 0, margin: 0 }}>
        {points.map((pt, i) => (
          <li
            key={i}
            style={{
              display: 'flex',
              gap: 'var(--space-3)',
              alignItems: 'flex-start',
              fontSize: 'var(--text-sm)',
              color: 'var(--color-ink-secondary)',
              lineHeight: 'var(--leading-relaxed)',
              padding: 'var(--space-3) var(--space-4)',
              background: 'var(--color-canvas-soft)',
              borderRadius: 'var(--radius-lg)',
              border: '1px solid var(--color-border)',
            }}
          >
            <span
              style={{
                flexShrink: 0,
                width: 20,
                height: 20,
                borderRadius: 'var(--radius-full)',
                background: 'var(--color-ink)',
                color: '#fff',
                fontSize: 10,
                fontWeight: 600,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                marginTop: 1,
              }}
            >
              {i + 1}
            </span>
            <span>{pt}</span>
          </li>
        ))}
      </ul>
      {examples && examples.length > 0 && (
        <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-2)' }}>
          {examples.map((ex, i) => (
            <ExampleSentenceButton
              key={i}
              text={ex}
              cardKey={`list-ex-${i}`}
              playing={playing}
              onSpeak={speakKey}
            />
          ))}
        </div>
      )}
    </div>
  );
}

function TableSlide({ heading, headers, rows, subheading }: { heading: string; headers: string[]; rows: string[][]; subheading?: string }) {
  const { playing, speakKey } = useSpeaking();

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      <SlideHeading text={heading} />
      {subheading && (
        <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)', margin: 0, lineHeight: 'var(--leading-relaxed)' }}>
          {subheading}
        </p>
      )}
      <div style={{ overflowX: 'auto', borderRadius: 'var(--radius-xl)', border: '1px solid var(--color-border)' }}>
        <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 'var(--text-sm)' }}>
          <thead>
            <tr>
              {headers.map((hdr, i) => (
                <th
                  key={i}
                  style={{
                    padding: 'var(--space-3) var(--space-4)',
                    textAlign: 'left',
                    fontWeight: 600,
                    fontSize: 'var(--text-xs)',
                    fontFamily: 'var(--font-mono)',
                    letterSpacing: '0.04em',
                    textTransform: 'uppercase',
                    color: 'var(--color-ink-secondary)',
                    background: 'var(--color-canvas-subtle)',
                    borderBottom: '1px solid var(--color-border)',
                    whiteSpace: 'nowrap',
                  }}
                >
                  {hdr}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {rows.map((row, ri) => (
              <tr key={ri}>
                {row.map((cell, ci) => {
                  const cellKey = `cell-${ri}-${ci}`;
                  const isPlaying = playing === cellKey;
                  return (
                    <td
                      key={ci}
                      onClick={() => speakKey(cell, cellKey)}
                      title={`🔊 Ouvir: ${cell}`}
                      style={{
                        padding: 'var(--space-3) var(--space-4)',
                        color: isPlaying ? '#fff' : ci === 0 ? 'var(--color-ink)' : 'var(--color-ink-secondary)',
                        fontWeight: ci === 0 ? 600 : 400,
                        fontFamily: ci === 0 ? 'var(--font-mono)' : 'inherit',
                        fontSize: 'var(--text-sm)',
                        background: isPlaying
                          ? 'var(--color-ink)'
                          : ri % 2 === 0 ? 'var(--color-canvas)' : 'var(--color-canvas-soft)',
                        borderBottom: ri < rows.length - 1 ? '1px solid var(--color-border)' : 'none',
                        verticalAlign: 'middle',
                        cursor: 'pointer',
                        transition: 'background 0.15s ease, color 0.15s ease',
                        userSelect: 'none',
                      }}
                      onMouseEnter={(e) => {
                        if (!isPlaying) {
                          e.currentTarget.style.background = 'var(--color-canvas-subtle)';
                        }
                      }}
                      onMouseLeave={(e) => {
                        if (!isPlaying) {
                          e.currentTarget.style.background = ri % 2 === 0 ? 'var(--color-canvas)' : 'var(--color-canvas-soft)';
                        }
                      }}
                    >
                      <span style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                        {cell}
                        <SpeakerIcon
                          size={10}
                          color={isPlaying ? 'rgba(255,255,255,0.7)' : 'var(--color-ink-tertiary)'}
                          isPlaying={isPlaying}
                        />
                      </span>
                    </td>
                  );
                })}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

/** Reusable dark sentence button with play feedback */
function ExampleSentenceButton({ text, cardKey, playing, onSpeak }: {
  text: string;
  cardKey: string;
  playing: string | null;
  onSpeak: (text: string, key: string) => void;
}) {
  const [hovered, setHovered] = useState(false);
  const isPlaying = playing === cardKey;

  return (
    <button
      onClick={() => onSpeak(text, cardKey)}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      style={{
        padding: 'var(--space-3) var(--space-4)',
        background: isPlaying ? '#1a1a2e' : hovered ? '#111' : 'var(--color-ink)',
        borderRadius: 'var(--radius-lg)',
        fontFamily: 'var(--font-mono)',
        fontSize: 'var(--text-sm)',
        color: '#fff',
        lineHeight: 'var(--leading-relaxed)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        gap: 'var(--space-3)',
        cursor: 'pointer',
        border: `1px solid ${isPlaying ? 'rgba(99,179,237,0.4)' : 'transparent'}`,
        textAlign: 'left',
        transition: 'background 0.15s ease, border-color 0.15s ease',
        width: '100%',
        boxShadow: isPlaying ? '0 0 0 3px rgba(99,179,237,0.15)' : 'none',
      }}
    >
      <span style={{ display: 'flex', alignItems: 'center', gap: 'var(--space-2)', flex: 1 }}>
        <span
          style={{
            color: isPlaying ? 'rgba(99,179,237,0.9)' : 'rgba(255,255,255,0.35)',
            fontSize: 10,
            flexShrink: 0,
            transition: 'color 0.15s',
          }}
        >
          ▶
        </span>
        {text}
      </span>
      <SpeakerIcon
        size={12}
        color={isPlaying ? 'rgba(99,179,237,0.9)' : 'rgba(255,255,255,0.4)'}
        isPlaying={isPlaying}
      />
    </button>
  );
}

function SectionsSlide({ heading, sections }: { heading: string; sections: SectionShape[] }) {
  const { playing, speakKey } = useSpeaking();

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-5)' }}>
      <SlideHeading text={heading} />
      {sections.map((sec, si) => (
        <div key={si} style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-3)' }}>
          {sec.title && (
            <p
              style={{
                fontSize: 'var(--text-xs)',
                fontWeight: 600,
                fontFamily: 'var(--font-mono)',
                letterSpacing: '0.06em',
                textTransform: 'uppercase',
                color: 'var(--color-ink-tertiary)',
                margin: 0,
              }}
            >
              {sec.title}
            </p>
          )}
          {sec.formula && (
            <div
              style={{
                padding: 'var(--space-3) var(--space-4)',
                background: 'var(--color-canvas-subtle)',
                borderRadius: 'var(--radius-lg)',
                border: '1px solid var(--color-border)',
                fontFamily: 'var(--font-mono)',
                fontSize: 'var(--text-sm)',
                color: 'var(--color-ink)',
                lineHeight: 'var(--leading-relaxed)',
              }}
            >
              {sec.formula}
            </div>
          )}
          {(() => {
            // normalise: sections may use `example` (singular) or `examples` (array)
            const exList: string[] = sec.examples?.length
              ? sec.examples
              : sec.example
              ? [sec.example]
              : [];
            return exList.length > 0 ? (
              <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-2)' }}>
                {exList.map((ex, ei) => (
                  <ExampleSentenceButton
                    key={ei}
                    text={ex}
                    cardKey={`sec-${si}-ex-${ei}`}
                    playing={playing}
                    onSpeak={speakKey}
                  />
                ))}
              </div>
            ) : null;
          })()}
          {sec.note && (
            <p style={{
              fontSize: 'var(--text-xs)',
              color: 'var(--color-ink-secondary)',
              fontStyle: 'italic',
              margin: 0,
              padding: 'var(--space-2) var(--space-3)',
              background: 'rgba(245,158,11,0.06)',
              borderRadius: 'var(--radius-lg)',
              border: '1px solid rgba(245,158,11,0.2)',
              lineHeight: 'var(--leading-relaxed)',
            }}>
              ⚠️ {sec.note}
            </p>
          )}
        </div>
      ))}
    </div>
  );
}

function RulesSlide({ heading, rules }: { heading: string; rules: RuleShape[] }) {
  const { playing, speakKey } = useSpeaking();

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      <SlideHeading text={heading} />
      {rules.map((r, i) => (
        <div
          key={i}
          style={{
            display: 'flex',
            flexDirection: 'column',
            gap: 'var(--space-3)',
            padding: 'var(--space-4)',
            background: r.note ? 'rgba(245, 158, 11, 0.06)' : 'var(--color-canvas-soft)',
            borderRadius: 'var(--radius-xl)',
            border: `1px solid ${r.note ? 'rgba(245,158,11,0.25)' : 'var(--color-border)'}`,
          }}
        >
          {r.note && (
            <p
              style={{
                fontSize: 'var(--text-sm)',
                color: 'var(--color-ink-secondary)',
                lineHeight: 'var(--leading-relaxed)',
                margin: 0,
                fontStyle: 'italic',
              }}
            >
              ⚠️ {r.note}
            </p>
          )}
          {r.rule && (
            <p
              style={{
                fontSize: 'var(--text-sm)',
                color: 'var(--color-ink)',
                lineHeight: 'var(--leading-relaxed)',
                margin: 0,
                fontWeight: 500,
              }}
            >
              {r.rule}
            </p>
          )}
          {r.examples && r.examples.length > 0 && (
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: 'var(--space-2)' }}>
              {r.examples.map((ex, ei) => {
                const chipKey = `rule-${i}-chip-${ei}`;
                const parts = ex.split('>');
                const textToSpeak = parts.length > 1 ? parts[1].trim() : ex;
                const isPlaying = playing === chipKey;
                return (
                  <button
                    key={ei}
                    onClick={() => speakKey(textToSpeak, chipKey)}
                    title={`Ouvir: ${textToSpeak}`}
                    style={{
                      padding: '4px var(--space-3)',
                      background: isPlaying ? 'var(--color-ink)' : 'var(--color-canvas)',
                      borderRadius: 'var(--radius-full)',
                      border: `1px solid ${isPlaying ? 'var(--color-ink)' : 'var(--color-border)'}`,
                      fontFamily: 'var(--font-mono)',
                      fontSize: 'var(--text-xs)',
                      color: isPlaying ? '#fff' : 'var(--color-ink)',
                      cursor: 'pointer',
                      display: 'inline-flex',
                      alignItems: 'center',
                      gap: 5,
                      transition: 'all 0.15s ease',
                    }}
                    onMouseEnter={(e) => {
                      if (!isPlaying) e.currentTarget.style.borderColor = 'var(--color-ink)';
                    }}
                    onMouseLeave={(e) => {
                      if (!isPlaying) e.currentTarget.style.borderColor = 'var(--color-border)';
                    }}
                  >
                    {ex}
                    <SpeakerIcon
                      size={10}
                      color={isPlaying ? 'rgba(255,255,255,0.8)' : 'var(--color-ink-tertiary)'}
                      isPlaying={isPlaying}
                    />
                  </button>
                );
              })}
            </div>
          )}
        </div>
      ))}
    </div>
  );
}

/** Single vocabulary flashcard — EN visible, PT revealed on hover */
function WordCard({ word, cardKey, playing, onSpeak }: {
  word: WordShape;
  cardKey: string;
  playing: string | null;
  onSpeak: (text: string, key: string) => void;
}) {
  const [hovered, setHovered] = useState(false);
  const isPlaying = playing === cardKey;

  return (
    <button
      onClick={() => onSpeak(word.en, cardKey)}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      title={word.pt}
      style={{
        display: 'flex',
        flexDirection: 'column',
        gap: 0,
        padding: 'var(--space-3)',
        background: isPlaying
          ? 'var(--color-ink)'
          : hovered
          ? 'var(--color-canvas-subtle)'
          : 'var(--color-canvas-soft)',
        borderRadius: 'var(--radius-lg)',
        border: `1px solid ${isPlaying ? 'var(--color-ink)' : hovered ? 'var(--color-ink)' : 'var(--color-border)'}`,
        cursor: 'pointer',
        textAlign: 'left',
        transition: 'all 0.15s ease',
        minHeight: 64,
        justifyContent: 'space-between',
      }}
    >
      {/* EN word row */}
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 4 }}>
        <span
          style={{
            fontSize: 'var(--text-sm)',
            fontWeight: 700,
            color: isPlaying ? '#fff' : 'var(--color-ink)',
            fontFamily: 'var(--font-mono)',
            letterSpacing: '-0.01em',
          }}
        >
          {word.en}
        </span>
        <SpeakerIcon
          size={12}
          color={isPlaying ? 'rgba(255,255,255,0.8)' : hovered ? 'var(--color-ink)' : 'var(--color-ink-tertiary)'}
          isPlaying={isPlaying}
        />
      </div>

      {/* PT translation — hidden until hover */}
      <div
        style={{
          marginTop: hovered || isPlaying ? 6 : 0,
          maxHeight: hovered || isPlaying ? 40 : 0,
          overflow: 'hidden',
          transition: 'max-height 0.2s ease, margin-top 0.2s ease',
        }}
      >
        {(hovered || isPlaying) && (
          <span
            style={{
              fontSize: 'var(--text-xs)',
              color: isPlaying ? 'rgba(255,255,255,0.65)' : 'var(--color-ink-secondary)',
              display: 'block',
              animation: 'le-reveal 0.15s ease',
            }}
          >
            🇧🇷 {word.pt}
          </span>
        )}
      </div>
    </button>
  );
}

function WordsSlide({
  heading, description, words, example,
}: {
  heading: string; description?: string; words: WordShape[]; example?: string;
}) {
  const { playing, speakKey } = useSpeaking();

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 'var(--space-3)' }}>
        <SlideHeading text={heading} />
        <span style={{
          fontSize: 'var(--text-xs)',
          color: 'var(--color-ink-tertiary)',
          fontFamily: 'var(--font-mono)',
          whiteSpace: 'nowrap',
        }}>
          passe o mouse → tradução
        </span>
      </div>
      {description && (
        <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)', lineHeight: 'var(--leading-relaxed)', margin: 0 }}>
          {description}
        </p>
      )}
      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fill, minmax(150px, 1fr))',
          gap: 'var(--space-2)',
        }}
      >
        {words.map((w, i) => (
          <WordCard
            key={i}
            word={w}
            cardKey={`word-${i}`}
            playing={playing}
            onSpeak={speakKey}
          />
        ))}
      </div>

      {/* Example sentence */}
      {example && (
        <ExampleSentenceButton
          text={example}
          cardKey="words-example"
          playing={playing}
          onSpeak={speakKey}
        />
      )}
    </div>
  );
}

function PracticeSlide({ heading, activities }: { heading: string; activities: ActivityShape[] }) {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      <SlideHeading text={heading} />
      <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-3)' }}>
        {activities.map((act, i) => (
          <div
            key={i}
            style={{
              display: 'flex',
              gap: 'var(--space-4)',
              alignItems: 'flex-start',
              padding: 'var(--space-4)',
              background: 'var(--color-canvas-soft)',
              borderRadius: 'var(--radius-xl)',
              border: '1px solid var(--color-border)',
            }}
          >
            <span
              style={{
                flexShrink: 0,
                width: 28,
                height: 28,
                borderRadius: 'var(--radius-full)',
                background: 'var(--gradient-brand)',
                color: '#fff',
                fontSize: 12,
                fontWeight: 700,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
              }}
            >
              {act.number ?? i + 1}
            </span>
            <span
              style={{
                fontSize: 'var(--text-sm)',
                color: 'var(--color-ink-secondary)',
                lineHeight: 'var(--leading-relaxed)',
                paddingTop: 4,
              }}
            >
              {act.text}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
}

function ExampleSlide({ heading, example, explanation }: { heading: string; example: string; explanation?: string }) {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      <SlideHeading text={heading} />
      <div
        style={{
          padding: 'var(--space-5)',
          background: 'var(--color-ink)',
          borderRadius: 'var(--radius-xl)',
          fontFamily: 'var(--font-mono)',
          fontSize: 'var(--text-base)',
          color: '#fff',
          lineHeight: 'var(--leading-relaxed)',
          letterSpacing: '0.01em',
        }}
      >
        {example}
      </div>
      {explanation && (
        <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)', lineHeight: 'var(--leading-relaxed)', margin: 0 }}>
          {explanation}
        </p>
      )}
    </div>
  );
}

function GenericSlide({ heading, text, title }: { heading?: string; text: string; title: string }) {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      <SlideHeading text={heading || title} />
      {text && (
        <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)', lineHeight: 'var(--leading-relaxed)', margin: 0 }}>
          {text}
        </p>
      )}
    </div>
  );
}

function ContractionsSlide({ heading, items }: { heading: string; items: ContractionShape[] }) {
  const { playing, speakKey } = useSpeaking();

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      <SlideHeading text={heading} />
      <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-3)' }}>
        {items.map((c, i) => (
          <div
            key={i}
            style={{
              display: 'flex',
              flexDirection: 'column',
              gap: 'var(--space-2)',
              padding: 'var(--space-4)',
              background: 'var(--color-canvas-soft)',
              borderRadius: 'var(--radius-xl)',
              border: '1px solid var(--color-border)',
            }}
          >
            {/* full → short row */}
            <div style={{ display: 'flex', alignItems: 'center', gap: 'var(--space-3)', flexWrap: 'wrap' }}>
              <span style={{ fontFamily: 'var(--font-mono)', fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)' }}>
                {c.full}
              </span>
              <span style={{ color: 'var(--color-ink-tertiary)', fontSize: 12 }}>→</span>
              <button
                onClick={() => speakKey(c.short, `contraction-${i}-short`)}
                style={{
                  padding: '3px var(--space-3)',
                  background: playing === `contraction-${i}-short` ? 'var(--color-ink)' : 'var(--color-canvas)',
                  color: playing === `contraction-${i}-short` ? '#fff' : 'var(--color-ink)',
                  borderRadius: 'var(--radius-full)',
                  border: `1px solid ${playing === `contraction-${i}-short` ? 'var(--color-ink)' : 'var(--color-border)'}`,
                  fontFamily: 'var(--font-mono)',
                  fontWeight: 700,
                  fontSize: 'var(--text-sm)',
                  cursor: 'pointer',
                  display: 'inline-flex',
                  alignItems: 'center',
                  gap: 5,
                  transition: 'all 0.15s ease',
                }}
              >
                {c.short}
                <SpeakerIcon size={11} color={playing === `contraction-${i}-short` ? 'rgba(255,255,255,0.8)' : 'var(--color-ink-tertiary)'} isPlaying={playing === `contraction-${i}-short`} />
              </button>
            </div>
            {/* example sentence */}
            {c.example && (
              <ExampleSentenceButton
                text={c.example}
                cardKey={`contraction-${i}-ex`}
                playing={playing}
                onSpeak={speakKey}
              />
            )}
          </div>
        ))}
      </div>
    </div>
  );
}

function PairsSlide({ heading, pairs }: { heading: string; pairs: [string, string][] }) {
  const { playing, speakKey } = useSpeaking();

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
        <SlideHeading text={heading} />
        <span style={{ fontSize: 'var(--text-xs)', color: 'var(--color-ink-tertiary)', fontFamily: 'var(--font-mono)' }}>
          clique para ouvir
        </span>
      </div>
      {/* Column headers */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: '1fr 1fr',
        gap: 'var(--space-2)',
        paddingBottom: 'var(--space-1)',
        borderBottom: '1px solid var(--color-border)',
      }}>
        {['Infinitive', 'Simple Past'].map((lbl) => (
          <span key={lbl} style={{
            fontSize: 'var(--text-xs)',
            fontWeight: 600,
            fontFamily: 'var(--font-mono)',
            letterSpacing: '0.04em',
            textTransform: 'uppercase',
            color: 'var(--color-ink-tertiary)',
            padding: '0 var(--space-2)',
          }}>
            {lbl}
          </span>
        ))}
      </div>
      <div style={{
        display: 'grid',
        gridTemplateColumns: '1fr 1fr',
        gap: 'var(--space-1)',
        maxHeight: 280,
        overflowY: 'auto',
        paddingRight: 2,
      }}>
        {pairs.map(([inf, past], i) => {
          const kInf = `pair-${i}-inf`;
          const kPast = `pair-${i}-past`;
          return (
            <>
              <button
                key={kInf}
                onClick={() => speakKey(inf, kInf)}
                style={{
                  padding: 'var(--space-2) var(--space-3)',
                  background: playing === kInf ? 'var(--color-ink)' : 'var(--color-canvas-soft)',
                  color: playing === kInf ? '#fff' : 'var(--color-ink-secondary)',
                  borderRadius: 'var(--radius-md)',
                  border: `1px solid ${playing === kInf ? 'var(--color-ink)' : 'var(--color-border)'}`,
                  fontFamily: 'var(--font-mono)',
                  fontSize: 'var(--text-xs)',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  gap: 4,
                  textAlign: 'left',
                  transition: 'all 0.12s ease',
                }}
                onMouseEnter={(e) => { if (playing !== kInf) e.currentTarget.style.borderColor = 'var(--color-ink)'; }}
                onMouseLeave={(e) => { if (playing !== kInf) e.currentTarget.style.borderColor = 'var(--color-border)'; }}
              >
                {inf}
                <SpeakerIcon size={9} color={playing === kInf ? 'rgba(255,255,255,0.7)' : 'var(--color-ink-tertiary)'} isPlaying={playing === kInf} />
              </button>
              <button
                key={kPast}
                onClick={() => speakKey(past, kPast)}
                style={{
                  padding: 'var(--space-2) var(--space-3)',
                  background: playing === kPast ? 'var(--color-ink)' : 'var(--color-canvas)',
                  color: playing === kPast ? '#fff' : 'var(--color-ink)',
                  borderRadius: 'var(--radius-md)',
                  border: `1px solid ${playing === kPast ? 'var(--color-ink)' : 'var(--color-border)'}`,
                  fontFamily: 'var(--font-mono)',
                  fontWeight: 600,
                  fontSize: 'var(--text-xs)',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  gap: 4,
                  textAlign: 'left',
                  transition: 'all 0.12s ease',
                }}
                onMouseEnter={(e) => { if (playing !== kPast) e.currentTarget.style.borderColor = 'var(--color-ink)'; }}
                onMouseLeave={(e) => { if (playing !== kPast) e.currentTarget.style.borderColor = 'var(--color-border)'; }}
              >
                {past}
                <SpeakerIcon size={9} color={playing === kPast ? 'rgba(255,255,255,0.7)' : 'var(--color-ink-tertiary)'} isPlaying={playing === kPast} />
              </button>
            </>
          );
        })}
      </div>
    </div>
  );
}

/* ────────────────────────────────────────────────────────────────
   SlideView
──────────────────────────────────────────────────────────────── */
function SlideView({ slide, index, total }: { slide: SlideDto; index: number; total: number }) {
  const content = parseSlideContent(slide.content);
  const accent = getSlideAccent(slide.slideType);

  return (
    <div
      style={{
        background: 'var(--color-canvas)',
        borderRadius: 'var(--radius-2xl)',
        boxShadow: 'var(--shadow-md)',
        overflow: 'hidden',
        minHeight: 340,
        display: 'flex',
        flexDirection: 'column',
      }}
    >
      {/* Accent top bar */}
      <div style={{ height: 3, background: accent, flexShrink: 0 }} />

      <div
        style={{
          padding: 'var(--space-8)',
          display: 'flex',
          flexDirection: 'column',
          gap: 'var(--space-6)',
          flex: 1,
        }}
      >
        {/* Slide meta */}
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <span
            style={{
              display: 'inline-flex',
              alignItems: 'center',
              padding: '3px var(--space-3)',
              fontSize: 'var(--text-xs)',
              fontFamily: 'var(--font-mono)',
              fontWeight: 500,
              color: 'var(--color-ink-secondary)',
              background: 'var(--color-canvas-subtle)',
              borderRadius: 'var(--radius-full)',
              border: '1px solid var(--color-border)',
              letterSpacing: '0.02em',
            }}
          >
            {slide.slideType}
          </span>
          <span
            style={{
              fontSize: 'var(--text-xs)',
              fontFamily: 'var(--font-mono)',
              color: 'var(--color-ink-tertiary)',
            }}
          >
            {index + 1} / {total}
          </span>
        </div>

        {/* Rendered content */}
        <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
          {content.kind === 'intro' && (
            <IntroSlide
              heading={content.heading}
              subtitle={content.subtitle}
              lesson={content.lesson}
              title={slide.title}
            />
          )}
          {content.kind === 'closing' && (
            <ClosingSlide heading={content.heading} subtitle={content.subtitle} />
          )}
          {content.kind === 'list' && (
            <ListSlide heading={content.heading} points={content.points} examples={content.examples} />
          )}
          {content.kind === 'table' && (
            <TableSlide heading={content.heading} headers={content.headers} rows={content.rows} />
          )}
          {content.kind === 'sections' && (
            <SectionsSlide heading={content.heading} sections={content.sections} />
          )}
          {content.kind === 'rules' && (
            <RulesSlide heading={content.heading} rules={content.rules} />
          )}
          {content.kind === 'words' && (
            <WordsSlide
              heading={content.heading}
              description={content.description}
              words={content.words}
              example={content.example}
            />
          )}
          {content.kind === 'practice' && (
            <PracticeSlide heading={content.heading} activities={content.activities} />
          )}
          {content.kind === 'contractions' && (
            <ContractionsSlide heading={content.heading} items={content.items} />
          )}
          {content.kind === 'pairs' && (
            <PairsSlide heading={content.heading} pairs={content.pairs} />
          )}
          {content.kind === 'example' && (
            <ExampleSlide heading={content.heading} example={content.example} explanation={content.explanation} />
          )}
          {content.kind === 'generic' && (
            <GenericSlide heading={content.heading} text={content.text} title={slide.title} />
          )}
          {content.kind === 'plain' && (
            <GenericSlide heading={undefined} text={content.text} title={slide.title} />
          )}
        </div>

        {/* Image */}
        {slide.imageUrl && (
          <img
            src={slide.imageUrl}
            alt={slide.title}
            style={{ borderRadius: 'var(--radius-lg)', maxHeight: 180, objectFit: 'cover', width: '100%' }}
          />
        )}
      </div>
    </div>
  );
}

/* ────────────────────────────────────────────────────────────────
   Progress bar
──────────────────────────────────────────────────────────────── */
function ProgressBar({ current, total }: { current: number; total: number }) {
  const pct = total > 0 ? ((current + 1) / total) * 100 : 0;
  return (
    <div style={{ height: 2, background: 'var(--color-border)', borderRadius: 'var(--radius-full)', overflow: 'hidden' }}>
      <div
        style={{
          height: '100%',
          width: `${pct}%`,
          background: 'var(--gradient-develop)',
          borderRadius: 'var(--radius-full)',
          transition: 'width var(--transition-slow)',
        }}
      />
    </div>
  );
}

/* ────────────────────────────────────────────────────────────────
   LessonDetailPage
──────────────────────────────────────────────────────────────── */
export function LessonDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { data: lesson, isLoading, error } = useLessonDetail(id!);
  const user = useUserStore((s) => s.user);
  const [slideIndex, setSlideIndex] = useState(0);
  const [showExercises, setShowExercises] = useState(false);

  const slides = lesson ? [...lesson.slides].sort((a, b) => a.orderIndex - b.orderIndex) : [];

  const exercises = lesson
    ? [...lesson.exercises].sort((a, b) => {
        const aIsMc = a.exerciseType === 'MultipleChoice' ? 0 : 1;
        const bIsMc = b.exerciseType === 'MultipleChoice' ? 0 : 1;
        if (aIsMc !== bIsMc) return aIsMc - bIsMc;
        return a.orderIndex - b.orderIndex;
      })
    : [];

  const currentSlide = slides[slideIndex];
  const isLastSlide = slideIndex === slides.length - 1;

  const levelVariant = lesson?.level === 'Beginner' ? 'success' : lesson?.level === 'Advanced' ? 'error' : 'warning';

  return (
    <div style={{ maxWidth: 720, margin: '0 auto', display: 'flex', flexDirection: 'column', gap: 'var(--space-6)' }}>

      {/* Back + Title — always rendered so tests can locate h1 immediately */}
      <div>
        <button
          onClick={() => navigate('/lessons')}
          style={{
            display: 'inline-flex',
            alignItems: 'center',
            gap: 'var(--space-1)',
            fontSize: 'var(--text-sm)',
            color: 'var(--color-ink-tertiary)',
            background: 'none',
            border: 'none',
            cursor: 'pointer',
            padding: 0,
            marginBottom: 'var(--space-4)',
            transition: 'color var(--transition-fast)',
            letterSpacing: '-0.01em',
          }}
          onMouseEnter={(e) => (e.currentTarget.style.color = 'var(--color-ink)')}
          onMouseLeave={(e) => (e.currentTarget.style.color = 'var(--color-ink-tertiary)')}
        >
          ← Lessons
        </button>

        <div style={{ display: 'flex', alignItems: 'center', gap: 'var(--space-3)' }}>
          <h1
            style={{
              fontSize: 'var(--text-2xl)',
              fontWeight: 'var(--weight-semibold)',
              color: 'var(--color-ink)',
              letterSpacing: '-0.04em',
              flex: 1,
              minHeight: '1.5rem',
              lineHeight: 'var(--leading-tight)',
            }}
          >
            {lesson?.title ?? ''}
          </h1>
          {lesson && <Badge variant={levelVariant}>{lesson.level}</Badge>}
        </div>
      </div>

      {/* Loading */}
      {isLoading && (
        <div style={{ display: 'flex', justifyContent: 'center', padding: 'var(--space-20)' }}>
          <Spinner size={28} />
        </div>
      )}

      {/* Error */}
      {!isLoading && (error || !lesson) && (
        <div
          style={{
            background: 'var(--color-error-bg)',
            border: '1px solid var(--color-error-border)',
            borderRadius: 'var(--radius-lg)',
            padding: 'var(--space-4)',
            color: 'var(--color-error)',
            fontSize: 'var(--text-sm)',
          }}
        >
          {error?.message ?? 'Lesson not found'}
        </div>
      )}

      {lesson && (
        <>
          {/* Tab bar */}
          <div
            style={{
              display: 'flex',
              gap: 'var(--space-1)',
              background: 'var(--color-canvas-subtle)',
              borderRadius: 'var(--radius-xl)',
              padding: 4,
              boxShadow: 'var(--shadow-xs)',
            }}
          >
            {(['Slides', 'Exercises'] as const).map((tab) => {
              const active = tab === 'Slides' ? !showExercises : showExercises;
              return (
                <button
                  key={tab}
                  onClick={() => setShowExercises(tab === 'Exercises')}
                  style={{
                    flex: 1,
                    padding: 'var(--space-2) var(--space-4)',
                    fontSize: 'var(--text-sm)',
                    fontWeight: active ? 'var(--weight-semibold)' : 'var(--weight-normal)',
                    color: active ? 'var(--color-ink)' : 'var(--color-ink-secondary)',
                    background: active ? 'var(--color-canvas)' : 'transparent',
                    border: 'none',
                    borderRadius: 'var(--radius-lg)',
                    cursor: 'pointer',
                    transition: 'all var(--transition-fast)',
                    boxShadow: active ? 'var(--shadow-sm)' : 'none',
                    letterSpacing: '-0.01em',
                  }}
                >
                  {tab} {tab === 'Slides' ? `(${slides.length})` : `(${exercises.length})`}
                </button>
              );
            })}
          </div>

          {/* ── Slides panel ── */}
          {!showExercises && (
            <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
              <ProgressBar current={slideIndex} total={slides.length} />

              {currentSlide && (
                <SlideView slide={currentSlide} index={slideIndex} total={slides.length} />
              )}

              {/* Navigation */}
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <Button
                  variant="secondary"
                  onClick={() => setSlideIndex((i) => i - 1)}
                  disabled={slideIndex === 0}
                >
                  ← Previous
                </Button>

                {/* Dot indicators */}
                <div style={{ display: 'flex', gap: 'var(--space-1)', alignItems: 'center' }}>
                  {slides.map((_, i) => (
                    <button
                      key={i}
                      onClick={() => setSlideIndex(i)}
                      aria-label={`Go to slide ${i + 1}`}
                      style={{
                        width: i === slideIndex ? 20 : 6,
                        height: 6,
                        borderRadius: 'var(--radius-full)',
                        background: i === slideIndex ? 'var(--color-ink)' : 'var(--color-border-strong)',
                        border: 'none',
                        cursor: 'pointer',
                        padding: 0,
                        transition: 'all var(--transition-slow)',
                        flexShrink: 0,
                      }}
                    />
                  ))}
                </div>

                {isLastSlide ? (
                  <Button onClick={() => setShowExercises(true)}>Practice →</Button>
                ) : (
                  <Button onClick={() => setSlideIndex((i) => i + 1)}>Next →</Button>
                )}
              </div>
            </div>
          )}

          {/* ── Exercises panel ── */}
          {showExercises && (
            <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
              {!user && exercises.length > 0 && (
                <div
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: 'var(--space-3)',
                    padding: 'var(--space-4)',
                    background: 'var(--color-canvas-soft)',
                    borderRadius: 'var(--radius-lg)',
                    border: '1px solid var(--color-border)',
                  }}
                >
                  <span style={{ fontSize: 20, flexShrink: 0 }}>👤</span>
                  <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)' }}>
                    <a
                      href="/setup"
                      style={{ color: 'var(--color-ink)', fontWeight: 'var(--weight-medium)', textDecoration: 'underline', textUnderlineOffset: 3 }}
                    >
                      Set up your profile
                    </a>
                    {' '}to track progress and submit answers.
                  </p>
                </div>
              )}

              {exercises.length === 0 ? (
                <div
                  style={{
                    textAlign: 'center',
                    padding: 'var(--space-16)',
                    color: 'var(--color-ink-tertiary)',
                    fontSize: 'var(--text-sm)',
                    background: 'var(--color-canvas-soft)',
                    borderRadius: 'var(--radius-xl)',
                    border: '1px dashed var(--color-border-strong)',
                  }}
                >
                  No exercises for this lesson yet.
                </div>
              ) : (
                exercises.map((exercise) => (
                  <ExerciseCard key={exercise.id} exercise={exercise} lessonId={lesson.id} />
                ))
              )}
            </div>
          )}
        </>
      )}
    </div>
  );
}
