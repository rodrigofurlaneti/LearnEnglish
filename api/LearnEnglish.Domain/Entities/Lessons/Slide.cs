using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Enums;
using LearnEnglish.Domain.ValueObjects;

namespace LearnEnglish.Domain.Entities.Lessons;

public sealed class Slide : Entity
{
    public Guid LessonId { get; private set; }
    public int OrderIndex { get; private set; }
    public string? SlideTitle { get; private set; }
    public ContentType ContentType { get; private set; }
    public SlideContent Content { get; private set; } = null!;

    private Slide() { }

    public static Result<Slide> Create(Guid lessonId, int orderIndex, string? slideTitle, ContentType contentType, string contentJson)
    {
        if (orderIndex <= 0)
            return Result.Failure<Slide>(new Error("Slide.InvalidOrder", "Slide order index must be greater than zero."));

        var contentResult = SlideContent.Create(contentJson);
        if (contentResult.IsFailure)
            return Result.Failure<Slide>(contentResult.Error);

        var slide = new Slide
        {
            LessonId = lessonId,
            OrderIndex = orderIndex,
            SlideTitle = slideTitle,
            ContentType = contentType,
            Content = contentResult.Value
        };
        slide.SetCreatedAt(DateTime.UtcNow);
        return Result.Success(slide);
    }

    public Result UpdateContent(string contentJson)
    {
        var contentResult = SlideContent.Create(contentJson);
        if (contentResult.IsFailure)
            return Result.Failure(contentResult.Error);

        Content = contentResult.Value;
        SetUpdatedAt(DateTime.UtcNow);
        return Result.Success();
    }
}
