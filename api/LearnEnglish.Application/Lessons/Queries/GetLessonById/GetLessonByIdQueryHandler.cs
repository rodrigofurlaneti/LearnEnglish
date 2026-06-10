using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Repositories;
using MediatR;

namespace LearnEnglish.Application.Lessons.Queries.GetLessonById;

public sealed class GetLessonByIdQueryHandler
    : IRequestHandler<GetLessonByIdQuery, Result<LessonDetailDto>>
{
    private readonly ILessonRepository _lessonRepository;
    private readonly IExerciseRepository _exerciseRepository;

    public GetLessonByIdQueryHandler(
        ILessonRepository lessonRepository,
        IExerciseRepository exerciseRepository)
    {
        _lessonRepository = lessonRepository;
        _exerciseRepository = exerciseRepository;
    }

    public async Task<Result<LessonDetailDto>> Handle(
        GetLessonByIdQuery request,
        CancellationToken cancellationToken)
    {
        var lesson = await _lessonRepository.GetByIdWithSlidesAsync(request.LessonId, cancellationToken);
        if (lesson is null)
            return Result.Failure<LessonDetailDto>(new Error("Lesson.NotFound", $"Lesson {request.LessonId} not found."));

        var exercises = await _exerciseRepository.GetByLessonIdAsync(request.LessonId, cancellationToken);

        var slides = lesson.Slides
            .OrderBy(s => s.OrderIndex)
            .Select(s => new SlideDto(s.Id, s.OrderIndex, s.SlideTitle, s.ContentType.ToString(), s.Content.Json))
            .ToList()
            .AsReadOnly();

        var exerciseDtos = exercises
            .Where(e => e.IsActive)
            .OrderBy(e => e.OrderIndex)
            .Select(e => new ExerciseDto(e.Id, e.ExerciseType.ToString(), e.Question, e.OptionsJson, e.OrderIndex))
            .ToList()
            .AsReadOnly();

        var dto = new LessonDetailDto(
            lesson.Id,
            lesson.LessonNumber.Value,
            lesson.Title,
            lesson.Topic,
            lesson.Description,
            lesson.OrderIndex,
            slides,
            exerciseDtos);

        return Result.Success(dto);
    }
}
