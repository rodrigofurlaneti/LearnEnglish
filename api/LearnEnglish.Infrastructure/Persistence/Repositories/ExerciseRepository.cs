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

    public async Task AddAttemptAsync(ExerciseAttempt attempt, CancellationToken cancellationToken = default) =>
        await Context.ExerciseAttempts.AddAsync(attempt, cancellationToken);

    public async Task AddInteractionAsync(WordInteraction interaction, CancellationToken cancellationToken = default) =>
        await Context.WordInteractions.AddAsync(interaction, cancellationToken);
}
