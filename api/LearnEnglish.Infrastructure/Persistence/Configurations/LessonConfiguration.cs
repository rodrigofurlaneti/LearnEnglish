using LearnEnglish.Domain.Entities.Lessons;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace LearnEnglish.Infrastructure.Persistence.Configurations;

public sealed class LessonConfiguration : IEntityTypeConfiguration<Lesson>
{
    public void Configure(EntityTypeBuilder<Lesson> builder)
    {
        builder.ToTable("Lessons");
        builder.HasKey(l => l.Id);
        builder.Property(l => l.Id)
            .HasColumnName("LessonId")
            .HasDefaultValueSql("NEWID()");

        builder.OwnsOne(l => l.LessonNumber, nb =>
        {
            nb.Property(n => n.Value)
                .HasColumnName("LessonNumber")
                .IsRequired();
            nb.HasIndex(n => n.Value).IsUnique();
        });

        builder.Property(l => l.Title).HasMaxLength(200).IsRequired();
        builder.Property(l => l.Topic).HasMaxLength(200).IsRequired();
        builder.Property(l => l.Description).HasMaxLength(1000).IsRequired();
        builder.Property(l => l.OrderIndex).IsRequired();
        builder.Property(l => l.IsActive).IsRequired().HasDefaultValue(true);
        builder.Property(l => l.CreatedAt).IsRequired();

        builder.HasMany(l => l.Slides)
            .WithOne()
            .HasForeignKey(s => s.LessonId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
