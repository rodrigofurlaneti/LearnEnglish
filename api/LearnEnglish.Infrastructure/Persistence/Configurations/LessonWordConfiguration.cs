using LearnEnglish.Domain.Entities.Words;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace LearnEnglish.Infrastructure.Persistence.Configurations;

public sealed class LessonWordConfiguration : IEntityTypeConfiguration<LessonWord>
{
    public void Configure(EntityTypeBuilder<LessonWord> builder)
    {
        builder.ToTable("LessonWords");
        builder.HasKey(lw => new { lw.LessonId, lw.WordId });
        builder.HasIndex(lw => lw.WordId);
    }
}
