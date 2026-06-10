import { forwardRef } from 'react';
import type { ButtonHTMLAttributes, CSSProperties, MouseEvent } from 'react';
import { Spinner } from './Spinner';

type Variant = 'primary' | 'secondary' | 'ghost' | 'danger';
type Size = 'sm' | 'md' | 'lg';

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: Variant;
  size?: Size;
  loading?: boolean;
  fullWidth?: boolean;
}

// Using inline style objects for design-token fidelity without Tailwind compiler
const variantStyle: Record<Variant, CSSProperties> = {
  primary: {
    background: 'var(--color-ink)',
    color: 'var(--color-canvas)',
    border: '1px solid var(--color-ink)',
  },
  secondary: {
    background: 'var(--color-canvas)',
    color: 'var(--color-ink)',
    border: '1px solid var(--color-border-strong)',
  },
  ghost: {
    background: 'transparent',
    color: 'var(--color-ink-secondary)',
    border: '1px solid transparent',
  },
  danger: {
    background: 'var(--color-error)',
    color: '#fff',
    border: '1px solid var(--color-error)',
  },
};

const sizeStyle: Record<Size, CSSProperties> = {
  sm: { padding: 'var(--space-1) var(--space-3)', fontSize: 'var(--text-sm)', borderRadius: 'var(--radius-md)', height: '32px' },
  md: { padding: 'var(--space-2) var(--space-4)', fontSize: 'var(--text-sm)', borderRadius: 'var(--radius-md)', height: '36px' },
  lg: { padding: 'var(--space-3) var(--space-6)', fontSize: 'var(--text-base)', borderRadius: 'var(--radius-lg)', height: '44px' },
};

const hoverMap: Record<Variant, CSSProperties> = {
  primary: { background: 'var(--color-accent-hover)', borderColor: 'var(--color-accent-hover)' },
  secondary: { background: 'var(--color-canvas-subtle)', borderColor: 'var(--color-border-strong)' },
  ghost: { background: 'var(--color-canvas-subtle)', color: 'var(--color-ink)' },
  danger: { opacity: 0.9 },
};

export const Button = forwardRef<HTMLButtonElement, ButtonProps>(
  ({ variant = 'primary', size = 'md', loading, fullWidth, children, disabled, style, onMouseEnter, onMouseLeave, ...props }, ref) => {
    const handleMouseEnter = (e: MouseEvent<HTMLButtonElement>) => {
      if (!disabled && !loading) {
        Object.assign(e.currentTarget.style, hoverMap[variant]);
      }
      onMouseEnter?.(e);
    };

    const handleMouseLeave = (e: MouseEvent<HTMLButtonElement>) => {
      Object.assign(e.currentTarget.style, variantStyle[variant]);
      onMouseLeave?.(e);
    };

    return (
      <button
        ref={ref}
        disabled={disabled || loading}
        onMouseEnter={handleMouseEnter}
        onMouseLeave={handleMouseLeave}
        style={{
          display: 'inline-flex',
          alignItems: 'center',
          justifyContent: 'center',
          gap: 'var(--space-2)',
          fontFamily: 'var(--font-sans)',
          fontWeight: 'var(--weight-medium)' as CSSProperties['fontWeight'],
          cursor: disabled || loading ? 'not-allowed' : 'pointer',
          transition: 'all var(--transition-base)',
          opacity: disabled ? 0.5 : 1,
          width: fullWidth ? '100%' : undefined,
          outline: 'none',
          textDecoration: 'none',
          whiteSpace: 'nowrap',
          ...variantStyle[variant],
          ...sizeStyle[size],
          ...style,
        }}
        {...props}
      >
        {loading && <Spinner size={size === 'lg' ? 18 : 16} color={variant === 'primary' ? '#fff' : 'var(--color-ink)'} />}
        {children}
      </button>
    );
  },
);

Button.displayName = 'Button';
