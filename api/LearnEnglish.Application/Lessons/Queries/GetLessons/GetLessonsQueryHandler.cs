using LearnEnglish.Domain.Repositories;
using MediatR;

namespace LearnEnglish.Application.Lessons.Queries.GetLessons;

public sealed class GetLessonsQueryHandler
    : IRequestHandler<GetLessonsQuery, IReadOnlyList<LessonSummaryDto>>
{
    private readonly ILessonRepository _lessonRepository;
    private readonly IExerciseRepository _exerciseRepository;

    public GetLessonsQueryHandler(ILessonRepository lessonRepository, IExerciseRepository exerciseRepository)
    {
        _lessonRepository = lessonRepository;
        _exerciseRepository = exerciseRepository;
    }

    public async Task<IReadOnlyList<LessonSummaryDto>> Handle(
        GetLessonsQuery request,
        CancellationToken cancellationToken)
    {
        var lessons = await _lessonRepository.GetAllActiveAsync(cancellationToken);
        var lessonIds = lessons.Select(l => l.Id);
        var exerciseCounts = await _exerciseRepository.GetCountsByLessonIdsAsync(lessonIds, cancellationToken);

        return lessons
            .Select(l => new LessonSummaryDto(
                l.Id,
                l.Title,
                l.Description,
                DeriveLevel(l.LessonNumber.Value),
                l.Slides.Count * 2,
                l.Slides.Count,
                exerciseCounts.GetValueOrDefault(l.Id, 0)))
            .ToList()
            .AsReadOnly();
    }

    private static string DeriveLevel(int lessonNumber) => lessonNumber switch
    {
        <= 2 => "Beginner",
        <= 4 => "Intermediate",
        _    => "Advanced",
    };
}
