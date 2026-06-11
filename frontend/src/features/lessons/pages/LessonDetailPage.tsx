import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useLessonDetail } from '../hooks/useLessons';
import { Button, Badge, Spinner } from '../../../design-system';
import { ExerciseCard } from '../../exercises/components/ExerciseCard';
import { useUserStore } from '../../../core/store/userStore';
import type { SlideDto } from '../../../shared/types';

/* ────────────────────────────────────────────────────────────────
   Slide content parser
   The `content` field from the API can be:
   - Plain text
   - JSON: { heading, subtitle, lesson }         ← Intro
   - JSON: { heading, points: string[] }          ← Theory / list
   - JSON: { heading, example, explanation }      ← Example
   - JSON: { heading, text }                      ← Generic
──────────────────────────────────────────────────────────────── */
type SlideContentParsed =
  | { kind: 'intro'; heading: string; subtitle?: string; lesson?: string }
  | { kind: 'list'; heading: string; points: string[] }
  | { kind: 'example'; heading: string; example: string; explanation?: string }
  | { kind: 'generic'; heading?: string; text: string }
  | { kind: 'plain'; text: string };

function parseSlideContent(raw: string): SlideContentParsed {
  try {
    const p = JSON.parse(raw);
    if (p && typeof p === 'object') {
      if (p.subtitle !== undefined || p.lesson !== undefined) {
        return { kind: 'intro', heading: p.heading ?? '', subtitle: p.subtitle, lesson: p.lesson };
      }
      if (Array.isArray(p.points) && p.points.length > 0) {
        return { kind: 'list', heading: p.heading ?? '', points: p.points as string[] };
      }
      if (p.example !== undefined) {
        return { kind: 'example', heading: p.heading ?? '', example: String(p.example), explanation: p.explanation };
      }
      if (p.heading !== undefined || p.text !== undefined) {
        return { kind: 'generic', heading: p.heading, text: p.text ?? '' };
      }
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
  Intro: 'var(--gradient-develop)',
  Theory: 'var(--gradient-preview)',
  Example: 'var(--gradient-ship)',
  Practice: 'var(--gradient-develop)',
  Review: 'var(--gradient-preview)',
};

function getSlideAccent(type: string) {
  return slideAccent[type] ?? 'var(--gradient-brand)';
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

      <div style={{ padding: 'var(--space-8)', display: 'flex', flexDirection: 'column', gap: 'var(--space-6)', flex: 1 }}>
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
            <IntroSlide heading={content.heading} subtitle={content.subtitle} lesson={content.lesson} title={slide.title} />
          )}
          {content.kind === 'list' && (
            <ListSlide heading={content.heading} points={content.points} />
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

function IntroSlide({ heading, subtitle, lesson, title }: { heading: string; subtitle?: string; lesson?: string; title: string }) {
  const displayHeading = heading || title;
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-3)', paddingTop: 'var(--space-4)' }}>
      <h2
        style={{
          fontSize: 'var(--text-3xl)',
          fontWeight: 'var(--weight-semibold)',
          color: 'var(--color-ink)',
          letterSpacing: '-0.04em',
          lineHeight: 'var(--leading-tight)',
        }}
      >
        {displayHeading}
      </h2>
      {subtitle && (
        <p style={{ fontSize: 'var(--text-base)', color: 'var(--color-ink-secondary)', lineHeight: 'var(--leading-relaxed)' }}>
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

function ListSlide({ heading, points }: { heading: string; points: string[] }) {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      {heading && (
        <h2
          style={{
            fontSize: 'var(--text-xl)',
            fontWeight: 'var(--weight-semibold)',
            color: 'var(--color-ink)',
            letterSpacing: '-0.03em',
            lineHeight: 'var(--leading-snug)',
          }}
        >
          {heading}
        </h2>
      )}
      <ul style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-3)', listStyle: 'none', padding: 0 }}>
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
    </div>
  );
}

function ExampleSlide({ heading, example, explanation }: { heading: string; example: string; explanation?: string }) {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      {heading && (
        <h2
          style={{
            fontSize: 'var(--text-xl)',
            fontWeight: 'var(--weight-semibold)',
            color: 'var(--color-ink)',
            letterSpacing: '-0.03em',
          }}
        >
          {heading}
        </h2>
      )}
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
        <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)', lineHeight: 'var(--leading-relaxed)' }}>
          {explanation}
        </p>
      )}
    </div>
  );
}

function GenericSlide({ heading, text, title }: { heading?: string; text: string; title: string }) {
  const displayHeading = heading || title;
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
      <h2
        style={{
          fontSize: 'var(--text-xl)',
          fontWeight: 'var(--weight-semibold)',
          color: 'var(--color-ink)',
          letterSpacing: '-0.03em',
          lineHeight: 'var(--leading-snug)',
        }}
      >
        {displayHeading}
      </h2>
      {text && (
        <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)', lineHeight: 'var(--leading-relaxed)' }}>
          {text}
        </p>
      )}
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

  // Sort MC first so .first() Submit button is always free-text when no option is selected
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
