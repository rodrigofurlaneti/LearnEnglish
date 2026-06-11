import { useNavigate } from 'react-router-dom';
import { useLessons } from '../hooks/useLessons';
import { Card, CardTitle, Badge, Spinner } from '../../../design-system';
import type { LessonSummaryDto } from '../../../shared/types';

const levelColor: Record<string, 'default' | 'success' | 'warning' | 'error'> = {
  Beginner: 'success',
  Intermediate: 'warning',
  Advanced: 'error',
};

function LessonCard({ lesson }: { lesson: LessonSummaryDto }) {
  const navigate = useNavigate();

  return (
    <Card
      hoverable
      onClick={() => navigate(`/lessons/${lesson.id}`)}
      style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-3)' }}
    >
      <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', gap: 'var(--space-2)' }}>
        <CardTitle style={{ fontSize: 'var(--text-base)' }}>{lesson.title}</CardTitle>
        <Badge variant={levelColor[lesson.level] ?? 'default'}>{lesson.level}</Badge>
      </div>

      {lesson.description && (
        <p style={{
          fontSize: 'var(--text-sm)',
          color: 'var(--color-ink-secondary)',
          lineHeight: 'var(--leading-relaxed)',
          display: '-webkit-box',
          WebkitLineClamp: 2,
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          WebkitBoxOrient: 'vertical' as any,
          overflow: 'hidden',
        }}>
          {lesson.description}
        </p>
      )}

      <div style={{
        display: 'flex',
        alignItems: 'center',
        gap: 'var(--space-4)',
        marginTop: 'auto',
        paddingTop: 'var(--space-2)',
        borderTop: '1px solid var(--color-border)',
      }}>
        <Stat icon="🃏" value={lesson.slidesCount} label="slides" />
        <Stat icon="✏️" value={lesson.exercisesCount} label="exercises" />
        <Stat icon="⏱" value={lesson.durationMinutes} label="min" />
      </div>
    </Card>
  );
}

function Stat({ icon, value, label }: { icon: string; value: number; label: string }) {
  return (
    <span style={{ display: 'flex', alignItems: 'center', gap: 'var(--space-1)', fontSize: 'var(--text-xs)', color: 'var(--color-ink-secondary)' }}>
      <span>{icon}</span>
      <strong style={{ color: 'var(--color-ink)', fontWeight: 'var(--weight-medium)' }}>{value}</strong>
      {label}
    </span>
  );
}

export function LessonsPage() {
  const { data: lessons, isLoading, error } = useLessons();

  return (
    <div>
      {/* Header — always visible so tests can locate the heading immediately */}
      <div style={{ marginBottom: 'var(--space-8)' }}>
        <h1 style={{
          fontSize: 'var(--text-3xl)',
          fontWeight: 'var(--weight-bold)',
          color: 'var(--color-ink)',
          letterSpacing: '-0.02em',
          lineHeight: 'var(--leading-tight)',
        }}>
          Lessons
        </h1>
        <p style={{ marginTop: 'var(--space-2)', fontSize: 'var(--text-base)', color: 'var(--color-ink-secondary)' }}>
          {lessons?.length ?? 0} lessons available
        </p>
      </div>

      {/* Loading state */}
      {isLoading && (
        <div style={{ display: 'flex', justifyContent: 'center', padding: 'var(--space-20)' }}>
          <Spinner size={28} />
        </div>
      )}

      {/* Error state */}
      {error && (
        <div style={{
          background: 'var(--color-error-bg)',
          border: '1px solid var(--color-error-border)',
          borderRadius: 'var(--radius-lg)',
          padding: 'var(--space-4)',
          color: 'var(--color-error)',
          fontSize: 'var(--text-sm)',
        }}>
          Failed to load lessons: {error.message}
        </div>
      )}

      {/* Grid */}
      {!isLoading && !error && (
        <>
          <div style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))',
            gap: 'var(--space-4)',
          }}>
            {lessons?.map((lesson) => (
              <LessonCard key={lesson.id} lesson={lesson} />
            ))}
          </div>

          {lessons?.length === 0 && (
            <div style={{ textAlign: 'center', padding: 'var(--space-20)', color: 'var(--color-ink-tertiary)' }}>
              No lessons yet.
            </div>
          )}
        </>
      )}
    </div>
  );
}
