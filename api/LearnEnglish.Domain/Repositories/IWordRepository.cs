using LearnEnglish.Domain.Entities.Words;

namespace LearnEnglish.Domain.Repositories;

public interface IWordRepository : IRepository<Word>
{
    Task<IReadOnlyList<Word>> GetByLessonIdAsync(Guid lessonId, CancellationToken cancellationToken = default);
}
