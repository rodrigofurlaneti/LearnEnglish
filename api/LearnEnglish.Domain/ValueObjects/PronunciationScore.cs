using LearnEnglish.Domain.Common;

namespace LearnEnglish.Domain.ValueObjects;

public sealed class PronunciationScore : ValueObject
{
    public decimal Value { get; }
    public PronunciationLevel Level => Value switch
    {
        >= 90 => PronunciationLevel.Excellent,
        >= 70 => PronunciationLevel.Good,
        >= 50 => PronunciationLevel.Fair,
        _      => PronunciationLevel.NeedsWork
    };

    private PronunciationScore(decimal value) => Value = value;

    public static Result<PronunciationScore> Create(decimal value)
    {
        if (value < 0 || value > 100)
            return Result.Failure<PronunciationScore>(new Error("PronunciationScore.OutOfRange", "Pronunciation score must be between 0 and 100."));

        return Result.Success(new PronunciationScore(Math.Round(value, 2)));
    }

    protected override IEnumerable<object> GetEqualityComponents() { yield return Value; }

    public override string ToString() => $"{Value:F2} ({Level})";
}

public enum PronunciationLevel { NeedsWork, Fair, Good, Excellent }
