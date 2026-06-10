import { useState } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Card, Button, Input, Badge } from '../../../design-system';
import { useSubmitAnswer } from '../hooks/useSubmitAnswer';
import { useUserStore } from '../../../core/store/userStore';
import type { ExerciseDto } from '../../../shared/types';

interface ExerciseCardProps {
  exercise: ExerciseDto;
  lessonId: string;
}

const schema = z.object({
  answer: z.string().min(1, 'Please enter an answer'),
});
type FormValues = z.infer<typeof schema>;

function MultipleChoiceForm({
  options,
  onSelect,
  selected,
  disabled,
}: {
  options: string[];
  onSelect: (v: string) => void;
  selected?: string;
  disabled: boolean;
}) {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-2)' }}>
      {options.map((opt) => {
        const isSelected = selected === opt;
        return (
          <button
            key={opt}
            disabled={disabled}
            onClick={() => onSelect(opt)}
            style={{
              padding: 'var(--space-3) var(--space-4)',
              borderRadius: 'var(--radius-md)',
              border: `1px solid ${isSelected ? 'var(--color-ink)' : 'var(--color-border-strong)'}`,
              background: isSelected ? 'var(--color-ink)' : 'var(--color-canvas)',
              color: isSelected ? '#fff' : 'var(--color-ink)',
              fontSize: 'var(--text-sm)',
              fontFamily: 'var(--font-sans)',
              cursor: disabled ? 'default' : 'pointer',
              textAlign: 'left',
              transition: 'all var(--transition-fast)',
              opacity: disabled && !isSelected ? 0.6 : 1,
            }}
          >
            {opt}
          </button>
        );
      })}
    </div>
  );
}

export function ExerciseCard({ exercise }: ExerciseCardProps) {
  const user = useUserStore((s) => s.user);
  const { mutate, isPending, data: result, isSuccess } = useSubmitAnswer(exercise.id);
  const [mcSelected, setMcSelected] = useState<string>();

  const isMultipleChoice = exercise.exerciseType === 'MultipleChoice' && exercise.optionsJson;
  const options: string[] = (() => {
    try { return isMultipleChoice ? JSON.parse(exercise.optionsJson!) : []; }
    catch { return []; }
  })();

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<FormValues>({ resolver: zodResolver(schema) });

  const submit = (answer: string) => {
    if (!user) return;
    mutate({ userId: user.id, userAnswer: answer });
  };

  const onFreeTextSubmit = (values: FormValues) => submit(values.answer);

  const onMcSubmit = () => {
    if (mcSelected) submit(mcSelected);
  };

  const typeLabel: Record<string, string> = {
    FillInTheBlank: 'Fill in the blank',
    MultipleChoice: 'Multiple choice',
    Translation: 'Translation',
    Pronunciation: 'Pronunciation',
  };

  return (
    <Card>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
        {/* Header */}
        <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', gap: 'var(--space-2)' }}>
          <p style={{
            fontSize: 'var(--text-base)',
            fontWeight: 'var(--weight-medium)',
            color: 'var(--color-ink)',
            lineHeight: 'var(--leading-snug)',
            flex: 1,
          }}>
            {exercise.question}
          </p>
          <Badge variant="outline">{typeLabel[exercise.exerciseType] ?? exercise.exerciseType}</Badge>
        </div>

        {/* Answer form — only if user exists and not yet answered */}
        {!user && (
          <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-tertiary)' }}>
            <a href="/setup" style={{ color: 'var(--color-ink)', textDecoration: 'underline' }}>Set up your profile</a> to submit answers.
          </p>
        )}

        {user && !isSuccess && (
          <>
            {isMultipleChoice ? (
              <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-3)' }}>
                <MultipleChoiceForm
                  options={options}
                  onSelect={setMcSelected}
                  selected={mcSelected}
                  disabled={isPending}
                />
                <Button
                  onClick={onMcSubmit}
                  loading={isPending}
                  disabled={!mcSelected}
                  size="sm"
                >
                  Submit
                </Button>
              </div>
            ) : (
              <form onSubmit={handleSubmit(onFreeTextSubmit)} style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-3)' }}>
                <Input
                  {...register('answer')}
                  placeholder="Type your answer…"
                  error={errors.answer?.message}
                  disabled={isPending}
                  autoComplete="off"
                />
                <Button type="submit" loading={isPending} size="sm">
                  Submit
                </Button>
              </form>
            )}
          </>
        )}

        {/* Result feedback */}
        {isSuccess && result && (
          <div style={{
            padding: 'var(--space-4)',
            borderRadius: 'var(--radius-lg)',
            background: result.isCorrect ? 'var(--color-success-bg)' : 'var(--color-error-bg)',
            border: `1px solid ${result.isCorrect ? 'var(--color-success-border)' : 'var(--color-error-border)'}`,
            display: 'flex',
            flexDirection: 'column',
            gap: 'var(--space-2)',
          }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 'var(--space-2)' }}>
              <span style={{ fontSize: 'var(--text-lg)' }}>{result.isCorrect ? '✅' : '❌'}</span>
              <strong style={{
                fontSize: 'var(--text-sm)',
                fontWeight: 'var(--weight-semibold)',
                color: result.isCorrect ? 'var(--color-success)' : 'var(--color-error)',
              }}>
                {result.isCorrect ? 'Correct!' : 'Not quite'}
              </strong>
            </div>
            {!result.isCorrect && (
              <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)' }}>
                Correct answer: <strong style={{ color: 'var(--color-ink)' }}>{result.correctAnswer}</strong>
              </p>
            )}
            {result.explanation && (
              <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)' }}>{result.explanation}</p>
            )}
          </div>
        )}
      </div>
    </Card>
  );
}
