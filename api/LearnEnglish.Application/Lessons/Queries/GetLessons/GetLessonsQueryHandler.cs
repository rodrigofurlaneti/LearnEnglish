using LearnEnglish.Domain.Repositories;
using MediatR;

namespace LearnEnglish.Application.Lessons.Queries.GetLessons;

public sealed class GetLessonsQueryHandler
    : IRequestHandler<GetLessonsQuery, IReadOnlyList<LessonSummaryDto>>
{
    private readonly ILessonRepository _lessonRepository;

    public GetLessonsQueryHandler(ILessonRepository lessonRepository) =>
        _lessonRepository = lessonRepository;

    public async Task<IReadOnlyList<LessonSummaryDto>> Handle(
        GetLessonsQuery request,
        CancellationToken cancellationToken)
    {
        var lessons = await _lessonRepository.GetAllActiveAsync(cancellationToken);

        return lessons
            .Select(l => new LessonSummaryDto(
                l.Id,
                l.LessonNumber.Value,
                l.Title,
                l.Topic,
                l.Description,
                l.OrderIndex,
                l.Slides.Count))
            .ToList()
            .AsReadOnly();
    }
}
