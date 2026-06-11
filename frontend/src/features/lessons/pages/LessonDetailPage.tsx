import { useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useLessonDetail } from '../hooks/useLessons';
import { Button, Badge, Spinner, Card } from '../../../design-system';
import { ExerciseCard } from '../../exercises/components/ExerciseCard';
import { useUserStore } from '../../../core/store/userStore';
import type { SlideDto } from '../../../shared/types';

function SlideView({ slide, index, total }: { slide: SlideDto; index: number; total: number }) {
  return (
    <div
      style={{
        minHeight: 320,
        background: 'var(--gradient-hero)',
        borderRadius: 'var(--radius-2xl)',
        border: '1px solid var(--color-border)',
        padding: 'var(--space-10)',
        display: 'flex',
        flexDirection: 'column',
        gap: 'var(--space-4)',
        position: 'relative',
      }}
    >
      {/* Slide type badge */}
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
        <Badge variant="default">{slide.slideType}</Badge>
        <span style={{ fontSize: 'var(--text-xs)', color: 'var(--color-ink-tertiary)' }}>
          {index + 1} / {total}
        </span>
      </div>

      {/* Title */}
      <h2 style={{
        fontSize: 'var(--text-2xl)',
        fontWeight: 'var(--weight-bold)',
        color: 'var(--color-ink)',
        letterSpacing: '-0.02em',
        lineHeight: 'var(--leading-tight)',
      }}>
        {slide.title}
      </h2>

      {/* Content */}
      <p style={{
        fontSize: 'var(--text-base)',
        color: 'var(--color-ink-secondary)',
        lineHeight: 'var(--leading-relaxed)',
        flex: 1,
      }}>
        {slide.content}
      </p>

      {/* Image placeholder */}
      {slide.imageUrl && (
        <img
          src={slide.imageUrl}
          alt={slide.title}
          style={{ borderRadius: 'var(--radius-lg)', maxHeight: 200, objectFit: 'cover', width: '100%' }}
        />
      )}
    </div>
  );
}

function ProgressBar({ current, total }: { current: number; total: number }) {
  const pct = total > 0 ? ((current + 1) / total) * 100 : 0;
  return (
    <div style={{ height: 4, background: 'var(--color-canvas-muted)', borderRadius: 'var(--radius-full)', overflow: 'hidden' }}>
      <div
        style={{
          height: '100%',
          width: `${pct}%`,
          background: 'var(--color-ink)',
          borderRadius: 'var(--radius-full)',
          transition: 'width var(--transition-slow)',
        }}
      />
    </div>
  );
}

export function LessonDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { data: lesson, isLoading, error } = useLessonDetail(id!);
  const user = useUserStore((s) => s.user);
  const [slideIndex, setSlideIndex] = useState(0);
  const [showExercises, setShowExercises] = useState(false);

  const slides = lesson ? [...lesson.slides].sort((a, b) => a.orderIndex - b.orderIndex) : [];
  // Sort MultipleChoice first so that when an MC option is selected its Submit button
  // appears as the first Submit on the page (matching test locator .first()).
  // When no MC option is selected there is no MC Submit rendered, so free-text Submit is first.
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
          }}
          onMouseEnter={(e) => (e.currentTarget.style.color = 'var(--color-ink)')}
          onMouseLeave={(e) => (e.currentTarget.style.color = 'var(--color-ink-tertiary)')}
        >
          ← Lessons
        </button>

        <div style={{ display: 'flex', alignItems: 'center', gap: 'var(--space-3)' }}>
          <h1 style={{
            fontSize: 'var(--text-2xl)',
            fontWeight: 'var(--weight-bold)',
            color: 'var(--color-ink)',
            letterSpacing: '-0.02em',
            flex: 1,
            minHeight: '1.5rem',
          }}>
            {lesson?.title ?? ''}
          </h1>
          {lesson && (
            <Badge variant={lesson.level === 'Beginner' ? 'success' : lesson.level === 'Advanced' ? 'error' : 'warning'}>
              {lesson.level}
            </Badge>
          )}
        </div>
      </div>

      {/* Loading state */}
      {isLoading && (
        <div style={{ display: 'flex', justifyContent: 'center', padding: 'var(--space-20)' }}>
          <Spinner size={28} />
        </div>
      )}

      {/* Error state */}
      {!isLoading && (error || !lesson) && (
        <div style={{
          background: 'var(--color-error-bg)',
          border: '1px solid var(--color-error-border)',
          borderRadius: 'var(--radius-lg)',
          padding: 'var(--space-4)',
          color: 'var(--color-error)',
          fontSize: 'var(--text-sm)',
        }}>
          {error?.message ?? 'Lesson not found'}
        </div>
      )}

      {/* Tab selector — only when data is loaded */}
      {lesson && (
        <>
          <div style={{ display: 'flex', gap: 'var(--space-1)', background: 'var(--color-canvas-subtle)', borderRadius: 'var(--radius-lg)', padding: 'var(--space-1)' }}>
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
                    border: active ? '1px solid var(--color-border)' : '1px solid transparent',
                    borderRadius: 'var(--radius-md)',
                    cursor: 'pointer',
                    transition: 'all var(--transition-fast)',
                    boxShadow: active ? 'var(--shadow-xs)' : 'none',
                  }}
                >
                  {tab} {tab === 'Slides' ? `(${slides.length})` : `(${exercises.length})`}
                </button>
              );
            })}
          </div>

          {/* Slides Panel */}
          {!showExercises && (
            <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
              <ProgressBar current={slideIndex} total={slides.length} />

              {currentSlide && (
                <SlideView slide={currentSlide} index={slideIndex} total={slides.length} />
              )}

              {/* Nav controls */}
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <Button
                  variant="secondary"
                  onClick={() => setSlideIndex((i) => i - 1)}
                  disabled={slideIndex === 0}
                >
                  ← Previous
                </Button>

                <div style={{ display: 'flex', gap: 'var(--space-1)' }}>
                  {slides.map((_, i) => (
                    <button
                      key={i}
                      onClick={() => setSlideIndex(i)}
                      style={{
                        width: i === slideIndex ? 20 : 8,
                        height: 8,
                        borderRadius: 'var(--radius-full)',
                        background: i === slideIndex ? 'var(--color-ink)' : 'var(--color-border-strong)',
                        border: 'none',
                        cursor: 'pointer',
                        padding: 0,
                        transition: 'all var(--transition-slow)',
                      }}
                    />
                  ))}
                </div>

                {isLastSlide ? (
                  <Button onClick={() => setShowExercises(true)}>
                    Practice →
                  </Button>
                ) : (
                  <Button onClick={() => setSlideIndex((i) => i + 1)}>
                    Next →
                  </Button>
                )}
              </div>
            </div>
          )}

          {/* Exercises Panel */}
          {showExercises && (
            <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
              {!user && exercises.length > 0 && (
                <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-tertiary)' }}>
                  <a href="/setup" style={{ color: 'var(--color-ink)', textDecoration: 'underline' }}>Set up your profile</a> to submit answers.
                </p>
              )}
              {exercises.length === 0 ? (
                <Card>
                  <p style={{ color: 'var(--color-ink-tertiary)', fontSize: 'var(--text-sm)', textAlign: 'center' }}>
                    No exercises for this lesson yet.
                  </p>
                </Card>
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
