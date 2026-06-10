using MediatR;
using LearnEnglish.Domain.Common;

namespace LearnEnglish.Application.Lessons.Queries.GetLessonById;

public sealed record GetLessonByIdQuery(Guid LessonId) : IRequest<Result<LessonDetailDto>>;
