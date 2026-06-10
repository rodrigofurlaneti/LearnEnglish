using LearnEnglish.Domain.Entities.Users;
using LearnEnglish.Domain.ValueObjects;

namespace LearnEnglish.Domain.Repositories;

public interface IUserRepository : IRepository<User>
{
    Task<User?> GetByEmailAsync(Email email, CancellationToken cancellationToken = default);
    Task<bool> ExistsByEmailAsync(Email email, CancellationToken cancellationToken = default);
}
