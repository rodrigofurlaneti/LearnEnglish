using LearnEnglish.Domain.Common;

namespace LearnEnglish.Domain.ValueObjects;

public sealed class Score : ValueObject
{
    public const decimal Minimum = 0m;
    public const decimal Maximum = 100m;
    public const decimal PassingThreshold = 70m;

    public decimal Value { get; }
    public bool IsPassing => Value >= PassingThreshold;

    private Score(decimal value) => Value = value;

    public static Score Zero() => new(Minimum);

    public static Result<Score> Create(decimal value)
    {
        if (value < Minimum || value > Maximum)
            return Result.Failure<Score>(new Error("Score.OutOfRange", $"Score must be between {Minimum} and {Maximum}."));

        return Result.Success(new Score(Math.Round(value, 2)));
    }

    protected override IEnumerable<object> GetEqualityComponents() { yield return Value; }

    public override string ToString() => $"{Value:F2}%";
}
