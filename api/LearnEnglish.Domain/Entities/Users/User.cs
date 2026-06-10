using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Entities.Users.Events;
using LearnEnglish.Domain.ValueObjects;

namespace LearnEnglish.Domain.Entities.Users;

public sealed class User : AggregateRoot
{
    private readonly List<UserProgress> _progress = [];

    public string Name { get; private set; } = string.Empty;
    public Email Email { get; private set; } = null!;
    public string? AvatarUrl { get; private set; }

    public IReadOnlyList<UserProgress> Progress => _progress.AsReadOnly();

    private User() { }

    public static Result<User> Create(string name, string email)
    {
        if (string.IsNullOrWhiteSpace(name))
            return Result.Failure<User>(new Error("User.InvalidName", "Name cannot be empty."));

        var emailResult = Email.Create(email);
        if (emailResult.IsFailure)
            return Result.Failure<User>(emailResult.Error);

        var user = new User
        {
            Name = name.Trim(),
            Email = emailResult.Value
        };
        user.SetCreatedAt(DateTime.UtcNow);
        user.RaiseDomainEvent(new UserCreatedEvent(Guid.NewGuid(), DateTime.UtcNow, user.Id, emailResult.Value.Value));
        return Result.Success(user);
    }

    public Result UpdateName(string name)
    {
        if (string.IsNullOrWhiteSpace(name))
            return Result.Failure(new Error("User.InvalidName", "Name cannot be empty."));

        Name = name.Trim();
        SetUpdatedAt(DateTime.UtcNow);
        return Result.Success();
    }

    public Result UpdateAvatar(string? avatarUrl)
    {
        AvatarUrl = avatarUrl;
        SetUpdatedAt(DateTime.UtcNow);
        return Result.Success();
    }

    public Result StartLesson(Guid lessonId)
    {
        var existing = _progress.FirstOrDefault(p => p.LessonId == lessonId);
        if (existing is not null)
            return existing.Start();

        var progress = UserProgress.Create(Id, lessonId);
        _progress.Add(progress);
        return progress.Start();
    }
}
