using LearnEnglish.Application.Common.Interfaces;
using LearnEnglish.Domain.Common;
using LearnEnglish.Domain.Entities.Exercises;
using LearnEnglish.Domain.Entities.Lessons;
using LearnEnglish.Domain.Entities.Users;
using LearnEnglish.Domain.Entities.Words;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace LearnEnglish.Infrastructure.Persistence;

public sealed class AppDbContext : DbContext, IUnitOfWork
{
    private readonly IPublisher _publisher;

    public AppDbContext(DbContextOptions<AppDbContext> options, IPublisher publisher)
        : base(options) => _publisher = publisher;

    public DbSet<Lesson> Lessons => Set<Lesson>();
    public DbSet<Slide> Slides => Set<Slide>();
    public DbSet<Word> Words => Set<Word>();
    public DbSet<LessonWord> LessonWords => Set<LessonWord>();
    public DbSet<Exercise> Exercises => Set<Exercise>();
    public DbSet<ExerciseAttempt> ExerciseAttempts => Set<ExerciseAttempt>();
    public DbSet<User> Users => Set<User>();
    public DbSet<UserProgress> UserProgresses => Set<UserProgress>();
    public DbSet<WordInteraction> WordInteractions => Set<WordInteraction>();

    public async Task CommitAsync(CancellationToken cancellationToken = default)
    {
        var aggregates = ChangeTracker
            .Entries<AggregateRoot>()
            .Where(e => e.Entity.DomainEvents.Count > 0)
            .Select(e => e.Entity)
            .ToList();

        var events = aggregates.SelectMany(a => a.DomainEvents).ToList();
        aggregates.ForEach(a => a.ClearDomainEvents());

        foreach (var domainEvent in events)
            await _publisher.Publish(domainEvent, cancellationToken);

        await base.SaveChangesAsync(cancellationToken);
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder) =>
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(AppDbContext).Assembly);
}
