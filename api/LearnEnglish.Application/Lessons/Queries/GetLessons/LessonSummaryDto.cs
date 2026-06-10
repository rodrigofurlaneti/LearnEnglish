namespace LearnEnglish.Application.Lessons.Queries.GetLessons;

public sealed record LessonSummaryDto(
    Guid LessonId,
    int LessonNumber,
    string Title,
    string Topic,
    string Description,
    int OrderIndex,
    int TotalSlides);
