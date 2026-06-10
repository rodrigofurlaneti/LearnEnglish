using System.Text.RegularExpressions;
using LearnEnglish.Domain.Common;

namespace LearnEnglish.Domain.ValueObjects;

public sealed class Email : ValueObject
{
    private static readonly Regex _regex =
        new(@"^[^@\s]+@[^@\s]+\.[^@\s]+$", RegexOptions.Compiled | RegexOptions.IgnoreCase);

    public string Value { get; }

    private Email(string value) => Value = value;

    public static Result<Email> Create(string? email)
    {
        if (string.IsNullOrWhiteSpace(email) || !_regex.IsMatch(email))
            return Result.Failure<Email>(new Error("Email.Invalid", "Invalid email address."));

        return Result.Success(new Email(email.Trim().ToLowerInvariant()));
    }

    protected override IEnumerable<object> GetEqualityComponents() { yield return Value; }

    public override string ToString() => Value;
}
