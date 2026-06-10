import { Link, useLocation } from 'react-router-dom';
import { useUserStore } from '../../core/store/userStore';

interface NavItem {
  label: string;
  to: string;
}

const navItems: NavItem[] = [
  { label: 'Lessons', to: '/lessons' },
];

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
        background: 'rgba(255,255,255,0.85)',
        backdropFilter: 'blur(12px)',
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
            letterSpacing: '-0.01em',
          }}
        >
          LearnEnglish
        </Link>

        {/* Links */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 'var(--space-1)', flex: 1 }}>
          {navItems.map((item) => {
            const active = location.pathname.startsWith(item.to);
            return (
              <Link
                key={item.to}
                to={item.to}
                style={{
                  padding: 'var(--space-1) var(--space-3)',
                  fontSize: 'var(--text-sm)',
                  fontWeight: active ? 'var(--weight-medium)' : 'var(--weight-normal)',
                  color: active ? 'var(--color-ink)' : 'var(--color-ink-secondary)',
                  borderRadius: 'var(--radius-md)',
                  background: active ? 'var(--color-canvas-subtle)' : 'transparent',
                  transition: 'all var(--transition-fast)',
                }}
              >
                {item.label}
              </Link>
            );
          })}
        </div>

        {/* User */}
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
                fontSize: 'var(--text-xs)',
                fontWeight: 'var(--weight-semibold)',
              }}
            >
              {user.name.charAt(0).toUpperCase()}
            </div>
            <span style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)' }}>
              {user.name}
            </span>
          </div>
        ) : (
          <Link
            to="/setup"
            style={{
              fontSize: 'var(--text-sm)',
              fontWeight: 'var(--weight-medium)',
              color: 'var(--color-ink-secondary)',
            }}
          >
            Get started
          </Link>
        )}
      </div>
    </nav>
  );
}
