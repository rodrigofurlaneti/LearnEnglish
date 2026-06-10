using LearnEnglish.Domain.Common;
using MediatR;

namespace LearnEnglish.Application.Exercises.Commands.SubmitAnswer;

public sealed record SubmitAnswerCommand(
    Guid UserId,
    Guid ExerciseId,
    string UserAnswer) : IRequest<Result<SubmitAnswerResponse>>;

public sealed record SubmitAnswerResponse(bool IsCorrect, string? Explanation);
