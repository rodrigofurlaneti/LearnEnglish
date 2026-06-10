using LearnEnglish.Domain.Entities.Exercises;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace LearnEnglish.Infrastructure.Persistence.Configurations;

public sealed class ExerciseAttemptConfiguration : IEntityTypeConfiguration<ExerciseAttempt>
{
    public void Configure(EntityTypeBuilder<ExerciseAttempt> builder)
    {
        builder.ToTable("ExerciseAttempts");
        builder.HasKey(a => a.Id);
        builder.Property(a => a.Id)
            .HasColumnName("AttemptId")
            .HasDefaultValueSql("NEWID()");

        builder.Property(a => a.UserId).IsRequired();
        builder.Property(a => a.ExerciseId).IsRequired();
        builder.Property(a => a.UserAnswer).HasMaxLength(500).IsRequired();
        builder.Property(a => a.IsCorrect).IsRequired();
        builder.Property(a => a.AttemptedAt).IsRequired();

        builder.HasIndex(a => new { a.UserId, a.ExerciseId });
    }
}
