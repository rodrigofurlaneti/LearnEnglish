import type { HTMLAttributes, MouseEvent } from 'react';

interface CardProps extends HTMLAttributes<HTMLDivElement> {
  padding?: 'sm' | 'md' | 'lg';
  hoverable?: boolean;
}

const paddingMap = {
  sm: 'var(--space-4)',
  md: 'var(--space-6)',
  lg: 'var(--space-8)',
};

export function Card({ padding = 'md', hoverable, style, onMouseEnter, onMouseLeave, ...props }: CardProps) {
  const handleMouseEnter = (e: MouseEvent<HTMLDivElement>) => {
    if (hoverable) {
      e.currentTarget.style.boxShadow = 'var(--shadow-md)';
      e.currentTarget.style.transform = 'translateY(-1px)';
      e.currentTarget.style.borderColor = 'var(--color-border-strong)';
    }
    onMouseEnter?.(e);
  };

  const handleMouseLeave = (e: MouseEvent<HTMLDivElement>) => {
    if (hoverable) {
      e.currentTarget.style.boxShadow = 'var(--shadow-xs)';
      e.currentTarget.style.transform = 'translateY(0)';
      e.currentTarget.style.borderColor = 'var(--color-border)';
    }
    onMouseLeave?.(e);
  };

  return (
    <div
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
      style={{
        background: 'var(--color-canvas)',
        border: '1px solid var(--color-border)',
        borderRadius: 'var(--radius-xl)',
        padding: paddingMap[padding],
        boxShadow: 'var(--shadow-xs)',
        transition: hoverable ? 'all var(--transition-base)' : undefined,
        cursor: hoverable ? 'pointer' : undefined,
        ...style,
      }}
      {...props}
    />
  );
}

export function CardHeader({ style, ...props }: HTMLAttributes<HTMLDivElement>) {
  return (
    <div
      style={{
        marginBottom: 'var(--space-4)',
        paddingBottom: 'var(--space-4)',
        borderBottom: '1px solid var(--color-border)',
        ...style,
      }}
      {...props}
    />
  );
}

export function CardTitle({ style, ...props }: HTMLAttributes<HTMLHeadingElement>) {
  return (
    <h3
      style={{
        fontSize: 'var(--text-lg)',
        fontWeight: 'var(--weight-semibold)',
        color: 'var(--color-ink)',
        lineHeight: 'var(--leading-tight)',
        ...style,
      }}
      {...props}
    />
  );
}
