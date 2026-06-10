using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Enums;
using LearnEnglish.Domain.ValueObjects;

namespace LearnEnglish.Domain.Entities.Exercises;

public sealed class WordInteraction : Entity
{
    public Guid UserId { get; private set; }
    public Guid WordId { get; private set; }
    public InteractionType InteractionType { get; private set; }
    public PronunciationScore? PronunciationScore { get; private set; }

    private WordInteraction() { }

    public static Result<WordInteraction> Create(
        Guid userId,
        Guid wordId,
        InteractionType interactionType,
        decimal? pronunciationScore = null)
    {
        PronunciationScore? score = null;

        if (pronunciationScore.HasValue)
        {
            var scoreResult = PronunciationScore.Create(pronunciationScore.Value);
            if (scoreResult.IsFailure)
                return Result.Failure<WordInteraction>(scoreResult.Error);

            score = scoreResult.Value;
        }

        var interaction = new WordInteraction
        {
            UserId = userId,
            WordId = wordId,
            InteractionType = interactionType,
            PronunciationScore = score
        };
        interaction.SetCreatedAt(DateTime.UtcNow);
        return Result.Success(interaction);
    }
}
