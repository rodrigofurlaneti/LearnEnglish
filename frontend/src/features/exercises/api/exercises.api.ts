import { http } from '../../../core/http/client';
import type { SubmitAnswerResponse } from '../../../shared/types';

export interface SubmitAnswerRequest {
  userId: string;
  userAnswer: string;
}

export const exercisesApi = {
  submitAnswer: async (exerciseId: string, body: SubmitAnswerRequest): Promise<SubmitAnswerResponse> => {
    const { data } = await http.post<SubmitAnswerResponse>(`/exercises/${exerciseId}/submit`, body);
    return data;
  },
};
