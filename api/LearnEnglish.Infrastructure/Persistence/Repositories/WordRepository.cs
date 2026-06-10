using LearnEnglish.Domain.Entities.Words;
using LearnEnglish.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace LearnEnglish.Infrastructure.Persistence.Repositories;

public sealed class WordRepository(AppDbContext context)
    : BaseRepository<Word>(context), IWordRepository
{
    public async Task<IReadOnlyList<Word>> GetByLessonIdAsync(Guid lessonId, CancellationToken cancellationToken = default)
    {
        var words = await Context.LessonWords
            .AsNoTracking()
            .Where(lw => lw.LessonId == lessonId)
            .Join(Context.Words, lw => lw.WordId, w => w.Id, (_, w) => w)
            .ToListAsync(cancellationToken);

        return words.AsReadOnly();
    }
}
