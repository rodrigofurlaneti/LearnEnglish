using LearnEnglish.Domain.Common;

namespace LearnEnglish.Domain.Entities.Users.Events;

public sealed record UserCreatedEvent(Guid EventId, DateTime OccurredAt, Guid UserId, string Email) : IDomainEvent;

public sealed record LessonProgressCompletedEvent(Guid EventId, DateTime OccurredAt, Guid UserId, Guid LessonId, decimal Score) : IDomainEvent;
