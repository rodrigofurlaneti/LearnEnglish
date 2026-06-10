using LearnEnglish.Domain.Common;
using MediatR;

namespace LearnEnglish.Application.Users.Commands.CreateUser;

public sealed record CreateUserCommand(string Name, string Email) : IRequest<Result<Guid>>;
