using LearnEnglish.Application.Common.Interfaces;
using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Repositories;
using MediatR;

namespace LearnEnglish.Application.Progress.Commands.UpdateProgress;

public sealed class UpdateProgressCommandHandler : IRequestHandler<UpdateProgressCommand, Result>
{
    private readonly IUserRepository _userRepository;
    private readonly IUnitOfWork _unitOfWork;

    public UpdateProgressCommandHandler(IUserRepository userRepository, IUnitOfWork unitOfWork)
    {
        _userRepository = userRepository;
        _unitOfWork = unitOfWork;
    }

    public async Task<Result> Handle(UpdateProgressCommand request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByIdAsync(request.UserId, cancellationToken);
        if (user is null)
            return Result.Failure(new Error("User.NotFound", $"User {request.UserId} not found."));

        var progress = user.Progress.FirstOrDefault(p => p.LessonId == request.LessonId);
        if (progress is null)
            return Result.Failure(new Error("Progress.NotFound", "No progress record found. Start the lesson first."));

        if (request.IsCompleting && request.FinalScore.HasValue)
        {
            var completeResult = progress.Complete(request.FinalScore.Value);
            if (completeResult.IsFailure)
                return completeResult;
        }

        _userRepository.Update(user);
        await _unitOfWork.CommitAsync(cancellationToken);
        return Result.Success();
    }
}
