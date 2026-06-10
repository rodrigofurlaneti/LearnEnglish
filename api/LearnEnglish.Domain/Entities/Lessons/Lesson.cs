using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Entities.Lessons.Events;
using LearnEnglish.Domain.ValueObjects;

namespace LearnEnglish.Domain.Entities.Lessons;

public sealed class Lesson : AggregateRoot
{
    private readonly List<Slide> _slides = [];

    public LessonNumber LessonNumber { get; private set; } = null!;
    public string Title { get; private set; } = string.Empty;
    public string Topic { get; private set; } = string.Empty;
    public string Description { get; private set; } = string.Empty;
    public int OrderIndex { get; private set; }
    public bool IsActive { get; private set; }

    public IReadOnlyList<Slide> Slides => _slides.AsReadOnly();

    private Lesson() { }

    public static Result<Lesson> Create(int lessonNumber, string title, string topic, string description, int orderIndex)
    {
        if (string.IsNullOrWhiteSpace(title))
            return Result.Failure<Lesson>(new Error("Lesson.InvalidTitle", "Title cannot be empty."));

        if (string.IsNullOrWhiteSpace(topic))
            return Result.Failure<Lesson>(new Error("Lesson.InvalidTopic", "Topic cannot be empty."));

        if (orderIndex <= 0)
            return Result.Failure<Lesson>(new Error("Lesson.InvalidOrder", "Order index must be greater than zero."));

        var numberResult = LessonNumber.Create(lessonNumber);
        if (numberResult.IsFailure)
            return Result.Failure<Lesson>(numberResult.Error);

        var lesson = new Lesson
        {
            LessonNumber = numberResult.Value,
            Title = title.Trim(),
            Topic = topic.Trim(),
            Description = description.Trim(),
            OrderIndex = orderIndex,
            IsActive = true
        };
        lesson.SetCreatedAt(DateTime.UtcNow);
        return Result.Success(lesson);
    }

    public void Activate()
    {
        if (IsActive) return;
        IsActive = true;
        SetUpdatedAt(DateTime.UtcNow);
        RaiseDomainEvent(new LessonActivatedEvent(Guid.NewGuid(), DateTime.UtcNow, Id));
    }

    public void Deactivate()
    {
        if (!IsActive) return;
        IsActive = false;
        SetUpdatedAt(DateTime.UtcNow);
        RaiseDomainEvent(new LessonDeactivatedEvent(Guid.NewGuid(), DateTime.UtcNow, Id));
    }

    public Result AddSlide(Slide slide)
    {
        if (_slides.Any(s => s.OrderIndex == slide.OrderIndex))
            return Result.Failure(new Error("Lesson.DuplicateSlideOrder", $"A slide with order index {slide.OrderIndex} already exists."));

        _slides.Add(slide);
        return Result.Success();
    }
}
