import { useQuery } from '@tanstack/react-query';
import { lessonsApi } from '../api/lessons.api';

export const LESSONS_KEY = ['lessons'] as const;
export const LESSON_KEY = (id: string) => ['lessons', id] as const;

export function useLessons() {
  return useQuery({
    queryKey: LESSONS_KEY,
    queryFn: lessonsApi.getAll,
  });
}

export function useLessonDetail(id: string) {
  return useQuery({
    queryKey: LESSON_KEY(id),
    queryFn: () => lessonsApi.getById(id),
    enabled: Boolean(id),
  });
}
