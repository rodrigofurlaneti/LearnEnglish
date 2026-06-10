using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Enums;

namespace LearnEnglish.Domain.Entities.Exercises;

public sealed class Exercise : Entity
{
    public Guid LessonId { get; private set; }
    public ExerciseType ExerciseType { get; private set; }
    public string Question { get; private set; } = string.Empty;
    public string CorrectAnswer { get; private set; } = string.Empty;
    public string? OptionsJson { get; private set; }
    public string? Explanation { get; private set; }
    public int OrderIndex { get; private set; }
    public bool IsActive { get; private set; }

    private Exercise() { }

    public static Result<Exercise> Create(
        Guid lessonId,
        ExerciseType exerciseType,
        string question,
        string correctAnswer,
        string? optionsJson,
        string? explanation,
        int orderIndex)
    {
        if (string.IsNullOrWhiteSpace(question))
            return Result.Failure<Exercise>(new Error("Exercise.InvalidQuestion", "Question cannot be empty."));

        if (string.IsNullOrWhiteSpace(correctAnswer))
            return Result.Failure<Exercise>(new Error("Exercise.InvalidAnswer", "Correct answer cannot be empty."));

        if (orderIndex <= 0)
            return Result.Failure<Exercise>(new Error("Exercise.InvalidOrder", "Order index must be greater than zero."));

        var exercise = new Exercise
        {
            LessonId = lessonId,
            ExerciseType = exerciseType,
            Question = question.Trim(),
            CorrectAnswer = correctAnswer.Trim(),
            OptionsJson = optionsJson,
            Explanation = explanation?.Trim(),
            OrderIndex = orderIndex,
            IsActive = true
        };
        exercise.SetCreatedAt(DateTime.UtcNow);
        return Result.Success(exercise);
    }

    public bool CheckAnswer(string userAnswer) =>
        string.Equals(CorrectAnswer.Trim(), userAnswer.Trim(), StringComparison.OrdinalIgnoreCase);

    public void Deactivate()
    {
        IsActive = false;
        SetUpdatedAt(DateTime.UtcNow);
    }

    public void Activate()
    {
        IsActive = true;
        SetUpdatedAt(DateTime.UtcNow);
    }
}
