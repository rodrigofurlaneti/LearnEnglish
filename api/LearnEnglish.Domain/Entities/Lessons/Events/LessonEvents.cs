using LearnEnglish.Domain.Common;

namespace LearnEnglish.Domain.Entities.Lessons.Events;

public sealed record LessonActivatedEvent(Guid EventId, DateTime OccurredAt, Guid LessonId) : IDomainEvent;

public sealed record LessonDeactivatedEvent(Guid EventId, DateTime OccurredAt, Guid LessonId) : IDomainEvent;
