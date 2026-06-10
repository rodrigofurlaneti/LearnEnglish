using LearnEnglish.Domain.Entities.Lessons;
using LearnEnglish.Domain.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace LearnEnglish.Infrastructure.Persistence.Configurations;

public sealed class SlideConfiguration : IEntityTypeConfiguration<Slide>
{
    public void Configure(EntityTypeBuilder<Slide> builder)
    {
        builder.ToTable("Slides");
        builder.HasKey(s => s.Id);
        builder.Property(s => s.Id)
            .HasColumnName("SlideId")
            .HasDefaultValueSql("NEWID()");

        builder.Property(s => s.LessonId).IsRequired();
        builder.Property(s => s.OrderIndex).IsRequired();
        builder.Property(s => s.SlideTitle).HasMaxLength(200);

        builder.Property(s => s.ContentType)
            .IsRequired()
            .HasMaxLength(50)
            .HasConversion(
                ct => ct.ToString().ToLowerInvariant(),
                v => Enum.Parse<ContentType>(v, true));

        builder.OwnsOne(s => s.Content, cb =>
            cb.Property(c => c.Json)
                .HasColumnName("Content")
                .HasColumnType("nvarchar(max)")
                .IsRequired());

        builder.HasIndex(s => new { s.LessonId, s.OrderIndex }).IsUnique();
    }
}
