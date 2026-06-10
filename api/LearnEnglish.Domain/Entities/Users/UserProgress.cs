using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Enums;
using LearnEnglish.Domain.ValueObjects;

namespace LearnEnglish.Domain.Entities.Users;

public sealed class UserProgress : Entity
{
    public Guid UserId { get; private set; }
    public Guid LessonId { get; private set; }
    public LessonStatus Status { get; private set; }
    public int CurrentSlide { get; private set; }
    public Score? Score { get; private set; }
    public DateTime? StartedAt { get; private set; }
    public DateTime? CompletedAt { get; private set; }

    private UserProgress() { }

    internal static UserProgress Create(Guid userId, Guid lessonId)
    {
        var progress = new UserProgress
        {
            UserId = userId,
            LessonId = lessonId,
            Status = LessonStatus.NotStarted,
            CurrentSlide = 0
        };
        progress.SetCreatedAt(DateTime.UtcNow);
        return progress;
    }

    public Result Start()
    {
        if (Status != LessonStatus.NotStarted)
            return Result.Failure(new Error("Progress.AlreadyStarted", "Lesson has already been started."));

        Status = LessonStatus.InProgress;
        StartedAt = DateTime.UtcNow;
        SetUpdatedAt(DateTime.UtcNow);
        return Result.Success();
    }

    public Result AdvanceSlide(int totalSlides)
    {
        if (Status == LessonStatus.NotStarted)
            return Result.Failure(new Error("Progress.NotStarted", "Cannot advance slide before starting the lesson."));

        if (CurrentSlide >= totalSlides)
            return Result.Failure(new Error("Progress.LastSlide", "Already on the last slide."));

        CurrentSlide++;
        SetUpdatedAt(DateTime.UtcNow);
        return Result.Success();
    }

    public Result Complete(decimal scoreValue)
    {
        if (Status != LessonStatus.InProgress)
            return Result.Failure(new Error("Progress.NotInProgress", "Lesson must be in progress to complete."));

        var scoreResult = Score.Create(scoreValue);
        if (scoreResult.IsFailure)
            return Result.Failure(scoreResult.Error);

        Status = LessonStatus.Completed;
        Score = scoreResult.Value;
        CompletedAt = DateTime.UtcNow;
        SetUpdatedAt(DateTime.UtcNow);
        return Result.Success();
    }
}
