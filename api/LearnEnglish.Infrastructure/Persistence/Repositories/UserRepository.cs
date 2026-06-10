using LearnEnglish.Domain.Entities.Users;
using LearnEnglish.Domain.Repositories;
using LearnEnglish.Domain.ValueObjects;
using Microsoft.EntityFrameworkCore;

namespace LearnEnglish.Infrastructure.Persistence.Repositories;

public sealed class UserRepository(AppDbContext context)
    : BaseRepository<User>(context), IUserRepository
{
    // Override to eagerly load Progress (needed by UpdateProgressHandler)
    public override async Task<User?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default) =>
        await Context.Users
            .Include(u => u.Progress)
            .FirstOrDefaultAsync(u => u.Id == id, cancellationToken);

    public async Task<User?> GetByEmailAsync(Email email, CancellationToken cancellationToken = default) =>
        await Context.Users
            .AsNoTracking()
            .FirstOrDefaultAsync(u => u.Email.Value == email.Value, cancellationToken);

    public async Task<bool> ExistsByEmailAsync(Email email, CancellationToken cancellationToken = default) =>
        await Context.Users
            .AsNoTracking()
            .AnyAsync(u => u.Email.Value == email.Value, cancellationToken);
}
