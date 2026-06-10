import { forwardRef, useState } from 'react';
import type { InputHTMLAttributes } from 'react';

interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  error?: string;
  hint?: string;
}

export const Input = forwardRef<HTMLInputElement, InputProps>(
  ({ label, error, hint, id, style, ...props }, ref) => {
    const [focused, setFocused] = useState(false);
    const inputId = id ?? label?.toLowerCase().replace(/\s+/g, '-');

    return (
      <div style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-1)' }}>
        {label && (
          <label
            htmlFor={inputId}
            style={{
              fontSize: 'var(--text-sm)',
              fontWeight: 'var(--weight-medium)',
              color: 'var(--color-ink)',
            }}
          >
            {label}
          </label>
        )}
        <input
          ref={ref}
          id={inputId}
          onFocus={(e) => { setFocused(true); props.onFocus?.(e); }}
          onBlur={(e) => { setFocused(false); props.onBlur?.(e); }}
          style={{
            height: '36px',
            padding: '0 var(--space-3)',
            fontSize: 'var(--text-sm)',
            fontFamily: 'var(--font-sans)',
            color: 'var(--color-ink)',
            background: 'var(--color-canvas)',
            border: `1px solid ${error ? 'var(--color-error)' : focused ? 'var(--color-ink)' : 'var(--color-border-strong)'}`,
            borderRadius: 'var(--radius-md)',
            outline: 'none',
            transition: 'border-color var(--transition-base)',
            width: '100%',
            boxShadow: focused ? `0 0 0 3px ${error ? 'rgba(220,38,38,0.1)' : 'rgba(23,23,23,0.08)'}` : 'none',
            ...style,
          }}
          {...props}
        />
        {error && (
          <span style={{ fontSize: 'var(--text-xs)', color: 'var(--color-error)' }}>{error}</span>
        )}
        {hint && !error && (
          <span style={{ fontSize: 'var(--text-xs)', color: 'var(--color-ink-tertiary)' }}>{hint}</span>
        )}
      </div>
    );
  },
);

Input.displayName = 'Input';
