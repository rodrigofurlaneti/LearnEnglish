using MediatR;

namespace LearnEnglish.Application.Lessons.Queries.GetLessons;

public sealed record GetLessonsQuery : IRequest<IReadOnlyList<LessonSummaryDto>>;
