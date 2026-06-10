using LearnEnglish.Domain.Entities.Users;
using LearnEnglish.Domain.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace LearnEnglish.Infrastructure.Persistence.Configurations;

public sealed class UserProgressConfiguration : IEntityTypeConfiguration<UserProgress>
{
    public void Configure(EntityTypeBuilder<UserProgress> builder)
    {
        builder.ToTable("UserProgress");
        builder.HasKey(p => p.Id);
        builder.Property(p => p.Id)
            .HasColumnName("UserProgressId")
            .HasDefaultValueSql("NEWID()");

        builder.Property(p => p.UserId).IsRequired();
        builder.Property(p => p.LessonId).IsRequired();

        builder.Property(p => p.Status)
            .IsRequired()
            .HasMaxLength(20)
            .HasConversion(
                s => s.ToString().ToSnakeCase(),
                v => Enum.Parse<LessonStatus>(v.ToPascalCase(), true));

        builder.Property(p => p.CurrentSlide).IsRequired().HasDefaultValue(0);

        builder.OwnsOne(p => p.Score, sb =>
            sb.Property(s => s.Value)
                .HasColumnName("Score")
                .HasColumnType("decimal(5,2)"));

        builder.Property(p => p.StartedAt);
        builder.Property(p => p.CompletedAt);

        builder.HasIndex(p => new { p.UserId, p.LessonId }).IsUnique();
    }
}

internal static class StringExtensions
{
    internal static string ToSnakeCase(this string value)
    {
        if (string.IsNullOrEmpty(value)) return value;
        var result = new System.Text.StringBuilder();
        for (int i = 0; i < value.Length; i++)
        {
            if (char.IsUpper(value[i]) && i > 0) result.Append('_');
            result.Append(char.ToLower(value[i]));
        }
        return result.ToString();
    }

    internal static string ToPascalCase(this string value)
    {
        if (string.IsNullOrEmpty(value)) return value;
        return string.Concat(value.Split('_')
            .Select(w => char.ToUpper(w[0]) + w[1..].ToLower()));
    }
}
