using LearnEnglish.Domain.Entities.Exercises;
using LearnEnglish.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace LearnEnglish.Infrastructure.Persistence.Repositories;

public sealed class ExerciseRepository(AppDbContext context)
    : BaseRepository<Exercise>(context), IExerciseRepository
{
    public async Task<IReadOnlyList<Exercise>> GetByLessonIdAsync(Guid lessonId, CancellationToken cancellationToken = default)
    {
        var exercises = await Context.Exercises
            .AsNoTracking()
            .Where(e => e.LessonId == lessonId && e.IsActive)
            .OrderBy(e => e.OrderIndex)
            .ToListAsync(cancellationToken);

        return exercises.AsReadOnly();
    }

    public async Task<Dictionary<Guid, int>> GetCountsByLessonIdsAsync(
        IEnumerable<Guid> lessonIds,
        CancellationToken cancellationToken = default)
    {
        var ids = lessonIds.ToList();
        return await Context.Exercises
            .AsNoTracking()
            .Where(e => ids.Contains(e.LessonId) && e.IsActive)
            .GroupBy(e => e.LessonId)
            .Select(g => new { LessonId = g.Key, Count = g.Count() })
            .ToDictionaryAsync(x => x.LessonId, x => x.Count, cancellationToken);
    }

    public async Task AddAttemptAsync(ExerciseAttempt attempt, CancellationToken cancellationToken = default) =>
        await Context.ExerciseAttempts.AddAsync(attempt, cancellationToken);

    public async Task AddInteractionAsync(WordInteraction interaction, CancellationToken cancellationToken = default) =>
        await Context.WordInteractions.AddAsync(interaction, cancellationToken);
}
