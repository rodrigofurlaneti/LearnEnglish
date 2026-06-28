import { useState, useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Button, Input } from '../../../design-system';
import { useSubmitAnswer } from '../hooks/useSubmitAnswer';
import { useUserStore } from '../../../core/store/userStore';
import { showAnswerFeedback, toastError } from '../../../shared/utils/swal';
import type { ExerciseDto } from '../../../shared/types';

export interface ExerciseCardProps {
  exercise: ExerciseDto;
  lessonId: string;
  /** Called after the SweetAlert2 feedback closes (correct or not) */
  onAnswered?: (isCorrect: boolean) => void;
}

const schema = z.object({ answer: z.string().min(1, 'Please enter an answer') });
type FormValues = z.infer<typeof schema>;

const typeLabel: Record<string, string> = {
  FillBlank:      'Fill in the blank',
  FillInTheBlank: 'Fill in the blank',
  MultipleChoice: 'Multiple choice',
  IdentifyPast:   'Fill in the blank',
  Translation:    'Translation',
  Pronunciation:  'Pronunciation',
};

/* ────────────────────────────────────────────────────────────────
   MC option button
──────────────────────────────────────────────────────────────── */
function McOption({
  text, selected, correct, incorrect, disabled, onClick,
}: {
  text: string; selected: boolean; correct?: boolean;
  incorrect?: boolean; disabled: boolean; onClick: () => void;
}) {
  let bg = 'var(--color-canvas)';
  let border = 'var(--color-border)';
  let color = 'var(--color-ink)';

  if (correct)        { bg = '#dcfce7'; border = '#22c55e'; color = '#15803d'; }
  else if (incorrect) { bg = '#fee2e2'; border = '#ef4444'; color = '#b91c1c'; }
  else if (selected)  { bg = 'var(--color-ink)'; border = 'var(--color-ink)'; color = '#fff'; }

  return (
    <button
      disabled={disabled}
      onClick={onClick}
      style={{
        padding: 'var(--space-3) var(--space-4)',
        borderRadius: 'var(--radius-lg)',
        border: `1.5px solid ${border}`,
        background: bg, color,
        fontSize: 'var(--text-sm)',
        fontFamily: 'var(--font-sans)',
        fontWeight: selected || correct || incorrect ? 'var(--weight-medium)' : 'var(--weight-normal)',
        cursor: disabled ? 'default' : 'pointer',
        textAlign: 'left',
        transition: 'all var(--transition-fast)',
        letterSpacing: '-0.01em',
        display: 'flex', alignItems: 'center',
        justifyContent: 'space-between', gap: 8,
        width: '100%',
      }}
    >
      <span>{text}</span>
      {correct   && <span style={{ fontSize: 16 }}>✅</span>}
      {incorrect && <span style={{ fontSize: 16 }}>❌</span>}
    </button>
  );
}

/* ────────────────────────────────────────────────────────────────
   ExerciseCard
──────────────────────────────────────────────────────────────── */
export function ExerciseCard({ exercise, onAnswered }: ExerciseCardProps) {
  const user = useUserStore((s) => s.user);
  const {
    mutate, isPending,
    data: result, isSuccess,
    isError, error,
  } = useSubmitAnswer(exercise.id);

  const [mcSelected, setMcSelected] = useState<string>();
  const [alertShown, setAlertShown] = useState(false);

  const isMultipleChoice = exercise.exerciseType === 'MultipleChoice' && exercise.optionsJson;
  const options: string[] = (() => {
    try { return isMultipleChoice ? JSON.parse(exercise.optionsJson!) : []; }
    catch { return []; }
  })();

  const { register, handleSubmit, formState: { errors } } = useForm<FormValues>({
    resolver: zodResolver(schema),
  });

  /* ── Show SweetAlert2 on success, then advance ── */
  useEffect(() => {
    if (isSuccess && result && !alertShown) {
      setAlertShown(true);
      showAnswerFeedback({
        isCorrect:     result.isCorrect,
        correctAnswer: result.correctAnswer,
        explanation:   result.explanation,
      }).then(() => {
        onAnswered?.(result.isCorrect);
      });
    }
  }, [isSuccess, result, alertShown, onAnswered]);

  /* ── Toast on API error ── */
  useEffect(() => {
    if (isError && error) {
      toastError((error as Error).message ?? 'Erro ao enviar resposta. Tente novamente.');
    }
  }, [isError, error]);

  const submit = (answer: string) => {
    if (!user) return;
    mutate({ userId: user.id, userAnswer: answer });
  };

  const correctAnswer = result?.correctAnswer;

  return (
    <div
      style={{
        background: 'var(--color-canvas)',
        borderRadius: 'var(--radius-xl)',
        overflow: 'hidden',
        border: isSuccess
          ? `1.5px solid ${result?.isCorrect ? '#22c55e' : '#ef4444'}`
          : '1.5px solid var(--color-border)',
        transition: 'border-color .3s ease',
      }}
    >
      {/* Type label bar */}
      <div style={{
        padding: 'var(--space-3) var(--space-5)',
        background: 'var(--color-canvas-soft)',
        borderBottom: '1px solid var(--color-border)',
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      }}>
        <span style={{
          fontSize: 'var(--text-xs)', fontFamily: 'var(--font-mono)',
          color: 'var(--color-ink-tertiary)', letterSpacing: '0.02em',
        }}>
          {typeLabel[exercise.exerciseType] ?? exercise.exerciseType}
        </span>
        {isSuccess && result && (
          <span style={{
            fontSize: 'var(--text-xs)', fontWeight: 'var(--weight-semibold)',
            color: result.isCorrect ? '#15803d' : '#b91c1c',
          }}>
            {result.isCorrect ? '✅ Correct' : '❌ Incorrect'}
          </span>
        )}
      </div>

      <div style={{ padding: 'var(--space-5)', display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
        {/* Question */}
        <p style={{
          fontSize: 'var(--text-base)', fontWeight: 'var(--weight-medium)',
          color: 'var(--color-ink)', lineHeight: 'var(--leading-snug)',
          letterSpacing: '-0.01em', margin: 0,
        }}>
          {exercise.question}
        </p>

        {/* ── Multiple choice ── */}
        {isMultipleChoice && (
          <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-2)' }}>
            {options.map((opt) => (
              <McOption
                key={opt} text={opt}
                selected={!isSuccess && mcSelected === opt}
                correct={isSuccess && opt === correctAnswer}
                incorrect={isSuccess && opt === mcSelected && !result?.isCorrect}
                disabled={isPending || isSuccess}
                onClick={() => !isSuccess && setMcSelected(opt)}
              />
            ))}
            {user && !isSuccess && mcSelected && (
              <Button
                onClick={() => submit(mcSelected)}
                loading={isPending}
                size="sm"
                style={{ marginTop: 'var(--space-1)' }}
              >
                Confirmar
              </Button>
            )}
          </div>
        )}

        {/* ── Free-text ── */}
        {!isMultipleChoice && user && !isSuccess && (
          <form
            onSubmit={handleSubmit((v) => submit(v.answer))}
            style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-3)' }}
          >
            <Input
              {...register('answer')}
              placeholder="Digite sua resposta…"
              error={errors.answer?.message}
              disabled={isPending}
              autoComplete="off"
            />
            <Button type="submit" loading={isPending} size="sm">Confirmar</Button>
          </form>
        )}

        {/* ── Inline result ── */}
        {isSuccess && result && (
          <div style={{
            padding: 'var(--space-4)',
            borderRadius: 'var(--radius-lg)',
            background: result.isCorrect ? '#f0fdf4' : '#fef2f2',
            border: `1px solid ${result.isCorrect ? '#bbf7d0' : '#fecaca'}`,
            display: 'flex', flexDirection: 'column', gap: 'var(--space-2)',
          }}>
            <strong style={{
              fontSize: 'var(--text-sm)', fontWeight: 'var(--weight-semibold)',
              color: result.isCorrect ? '#15803d' : '#b91c1c',
            }}>
              {result.isCorrect ? '🎉 Correto!' : '❌ Não foi dessa vez'}
            </strong>
            {!result.isCorrect && result.correctAnswer && (
              <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)', margin: 0 }}>
                Resposta correta:{' '}
                <strong style={{ color: 'var(--color-ink)', fontFamily: 'var(--font-mono)' }}>
                  {result.correctAnswer}
                </strong>
              </p>
            )}
            {result.explanation && (
              <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)', margin: 0 }}>
                {result.explanation}
              </p>
            )}
          </div>
        )}

        {/* ── No user prompt ── */}
        {!user && (
          <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-tertiary)', margin: 0 }}>
            <a href="/setup" style={{
              color: 'var(--color-ink)', fontWeight: 'var(--weight-medium)',
              textDecoration: 'underline', textUnderlineOffset: 3,
            }}>
              Configure seu perfil
            </a>{' '}
            para responder e acompanhar seu progresso.
          </p>
        )}
      </div>
    </div>
  );
}
