using LearnEnglish.Domain.Common;
using MediatR;

namespace LearnEnglish.Application.Common;

/// <summary>
/// Wraps a domain event into a MediatR INotification so it can be dispatched via IPublisher.
/// </summary>
public sealed class DomainEventNotification<TDomainEvent>(TDomainEvent domainEvent)
    : INotification where TDomainEvent : IDomainEvent
{
    public TDomainEvent DomainEvent { get; } = domainEvent;
}
