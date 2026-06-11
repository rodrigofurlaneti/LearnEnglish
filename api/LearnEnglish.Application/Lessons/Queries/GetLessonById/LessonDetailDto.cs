namespace LearnEnglish.Application.Lessons.Queries.GetLessonById;

public sealed record LessonDetailDto(
    Guid Id,
    string Title,
    string Description,
    string Level,
    int DurationMinutes,
    int SlidesCount,
    int ExercisesCount,
    IReadOnlyList<SlideDto> Slides,
    IReadOnlyList<ExerciseDto> Exercises);

public sealed record SlideDto(
    Guid Id,
    string Title,
    string Content,
    string? ImageUrl,
    string? AudioUrl,
    int OrderIndex,
    string SlideType);

public sealed record ExerciseDto(
    Guid Id,
    string ExerciseType,
    string Question,
    string CorrectAnswer,
    string? OptionsJson,
    string? Explanation,
    int OrderIndex);
