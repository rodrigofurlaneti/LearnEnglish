using LearnEnglish.Domain.Entities.Users;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace LearnEnglish.Infrastructure.Persistence.Configurations;

public sealed class UserConfiguration : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.ToTable("Users");
        builder.HasKey(u => u.Id);
        builder.Property(u => u.Id)
            .HasColumnName("UserId")
            .HasDefaultValueSql("NEWID()");

        builder.Property(u => u.Name).HasMaxLength(150).IsRequired();

        builder.OwnsOne(u => u.Email, eb =>
        {
            eb.Property(e => e.Value)
                .HasColumnName("Email")
                .HasMaxLength(200)
                .IsRequired();
            eb.HasIndex(e => e.Value).IsUnique();
        });

        builder.Property(u => u.AvatarUrl).HasMaxLength(500);
        builder.Property(u => u.CreatedAt).IsRequired();

        builder.HasMany(u => u.Progress)
            .WithOne()
            .HasForeignKey(p => p.UserId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
