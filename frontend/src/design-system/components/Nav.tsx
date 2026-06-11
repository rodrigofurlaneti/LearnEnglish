import { Link, useLocation } from 'react-router-dom';
import { useUserStore } from '../../core/store/userStore';

const navItems = [{ label: 'Lessons', to: '/lessons' }];

export function Nav() {
  const location = useLocation();
  const user = useUserStore((s) => s.user);

  return (
    <nav
      style={{
        position: 'sticky',
        top: 0,
        zIndex: 50,
        height: 'var(--nav-height)',
        background: 'rgba(255,255,255,0.92)',
        backdropFilter: 'saturate(180%) blur(12px)',
        borderBottom: '1px solid var(--color-border)',
        display: 'flex',
        alignItems: 'center',
        padding: '0 var(--space-6)',
      }}
    >
      <div
        style={{
          maxWidth: 'var(--container-max)',
          width: '100%',
          margin: '0 auto',
          display: 'flex',
          alignItems: 'center',
          gap: 'var(--space-8)',
        }}
      >
        {/* Logo */}
        <Link
          to="/"
          style={{
            fontSize: 'var(--text-sm)',
            fontWeight: 'var(--weight-semibold)',
            color: 'var(--color-ink)',
            letterSpacing: '-0.02em',
            display: 'flex',
            alignItems: 'center',
            gap: 'var(--space-2)',
          }}
        >
          <span
            style={{
              width: 22,
              height: 22,
              borderRadius: 'var(--radius-md)',
              background: 'var(--color-ink)',
              display: 'inline-flex',
              alignItems: 'center',
              justifyContent: 'center',
              color: '#fff',
              fontSize: 11,
              fontWeight: 700,
              flexShrink: 0,
            }}
          >
            L
          </span>
          LearnEnglish
        </Link>

        {/* Nav links */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 'var(--space-1)', flex: 1 }}>
          {navItems.map((item) => {
            const active = location.pathname.startsWith(item.to);
            return (
              <Link
                key={item.to}
                to={item.to}
                style={{
                  padding: '4px var(--space-3)',
                  fontSize: 'var(--text-sm)',
                  fontWeight: active ? 'var(--weight-medium)' : 'var(--weight-normal)',
                  color: active ? 'var(--color-ink)' : 'var(--color-ink-secondary)',
                  borderRadius: 'var(--radius-md)',
                  background: active ? 'var(--color-canvas-subtle)' : 'transparent',
                  border: active ? '1px solid var(--color-border)' : '1px solid transparent',
                  transition: 'all var(--transition-fast)',
                }}
              >
                {item.label}
              </Link>
            );
          })}
        </div>

        {/* User / CTA */}
        {user ? (
          <div style={{ display: 'flex', alignItems: 'center', gap: 'var(--space-2)' }}>
            <div
              style={{
                width: 28,
                height: 28,
                borderRadius: 'var(--radius-full)',
                background: 'var(--gradient-brand)',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                color: '#fff',
                fontSize: 11,
                fontWeight: 600,
                letterSpacing: '-0.02em',
                flexShrink: 0,
              }}
            >
              {user.name.charAt(0).toUpperCase()}
            </div>
            <span style={{ fontSize: 'var(--text-sm)', fontWeight: 'var(--weight-medium)', color: 'var(--color-ink)', letterSpacing: '-0.01em' }}>
              {user.name}
            </span>
          </div>
        ) : (
          <Link
            to="/setup"
            style={{
              display: 'inline-flex',
              alignItems: 'center',
              height: 30,
              padding: '0 var(--space-4)',
              fontSize: 'var(--text-sm)',
              fontWeight: 'var(--weight-medium)',
              color: '#fff',
              background: 'var(--color-ink)',
              borderRadius: 'var(--radius-full)',
              letterSpacing: '-0.01em',
              transition: 'background var(--transition-fast)',
            }}
            onMouseEnter={(e) => (e.currentTarget.style.background = 'var(--color-accent-hover)')}
            onMouseLeave={(e) => (e.currentTarget.style.background = 'var(--color-ink)')}
          >
            Get started
          </Link>
        )}
      </div>
    </nav>
  );
}
