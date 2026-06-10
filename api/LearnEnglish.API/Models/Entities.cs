using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace LearnEnglish.API.Models;

public class User
{
    [Key] public int UserId { get; set; }
    [Required, MaxLength(150)] public string Name { get; set; } = "";
    [Required, MaxLength(200)] public string Email { get; set; } = "";
    public string? AvatarUrl { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

    public ICollection<UserProgress> Progress { get; set; } = [];
    public ICollection<ExerciseAttempt> Attempts { get; set; } = [];
}

public class Lesson
{
    [Key] public int LessonId { get; set; }
    public int LessonNumber { get; set; }
    [Required, MaxLength(200)] public string Title { get; set; } = "";
    [Required, MaxLength(200)] public string Topic { get; set; } = "";
    [MaxLength(1000)] public string Description { get; set; } = "";
    public int OrderIndex { get; set; }
    public bool IsActive { get; set; } = true;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public ICollection<Slide> Slides { get; set; } = [];
    public ICollection<Exercise> Exercises { get; set; } = [];
    public ICollection<LessonWord> LessonWords { get; set; } = [];
}

public class Slide
{
    [Key] public int SlideId { get; set; }
    public int LessonId { get; set; }
    public int OrderIndex { get; set; }
    public string? SlideTitle { get; set; }
    [Required, MaxLength(50)] public string ContentType { get; set; } = "theory";
    public string Content { get; set; } = "{}";  // JSON

    [ForeignKey(nameof(LessonId))] public Lesson Lesson { get; set; } = null!;
}

public class Word
{
    [Key] public int WordId { get; set; }
    [Required, MaxLength(200)] public string WordEn { get; set; } = "";
    [Required, MaxLength(200)] public string WordPt { get; set; } = "";
    public string? Phonetic { get; set; }
    public string? ExampleSentence { get; set; }
    public string? ExampleTranslation { get; set; }
    public string? WordType { get; set; }
    public string? AudioUrl { get; set; }

    public ICollection<LessonWord> LessonWords { get; set; } = [];
}

public class LessonWord
{
    public int LessonId { get; set; }
    public int WordId { get; set; }
    [ForeignKey(nameof(LessonId))] public Lesson Lesson { get; set; } = null!;
    [ForeignKey(nameof(WordId))] public Word Word { get; set; } = null!;
}

public class Exercise
{
    [Key] public int ExerciseId { get; set; }
    public int LessonId { get; set; }
    [Required, MaxLength(50)] public string ExerciseType { get; set; } = "multiple_choice";
    [Required] public string Question { get; set; } = "";
    [Required] public string CorrectAnswer { get; set; } = "";
    public string? Options { get; set; }  // JSON array
    public string? Explanation { get; set; }
    public int OrderIndex { get; set; }
    public bool IsActive { get; set; } = true;

    [ForeignKey(nameof(LessonId))] public Lesson Lesson { get; set; } = null!;
}

public class UserProgress
{
    [Key] public int UserProgressId { get; set; }
    public int UserId { get; set; }
    public int LessonId { get; set; }
    [MaxLength(20)] public string Status { get; set; } = "not_started";
    public int CurrentSlide { get; set; } = 0;
    public decimal? Score { get; set; }
    public DateTime? StartedAt { get; set; }
    public DateTime? CompletedAt { get; set; }

    [ForeignKey(nameof(UserId))] public User User { get; set; } = null!;
    [ForeignKey(nameof(LessonId))] public Lesson Lesson { get; set; } = null!;
}

public class ExerciseAttempt
{
    [Key] public int AttemptId { get; set; }
    public int UserId { get; set; }
    public int ExerciseId { get; set; }
    [Required] public string UserAnswer { get; set; } = "";
    public bool IsCorrect { get; set; }
    public DateTime AttemptedAt { get; set; } = DateTime.UtcNow;

    [ForeignKey(nameof(UserId))] public User User { get; set; } = null!;
    [ForeignKey(nameof(ExerciseId))] public Exercise Exercise { get; set; } = null!;
}

public class WordInteraction
{
    [Key] public int InteractionId { get; set; }
    public int UserId { get; set; }
    public int WordId { get; set; }
    [MaxLength(30)] public string InteractionType { get; set; } = "click";
    public decimal? PronunciationScore { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    [ForeignKey(nameof(UserId))] public User User { get; set; } = null!;
    [ForeignKey(nameof(WordId))] public Word Word { get; set; } = null!;
}
