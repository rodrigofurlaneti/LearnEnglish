using LearnEnglish.Domain.Common;

namespace LearnEnglish.Domain.ValueObjects;

public sealed class LessonNumber : ValueObject
{
    public int Value { get; }

    private LessonNumber(int value) => Value = value;

    public static Result<LessonNumber> Create(int value)
    {
        if (value <= 0)
            return Result.Failure<LessonNumber>(new Error("LessonNumber.Invalid", "Lesson number must be greater than zero."));

        return Result.Success(new LessonNumber(value));
    }

    protected override IEnumerable<object> GetEqualityComponents() { yield return Value; }

    public override string ToString() => $"Lesson {Value}";
}
