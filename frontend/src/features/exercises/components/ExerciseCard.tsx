import { useState } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Button, Input } from '../../../design-system';
import { useSubmitAnswer } from '../hooks/useSubmitAnswer';
import { useUserStore } from '../../../core/store/userStore';
import type { ExerciseDto } from '../../../shared/types';

interface ExerciseCardProps {
  exercise: ExerciseDto;
  lessonId: string;
}

const schema = z.object({ answer: z.string().min(1, 'Please enter an answer') });
type FormValues = z.infer<typeof schema>;

const typeLabel: Record<string, string> = {
  FillBlank: 'Fill in the blank',
  FillInTheBlank: 'Fill in the blank',
  MultipleChoice: 'Multiple choice',
  IdentifyPast: 'Fill in the blank',
  Translation: 'Translation',
  Pronunciation: 'Pronunciation',
};

/* ────────────────────────────────────────────────────────────────
   MC option button
──────────────────────────────────────────────────────────────── */
function McOption({
  text,
  selected,
  disabled,
  onClick,
}: {
  text: string;
  selected: boolean;
  disabled: boolean;
  onClick: () => void;
}) {
  return (
    <button
      disabled={disabled}
      onClick={onClick}
      style={{
        padding: 'var(--space-3) var(--space-4)',
        borderRadius: 'var(--radius-lg)',
        border: `1.5px solid ${selected ? 'var(--color-ink)' : 'var(--color-border)'}`,
        background: selected ? 'var(--color-ink)' : 'var(--color-canvas)',
        color: selected ? '#fff' : 'var(--color-ink)',
        fontSize: 'var(--text-sm)',
        fontFamily: 'var(--font-sans)',
        fontWeight: selected ? 'var(--weight-medium)' : 'var(--weight-normal)',
        cursor: disabled ? 'default' : 'pointer',
        textAlign: 'left',
        transition: 'all var(--transition-fast)',
        opacity: disabled && !selected ? 0.55 : 1,
        letterSpacing: '-0.01em',
        boxShadow: selected ? 'none' : 'var(--shadow-xs)',
      }}
    >
      {text}
    </button>
  );
}

/* ────────────────────────────────────────────────────────────────
   ExerciseCard
──────────────────────────────────────────────────────────────── */
export function ExerciseCard({ exercise }: ExerciseCardProps) {
  const user = useUserStore((s) => s.user);
  const { mutate, isPending, data: result, isSuccess } = useSubmitAnswer(exercise.id);
  const [mcSelected, setMcSelected] = useState<string>();

  const isMultipleChoice = exercise.exerciseType === 'MultipleChoice' && exercise.optionsJson;
  const options: string[] = (() => {
    try { return isMultipleChoice ? JSON.parse(exercise.optionsJson!) : []; }
    catch { return []; }
  })();

  const { register, handleSubmit, formState: { errors } } = useForm<FormValues>({ resolver: zodResolver(schema) });

  const submit = (answer: string) => {
    if (!user) return;
    mutate({ userId: user.id, userAnswer: answer });
  };

  return (
    <div
      style={{
        background: 'var(--color-canvas)',
        borderRadius: 'var(--radius-xl)',
        boxShadow: 'var(--shadow-sm)',
        overflow: 'hidden',
      }}
    >
      {/* Type label bar */}
      <div
        style={{
          padding: 'var(--space-3) var(--space-5)',
          background: 'var(--color-canvas-soft)',
          borderBottom: '1px solid var(--color-border)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
        }}
      >
        <span
          style={{
            fontSize: 'var(--text-xs)',
            fontFamily: 'var(--font-mono)',
            color: 'var(--color-ink-tertiary)',
            letterSpacing: '0.02em',
          }}
        >
          {typeLabel[exercise.exerciseType] ?? exercise.exerciseType}
        </span>
        {isSuccess && result && (
          <span style={{ fontSize: 'var(--text-xs)', fontWeight: 'var(--weight-medium)', color: result.isCorrect ? 'var(--color-success)' : 'var(--color-error)' }}>
            {result.isCorrect ? '✓ Correct' : '✗ Incorrect'}
          </span>
        )}
      </div>

      <div style={{ padding: 'var(--space-5)', display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
        {/* Question */}
        <p
          style={{
            fontSize: 'var(--text-base)',
            fontWeight: 'var(--weight-medium)',
            color: 'var(--color-ink)',
            lineHeight: 'var(--leading-snug)',
            letterSpacing: '-0.01em',
          }}
        >
          {exercise.question}
        </p>

        {/* Answer form — only when user exists and not yet answered */}
        {user && !isSuccess && (
          <>
            {isMultipleChoice ? (
              <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-2)' }}>
                {options.map((opt) => (
                  <McOption
                    key={opt}
                    text={opt}
                    selected={mcSelected === opt}
                    disabled={isPending}
                    onClick={() => setMcSelected(opt)}
                  />
                ))}
                {mcSelected && (
                  <Button onClick={() => mcSelected && submit(mcSelected)} loading={isPending} size="sm" style={{ marginTop: 'var(--space-1)' }}>
                    Submit
                  </Button>
                )}
              </div>
            ) : (
              <form onSubmit={handleSubmit((v) => submit(v.answer))} style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-3)' }}>
                <Input
                  {...register('answer')}
                  placeholder="Type your answer…"
                  error={errors.answer?.message}
                  disabled={isPending}
                  autoComplete="off"
                />
                <Button type="submit" loading={isPending} size="sm">Submit</Button>
              </form>
            )}
          </>
        )}

        {/* Result feedback */}
        {isSuccess && result && (
          <div
            style={{
              padding: 'var(--space-4)',
              borderRadius: 'var(--radius-lg)',
              background: result.isCorrect ? 'var(--color-success-bg)' : 'var(--color-error-bg)',
              border: `1px solid ${result.isCorrect ? 'var(--color-success-border)' : 'var(--color-error-border)'}`,
              display: 'flex',
              flexDirection: 'column',
              gap: 'var(--space-2)',
            }}
          >
            <strong
              style={{
                fontSize: 'var(--text-sm)',
                fontWeight: 'var(--weight-semibold)',
                color: result.isCorrect ? 'var(--color-success)' : 'var(--color-error)',
                letterSpacing: '-0.01em',
              }}
            >
              {result.isCorrect ? 'Correct!' : 'Not quite'}
            </strong>
            {!result.isCorrect && (
              <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)' }}>
                Correct answer:{' '}
                <strong style={{ color: 'var(--color-ink)', fontWeight: 'var(--weight-semibold)' }}>{result.correctAnswer}</strong>
              </p>
            )}
            {result.explanation && (
              <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)' }}>{result.explanation}</p>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
