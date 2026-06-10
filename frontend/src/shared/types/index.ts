export interface SlideDto {
  id: string;
  title: string;
  content: string;
  imageUrl?: string;
  audioUrl?: string;
  orderIndex: number;
  slideType: string;
}

export interface ExerciseDto {
  id: string;
  exerciseType: string;
  question: string;
  optionsJson?: string;
  explanation?: string;
  orderIndex: number;
}

export interface LessonSummaryDto {
  id: string;
  title: string;
  description?: string;
  level: string;
  durationMinutes: number;
  slidesCount: number;
  exercisesCount: number;
}

export interface LessonDetailDto extends LessonSummaryDto {
  slides: SlideDto[];
  exercises: ExerciseDto[];
}

export interface UserDto {
  id: string;
  name: string;
  email: string;
}

export interface SubmitAnswerResponse {
  isCorrect: boolean;
  correctAnswer: string;
  explanation?: string;
}
