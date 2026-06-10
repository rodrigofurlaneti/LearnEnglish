import { http } from '../../../core/http/client';
import type { LessonDetailDto, LessonSummaryDto } from '../../../shared/types';

export const lessonsApi = {
  getAll: async (): Promise<LessonSummaryDto[]> => {
    const { data } = await http.get<LessonSummaryDto[]>('/lessons');
    return data;
  },

  getById: async (id: string): Promise<LessonDetailDto> => {
    const { data } = await http.get<LessonDetailDto>(`/lessons/${id}`);
    return data;
  },
};
