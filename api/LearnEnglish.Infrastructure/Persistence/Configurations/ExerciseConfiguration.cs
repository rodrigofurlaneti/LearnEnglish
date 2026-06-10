using LearnEnglish.Domain.Entities.Exercises;
using LearnEnglish.Domain.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace LearnEnglish.Infrastructure.Persistence.Configurations;

public sealed class ExerciseConfiguration : IEntityTypeConfiguration<Exercise>
{
    public void Configure(EntityTypeBuilder<Exercise> builder)
    {
        builder.ToTable("Exercises");
        builder.HasKey(e => e.Id);
        builder.Property(e => e.Id)
            .HasColumnName("ExerciseId")
            .HasDefaultValueSql("NEWID()");

        builder.Property(e => e.LessonId).IsRequired();

        builder.Property(e => e.ExerciseType)
            .IsRequired()
            .HasMaxLength(50)
            .HasConversion(
                et => et.ToString().ToSnakeCaseExercise(),
                v => ParseExerciseType(v));

        builder.Property(e => e.Question).HasMaxLength(1000).IsRequired();
        builder.Property(e => e.CorrectAnswer).HasMaxLength(500).IsRequired();
        builder.Property(e => e.OptionsJson).HasColumnName("Options").HasColumnType("nvarchar(max)");
        builder.Property(e => e.Explanation).HasMaxLength(1000);
        builder.Property(e => e.OrderIndex).IsRequired().HasDefaultValue(0);
        builder.Property(e => e.IsActive).IsRequired().HasDefaultValue(true);

        builder.HasIndex(e => e.LessonId);
    }

    private static ExerciseType ParseExerciseType(string value) => value switch
    {
        "multiple_choice" => ExerciseType.MultipleChoice,
        "fill_blank"      => ExerciseType.FillBlank,
        "identify_past"   => ExerciseType.IdentifyPast,
        "translation"     => ExerciseType.Translation,
        "pronunciation"   => ExerciseType.Pronunciation,
        _                 => throw new ArgumentOutOfRangeException(nameof(value), value, null)
    };
}

internal static class ExerciseTypeExtensions
{
    internal static string ToSnakeCaseExercise(this string value) => value switch
    {
        "MultipleChoice" => "multiple_choice",
        "FillBlank"      => "fill_blank",
        "IdentifyPast"   => "identify_past",
        "Translation"    => "translation",
        "Pronunciation"  => "pronunciation",
        _                => value.ToLower()
    };
}
