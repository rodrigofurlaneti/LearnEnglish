using LearnEnglish.Domain.Entities.Exercises;
using LearnEnglish.Domain.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace LearnEnglish.Infrastructure.Persistence.Configurations;

public sealed class WordInteractionConfiguration : IEntityTypeConfiguration<WordInteraction>
{
    public void Configure(EntityTypeBuilder<WordInteraction> builder)
    {
        builder.ToTable("WordInteractions");
        builder.HasKey(wi => wi.Id);
        builder.Property(wi => wi.Id)
            .HasColumnName("InteractionId")
            .HasDefaultValueSql("NEWID()");

        builder.Property(wi => wi.UserId).IsRequired();
        builder.Property(wi => wi.WordId).IsRequired();

        builder.Property(wi => wi.InteractionType)
            .IsRequired()
            .HasMaxLength(30)
            .HasConversion(
                it => it.ToString().ToLowerInvariant(),
                v => Enum.Parse<InteractionType>(v.Replace("_", ""), true));

        builder.OwnsOne(wi => wi.PronunciationScore, sb =>
            sb.Property(s => s.Value)
                .HasColumnName("PronunciationScore")
                .HasColumnType("decimal(5,2)"));

        builder.Property(wi => wi.CreatedAt).IsRequired();

        builder.HasIndex(wi => new { wi.UserId, wi.WordId });
    }
}
