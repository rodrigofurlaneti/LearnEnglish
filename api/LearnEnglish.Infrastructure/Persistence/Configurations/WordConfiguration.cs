using LearnEnglish.Domain.Entities.Words;
using LearnEnglish.Domain.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace LearnEnglish.Infrastructure.Persistence.Configurations;

public sealed class WordConfiguration : IEntityTypeConfiguration<Word>
{
    public void Configure(EntityTypeBuilder<Word> builder)
    {
        builder.ToTable("Words");
        builder.HasKey(w => w.Id);
        builder.Property(w => w.Id)
            .HasColumnName("WordId")
            .HasDefaultValueSql("NEWID()");

        builder.Property(w => w.WordEn).HasMaxLength(200).IsRequired();
        builder.Property(w => w.WordPt).HasMaxLength(200).IsRequired();
        builder.Property(w => w.Phonetic).HasMaxLength(200);
        builder.Property(w => w.ExampleSentence).HasMaxLength(500);
        builder.Property(w => w.ExampleTranslation).HasMaxLength(500);
        builder.Property(w => w.AudioUrl).HasMaxLength(500);

        var wordTypeConverter = new ValueConverter<WordType?, string?>(
            wt => wt.HasValue ? wt.Value.ToString().ToLowerInvariant() : null,
            v => v != null ? Enum.Parse<WordType>(v, true) : (WordType?)null);

        builder.Property(w => w.WordType).HasMaxLength(50).HasConversion(wordTypeConverter);
    }
}
