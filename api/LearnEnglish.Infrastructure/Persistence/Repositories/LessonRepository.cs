using LearnEnglish.Domain.Entities.Lessons;
using LearnEnglish.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace LearnEnglish.Infrastructure.Persistence.Repositories;

public sealed class LessonRepository(AppDbContext context)
    : BaseRepository<Lesson>(context), ILessonRepository
{
    public async Task<Lesson?> GetByIdWithSlidesAsync(Guid id, CancellationToken cancellationToken = default) =>
        await Context.Lessons
            .AsNoTracking()
            .Include(l => l.Slides)
            .FirstOrDefaultAsync(l => l.Id == id, cancellationToken);

    public async Task<IReadOnlyList<Lesson>> GetAllActiveAsync(CancellationToken cancellationToken = default)
    {
        var lessons = await Context.Lessons
            .AsNoTracking()
            .Include(l => l.Slides)
            .Where(l => l.IsActive)
            .OrderBy(l => l.OrderIndex)
            .ToListAsync(cancellationToken);

        return lessons.AsReadOnly();
    }
}
