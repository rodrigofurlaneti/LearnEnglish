import { useNavigate } from 'react-router-dom';
import { useLessons } from '../hooks/useLessons';
import { Badge, Spinner } from '../../../design-system';
import type { LessonSummaryDto } from '../../../shared/types';

const levelVariant: Record<string, 'success' | 'warning' | 'error'> = {
  Beginner: 'success',
  Intermediate: 'warning',
  Advanced: 'error',
};

const levelGradient: Record<string, string> = {
  Beginner: 'var(--gradient-develop)',
  Intermediate: 'var(--gradient-preview)',
  Advanced: 'var(--gradient-ship)',
};

function LessonCard({ lesson }: { lesson: LessonSummaryDto }) {
  const navigate = useNavigate();
  const gradient = levelGradient[lesson.level] ?? 'var(--gradient-brand)';

  return (
    <div
      onClick={() => navigate(`/lessons/${lesson.id}`)}
      style={{
        background: 'var(--color-canvas)',
        borderRadius: 'var(--radius-xl)',
        boxShadow: 'var(--shadow-sm)',
        cursor: 'pointer',
        display: 'flex',
        flexDirection: 'column',
        overflow: 'hidden',
        transition: 'all var(--transition-base)',
        outline: 'none',
      }}
      onMouseEnter={(e) => {
        e.currentTarget.style.boxShadow = 'var(--shadow-lg)';
        e.currentTarget.style.transform = 'translateY(-3px)';
      }}
      onMouseLeave={(e) => {
        e.currentTarget.style.boxShadow = 'var(--shadow-sm)';
        e.currentTarget.style.transform = 'translateY(0)';
      }}
      role="button"
      tabIndex={0}
      onKeyDown={(e) => e.key === 'Enter' && navigate(`/lessons/${lesson.id}`)}
      aria-label={`Open lesson: ${lesson.title}`}
    >
      {/* Gradient accent strip */}
      <div style={{ height: 4, background: gradient, flexShrink: 0 }} />

      <div style={{ padding: 'var(--space-6)', display: 'flex', flexDirection: 'column', gap: 'var(--space-4)', flex: 1 }}>
        {/* Header row */}
        <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', gap: 'var(--space-3)' }}>
          <h3
            style={{
              fontSize: 'var(--text-base)',
              fontWeight: 'var(--weight-semibold)',
              color: 'var(--color-ink)',
              lineHeight: 'var(--leading-snug)',
              letterSpacing: '-0.02em',
              flex: 1,
            }}
          >
            {lesson.title}
          </h3>
          <Badge variant={levelVariant[lesson.level] ?? 'default'}>{lesson.level}</Badge>
        </div>

        {/* Description */}
        {lesson.description && (
          <p
            style={{
              fontSize: 'var(--text-sm)',
              color: 'var(--color-ink-secondary)',
              lineHeight: 'var(--leading-relaxed)',
              display: '-webkit-box',
              WebkitLineClamp: 2,
              // eslint-disable-next-line @typescript-eslint/no-explicit-any
              WebkitBoxOrient: 'vertical' as any,
              overflow: 'hidden',
              flex: 1,
            }}
          >
            {lesson.description}
          </p>
        )}

        {/* Stats footer */}
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            gap: 'var(--space-4)',
            paddingTop: 'var(--space-3)',
            borderTop: '1px solid var(--color-border)',
            marginTop: 'auto',
          }}
        >
          <Stat icon="🃏" value={lesson.slidesCount} label="slides" />
          <Stat icon="✏️" value={lesson.exercisesCount} label="exercises" />
          <Stat icon="⏱" value={lesson.durationMinutes} label="min" />
        </div>
      </div>
    </div>
  );
}

function Stat({ icon, value, label }: { icon: string; value: number; label: string }) {
  return (
    <span
      style={{
        display: 'flex',
        alignItems: 'center',
        gap: '4px',
        fontSize: 'var(--text-xs)',
        color: 'var(--color-ink-tertiary)',
        fontFamily: 'var(--font-mono)',
      }}
    >
      <span aria-hidden="true">{icon}</span>
      <strong style={{ color: 'var(--color-ink-secondary)', fontWeight: 'var(--weight-medium)', fontFamily: 'var(--font-sans)' }}>{value}</strong>
      {label}
    </span>
  );
}

export function LessonsPage() {
  const { data: lessons, isLoading, error } = useLessons();

  return (
    <div>
      {/* Header — always visible */}
      <div style={{ marginBottom: 'var(--space-8)' }}>
        <h1
          style={{
            fontSize: 'var(--text-3xl)',
            fontWeight: 'var(--weight-semibold)',
            color: 'var(--color-ink)',
            letterSpacing: '-0.04em',
            lineHeight: 'var(--leading-tight)',
          }}
        >
          Lessons
        </h1>
        <p style={{ marginTop: 'var(--space-2)', fontSize: 'var(--text-sm)', color: 'var(--color-ink-tertiary)' }}>
          {lessons?.length ?? 0} lessons available
        </p>
      </div>

      {/* Loading */}
      {isLoading && (
        <div style={{ display: 'flex', justifyContent: 'center', padding: 'var(--space-20)' }}>
          <Spinner size={28} />
        </div>
      )}

      {/* Error */}
      {error && (
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
          Failed to load lessons: {error.message}
        </div>
      )}

      {/* Grid */}
      {!isLoading && !error && (
        <>
          <div
            style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))',
              gap: 'var(--space-4)',
            }}
          >
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
