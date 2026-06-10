import { useMutation } from '@tanstack/react-query';
import { exercisesApi } from '../api/exercises.api';
import type { SubmitAnswerRequest } from '../api/exercises.api';

export function useSubmitAnswer(exerciseId: string) {
  return useMutation({
    mutationFn: (body: SubmitAnswerRequest) => exercisesApi.submitAnswer(exerciseId, body),
  });
}
