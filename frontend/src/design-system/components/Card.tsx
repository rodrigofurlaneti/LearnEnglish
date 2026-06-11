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
      e.currentTarget.style.boxShadow = 'var(--shadow-lg)';
      e.currentTarget.style.transform = 'translateY(-2px)';
    }
    onMouseEnter?.(e);
  };

  const handleMouseLeave = (e: MouseEvent<HTMLDivElement>) => {
    if (hoverable) {
      e.currentTarget.style.boxShadow = 'var(--shadow-sm)';
      e.currentTarget.style.transform = 'translateY(0)';
    }
    onMouseLeave?.(e);
  };

  return (
    <div
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
      style={{
        background: 'var(--color-canvas)',
        borderRadius: 'var(--radius-xl)',
        padding: paddingMap[padding],
        boxShadow: hoverable ? 'var(--shadow-sm)' : 'var(--shadow-xs)',
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
        fontSize: 'var(--text-base)',
        fontWeight: 'var(--weight-semibold)',
        color: 'var(--color-ink)',
        lineHeight: 'var(--leading-tight)',
        letterSpacing: '-0.02em',
        ...style,
      }}
      {...props}
    />
  );
}
