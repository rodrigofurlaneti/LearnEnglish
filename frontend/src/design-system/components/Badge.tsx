import type { HTMLAttributes, CSSProperties } from 'react';

type BadgeVariant = 'default' | 'success' | 'error' | 'warning' | 'outline';

interface BadgeProps extends HTMLAttributes<HTMLSpanElement> {
  variant?: BadgeVariant;
}

const variantStyles: Record<BadgeVariant, CSSProperties> = {
  default: {
    background: 'var(--color-canvas-subtle)',
    color: 'var(--color-ink-secondary)',
    border: '1px solid var(--color-border)',
  },
  success: {
    background: 'var(--color-success-bg)',
    color: 'var(--color-success)',
    border: '1px solid var(--color-success-border)',
  },
  error: {
    background: 'var(--color-error-bg)',
    color: 'var(--color-error)',
    border: '1px solid var(--color-error-border)',
  },
  warning: {
    background: 'var(--color-warning-bg)',
    color: 'var(--color-warning)',
    border: '1px solid transparent',
  },
  outline: {
    background: 'transparent',
    color: 'var(--color-ink-secondary)',
    border: '1px solid var(--color-border-strong)',
  },
};

export function Badge({ variant = 'default', style, ...props }: BadgeProps) {
  return (
    <span
      style={{
        display: 'inline-flex',
        alignItems: 'center',
        padding: '2px var(--space-2)',
        fontSize: 'var(--text-xs)',
        fontWeight: 'var(--weight-medium)',
        borderRadius: 'var(--radius-full)',
        lineHeight: 1.5,
        ...variantStyles[variant],
        ...style,
      }}
      {...props}
    />
  );
}
