using LearnEnglish.Application.Common.Interfaces;
using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Entities.Users;
using LearnEnglish.Domain.Repositories;
using LearnEnglish.Domain.ValueObjects;
using MediatR;

namespace LearnEnglish.Application.Users.Commands.CreateUser;

public sealed class CreateUserCommandHandler : IRequestHandler<CreateUserCommand, Result<Guid>>
{
    private readonly IUserRepository _userRepository;
    private readonly IUnitOfWork _unitOfWork;

    public CreateUserCommandHandler(IUserRepository userRepository, IUnitOfWork unitOfWork)
    {
        _userRepository = userRepository;
        _unitOfWork = unitOfWork;
    }

    public async Task<Result<Guid>> Handle(CreateUserCommand request, CancellationToken cancellationToken)
    {
        var emailResult = Email.Create(request.Email);
        if (emailResult.IsFailure)
            return Result.Failure<Guid>(emailResult.Error);

        // If email already registered, return existing user's ID (upsert / recovery flow)
        var existing = await _userRepository.GetByEmailAsync(emailResult.Value, cancellationToken);
        if (existing is not null)
            return Result.Success(existing.Id);

        var userResult = User.Create(request.Name, request.Email);
        if (userResult.IsFailure)
            return Result.Failure<Guid>(userResult.Error);

        await _userRepository.AddAsync(userResult.Value, cancellationToken);
        await _unitOfWork.CommitAsync(cancellationToken);

        return Result.Success(userResult.Value.Id);
    }
}
