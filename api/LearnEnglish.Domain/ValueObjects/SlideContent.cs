using System.Text.Json;
using LearnEnglish.Domain.Common;

namespace LearnEnglish.Domain.ValueObjects;

public sealed class SlideContent : ValueObject
{
    public string Json { get; }

    private SlideContent(string json) => Json = json;

    public static Result<SlideContent> Create(string? json)
    {
        if (string.IsNullOrWhiteSpace(json))
            return Result.Failure<SlideContent>(new Error("SlideContent.Empty", "Slide content cannot be empty."));

        if (!IsValidJson(json))
            return Result.Failure<SlideContent>(new Error("SlideContent.InvalidJson", "Slide content must be valid JSON."));

        return Result.Success(new SlideContent(json));
    }

    private static bool IsValidJson(string json)
    {
        try { JsonDocument.Parse(json); return true; }
        catch (JsonException) { return false; }
    }

    protected override IEnumerable<object> GetEqualityComponents() { yield return Json; }

    public override string ToString() => Json;
}
