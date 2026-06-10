using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Enums;

namespace LearnEnglish.Domain.Entities.Words;

public sealed class Word : AggregateRoot
{
    public string WordEn { get; private set; } = string.Empty;
    public string WordPt { get; private set; } = string.Empty;
    public string? Phonetic { get; private set; }
    public string? ExampleSentence { get; private set; }
    public string? ExampleTranslation { get; private set; }
    public WordType? WordType { get; private set; }
    public string? AudioUrl { get; private set; }

    private Word() { }

    public static Result<Word> Create(
        string wordEn,
        string wordPt,
        string? phonetic = null,
        WordType? wordType = null,
        string? exampleSentence = null,
        string? exampleTranslation = null)
    {
        if (string.IsNullOrWhiteSpace(wordEn))
            return Result.Failure<Word>(new Error("Word.InvalidEnglish", "English word cannot be empty."));

        if (string.IsNullOrWhiteSpace(wordPt))
            return Result.Failure<Word>(new Error("Word.InvalidPortuguese", "Portuguese translation cannot be empty."));

        var word = new Word
        {
            WordEn = wordEn.Trim(),
            WordPt = wordPt.Trim(),
            Phonetic = phonetic?.Trim(),
            WordType = wordType,
            ExampleSentence = exampleSentence?.Trim(),
            ExampleTranslation = exampleTranslation?.Trim()
        };
        word.SetCreatedAt(DateTime.UtcNow);
        return Result.Success(word);
    }

    public Result SetAudioUrl(string? audioUrl)
    {
        AudioUrl = audioUrl;
        SetUpdatedAt(DateTime.UtcNow);
        return Result.Success();
    }
}
