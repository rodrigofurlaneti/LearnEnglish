using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace LearnEnglish.Infrastructure.Persistence.Repositories;

public abstract class BaseRepository<T>(AppDbContext context) : IRepository<T>
    where T : Entity
{
    protected readonly AppDbContext Context = context;

    public virtual async Task<T?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default) =>
        await Context.Set<T>().FirstOrDefaultAsync(e => e.Id == id, cancellationToken);

    public async Task AddAsync(T entity, CancellationToken cancellationToken = default) =>
        await Context.Set<T>().AddAsync(entity, cancellationToken);

    public void Update(T entity) => Context.Set<T>().Update(entity);

    public void Remove(T entity) => Context.Set<T>().Remove(entity);
}
