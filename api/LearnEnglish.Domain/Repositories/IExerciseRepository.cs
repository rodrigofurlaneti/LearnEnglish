using LearnEnglish.Domain.Entities.Exercises;

namespace LearnEnglish.Domain.Repositories;

public interface IExerciseRepository : IRepository<Exercise>
{
    Task<IReadOnlyList<Exercise>> GetByLessonIdAsync(Guid lessonId, CancellationToken cancellationToken = default);
    Task AddAttemptAsync(ExerciseAttempt attempt, CancellationToken cancellationToken = default);
    Task AddInteractionAsync(WordInteraction interaction, CancellationToken cancellationToken = default);
}
