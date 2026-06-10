namespace LearnEnglish.Domain.Entities.Words;

/// <summary>
/// Join entity for the many-to-many between Lesson and Word.
/// </summary>
public sealed class LessonWord
{
    public Guid LessonId { get; private set; }
    public Guid WordId { get; private set; }

    private LessonWord() { }

    public LessonWord(Guid lessonId, Guid wordId)
    {
        LessonId = lessonId;
        WordId = wordId;
    }
}
