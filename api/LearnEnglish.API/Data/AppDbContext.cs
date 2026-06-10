using LearnEnglish.API.Models;
using Microsoft.EntityFrameworkCore;

namespace LearnEnglish.API.Data;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<User> Users => Set<User>();
    public DbSet<Lesson> Lessons => Set<Lesson>();
    public DbSet<Slide> Slides => Set<Slide>();
    public DbSet<Word> Words => Set<Word>();
    public DbSet<LessonWord> LessonWords => Set<LessonWord>();
    public DbSet<Exercise> Exercises => Set<Exercise>();
    public DbSet<UserProgress> UserProgress => Set<UserProgress>();
    public DbSet<ExerciseAttempt> ExerciseAttempts => Set<ExerciseAttempt>();
    public DbSet<WordInteraction> WordInteractions => Set<WordInteraction>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Composite PK for many-to-many
        modelBuilder.Entity<LessonWord>()
            .HasKey(lw => new { lw.LessonId, lw.WordId });

        // Unique constraint: one progress record per user+lesson
        modelBuilder.Entity<UserProgress>()
            .HasIndex(up => new { up.UserId, up.LessonId })
            .IsUnique();

        // Unique: lesson+slide order
        modelBuilder.Entity<Slide>()
            .HasIndex(s => new { s.LessonId, s.OrderIndex })
            .IsUnique();

        // Unique: lesson number
        modelBuilder.Entity<Lesson>()
            .HasIndex(l => l.LessonNumber)
            .IsUnique();

        // Decimal precision
        modelBuilder.Entity<UserProgress>()
            .Property(up => up.Score)
            .HasPrecision(5, 2);

        modelBuilder.Entity<WordInteraction>()
            .Property(wi => wi.PronunciationScore)
            .HasPrecision(5, 2);
    }
}
