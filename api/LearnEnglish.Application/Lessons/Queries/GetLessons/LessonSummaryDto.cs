namespace LearnEnglish.Application.Lessons.Queries.GetLessons;

public sealed record LessonSummaryDto(
    Guid Id,
    string Title,
    string Description,
    string Level,
    int DurationMinutes,
    int SlidesCount,
    int ExercisesCount);
