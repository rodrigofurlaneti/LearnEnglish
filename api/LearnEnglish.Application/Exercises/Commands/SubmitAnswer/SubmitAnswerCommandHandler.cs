using LearnEnglish.Application.Common.Interfaces;
using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Entities.Exercises;
using LearnEnglish.Domain.Repositories;
using MediatR;

namespace LearnEnglish.Application.Exercises.Commands.SubmitAnswer;

public sealed class SubmitAnswerCommandHandler
    : IRequestHandler<SubmitAnswerCommand, Result<SubmitAnswerResponse>>
{
    private readonly IExerciseRepository _exerciseRepository;
    private readonly IUnitOfWork _unitOfWork;

    public SubmitAnswerCommandHandler(IExerciseRepository exerciseRepository, IUnitOfWork unitOfWork)
    {
        _exerciseRepository = exerciseRepository;
        _unitOfWork = unitOfWork;
    }

    public async Task<Result<SubmitAnswerResponse>> Handle(
        SubmitAnswerCommand request,
        CancellationToken cancellationToken)
    {
        var exercise = await _exerciseRepository.GetByIdAsync(request.ExerciseId, cancellationToken);
        if (exercise is null)
            return Result.Failure<SubmitAnswerResponse>(new Error("Exercise.NotFound", $"Exercise {request.ExerciseId} not found."));

        if (!exercise.IsActive)
            return Result.Failure<SubmitAnswerResponse>(new Error("Exercise.Inactive", "This exercise is no longer active."));

        var attempt = ExerciseAttempt.Record(request.UserId, exercise, request.UserAnswer);
        await _exerciseRepository.AddAttemptAsync(attempt, cancellationToken);
        await _unitOfWork.CommitAsync(cancellationToken);

        return Result.Success(new SubmitAnswerResponse(attempt.IsCorrect, exercise.Explanation));
    }
}
