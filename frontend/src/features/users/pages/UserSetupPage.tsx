import { useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { Button, Input } from '../../../design-system';
import { useCreateUser } from '../hooks/useCreateUser';
import { useUserStore } from '../../../core/store/userStore';

interface FormValues {
  name: string;
  email: string;
}

export function UserSetupPage() {
  const navigate = useNavigate();
  const setUser = useUserStore((s) => s.setUser);
  const { mutate, isPending, error } = useCreateUser();

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<FormValues>();

  const onSubmit = (values: FormValues) => {
    mutate(values, {
      onSuccess: (data) => {
        setUser({ id: data.id, name: values.name, email: values.email });
        navigate('/lessons');
      },
    });
  };

  return (
    <div
      style={{
        minHeight: 'calc(100vh - var(--nav-height))',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: 'var(--space-6)',
      }}
    >
      <div style={{ width: '100%', maxWidth: 420 }}>
        {/* Icon + headline */}
        <div style={{ textAlign: 'center', marginBottom: 'var(--space-8)' }}>
          <div
            style={{
              width: 52,
              height: 52,
              borderRadius: 'var(--radius-xl)',
              background: 'var(--gradient-develop)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              margin: '0 auto var(--space-5)',
              fontSize: 22,
              boxShadow: 'var(--shadow-md)',
            }}
          >
            📚
          </div>
          <h1
            style={{
              fontSize: 'var(--text-2xl)',
              fontWeight: 'var(--weight-semibold)',
              color: 'var(--color-ink)',
              letterSpacing: '-0.04em',
              lineHeight: 'var(--leading-tight)',
              marginBottom: 'var(--space-2)',
            }}
          >
            Get started
          </h1>
          <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)', lineHeight: 'var(--leading-relaxed)' }}>
            Create your profile to track progress and submit answers.
          </p>
        </div>

        {/* Form card */}
        <div
          style={{
            background: 'var(--color-canvas)',
            borderRadius: 'var(--radius-2xl)',
            boxShadow: 'var(--shadow-md)',
            padding: 'var(--space-8)',
          }}
        >
          <form
            onSubmit={handleSubmit(onSubmit)}
            noValidate
            style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-5)' }}
          >
            <Input
              {...register('name', {
                required: 'Name is required',
                minLength: { value: 2, message: 'Name must be at least 2 characters' },
              })}
              label="Your name"
              placeholder="Jane Smith"
              error={errors.name?.message}
              autoComplete="name"
              autoFocus
            />

            <Input
              {...register('email', {
                required: 'Email is required',
                pattern: {
                  value: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i,
                  message: 'Enter a valid email address',
                },
              })}
              label="Email address"
              type="email"
              placeholder="jane@example.com"
              error={errors.email?.message}
              autoComplete="email"
            />

            {error && (
              <div
                style={{
                  padding: 'var(--space-3) var(--space-4)',
                  background: 'var(--color-error-bg)',
                  border: '1px solid var(--color-error-border)',
                  borderRadius: 'var(--radius-lg)',
                  fontSize: 'var(--text-sm)',
                  color: 'var(--color-error)',
                }}
              >
                {error.message}
              </div>
            )}

            <Button type="submit" loading={isPending} fullWidth size="lg" style={{ marginTop: 'var(--space-2)', borderRadius: 'var(--radius-full)' }}>
              Create profile
            </Button>
          </form>
        </div>

        <p
          style={{
            textAlign: 'center',
            fontSize: 'var(--text-xs)',
            color: 'var(--color-ink-tertiary)',
            marginTop: 'var(--space-5)',
            fontFamily: 'var(--font-mono)',
          }}
        >
          Your data is stored locally on this device.
        </p>
      </div>
    </div>
  );
}
