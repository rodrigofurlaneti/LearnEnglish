using LearnEnglish.Domain.Common;
using MediatR;

namespace LearnEnglish.Application.Progress.Commands.UpdateProgress;

public sealed record UpdateProgressCommand(
    Guid UserId,
    Guid LessonId,
    int CurrentSlide,
    bool IsCompleting = false,
    decimal? FinalScore = null) : IRequest<Result>;
