namespace LearnEnglish.Application.Lessons.Queries.GetLessonById;

public sealed record LessonDetailDto(
    Guid LessonId,
    int LessonNumber,
    string Title,
    string Topic,
    string Description,
    int OrderIndex,
    IReadOnlyList<SlideDto> Slides,
    IReadOnlyList<ExerciseDto> Exercises);

public sealed record SlideDto(
    Guid SlideId,
    int OrderIndex,
    string? SlideTitle,
    string ContentType,
    string Content);

public sealed record ExerciseDto(
    Guid ExerciseId,
    string ExerciseType,
    string Question,
    string? OptionsJson,
    int OrderIndex);
