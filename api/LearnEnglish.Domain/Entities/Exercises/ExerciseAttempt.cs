using LearnEnglish.Domain.Common;

namespace LearnEnglish.Domain.Entities.Exercises;

public sealed class ExerciseAttempt : Entity
{
    public Guid UserId { get; private set; }
    public Guid ExerciseId { get; private set; }
    public string UserAnswer { get; private set; } = string.Empty;
    public bool IsCorrect { get; private set; }
    public DateTime AttemptedAt { get; private set; }

    private ExerciseAttempt() { }

    public static ExerciseAttempt Record(Guid userId, Exercise exercise, string userAnswer)
    {
        var isCorrect = exercise.CheckAnswer(userAnswer);
        var attempt = new ExerciseAttempt
        {
            UserId = userId,
            ExerciseId = exercise.Id,
            UserAnswer = userAnswer.Trim(),
            IsCorrect = isCorrect,
            AttemptedAt = DateTime.UtcNow
        };
        attempt.SetCreatedAt(DateTime.UtcNow);
        return attempt;
    }
}
