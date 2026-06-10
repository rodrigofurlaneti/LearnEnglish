using LearnEnglish.Domain.Entities.Lessons;

namespace LearnEnglish.Domain.Repositories;

public interface ILessonRepository : IRepository<Lesson>
{
    Task<Lesson?> GetByIdWithSlidesAsync(Guid id, CancellationToken cancellationToken = default);
    Task<IReadOnlyList<Lesson>> GetAllActiveAsync(CancellationToken cancellationToken = default);
}
