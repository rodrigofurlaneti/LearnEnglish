import { useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Card, Button, Input } from '../../../design-system';
import { useCreateUser } from '../hooks/useCreateUser';
import { useUserStore } from '../../../core/store/userStore';

const schema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Enter a valid email address'),
});
type FormValues = z.infer<typeof schema>;

export function UserSetupPage() {
  const navigate = useNavigate();
  const setUser = useUserStore((s) => s.setUser);
  const { mutate, isPending, error } = useCreateUser();

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<FormValues>({ resolver: zodResolver(schema) });

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
      <div style={{ width: '100%', maxWidth: 440 }}>
        {/* Hero text */}
        <div style={{ textAlign: 'center', marginBottom: 'var(--space-8)' }}>
          <div
            style={{
              width: 56,
              height: 56,
              borderRadius: 'var(--radius-2xl)',
              background: 'var(--gradient-brand)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              margin: '0 auto var(--space-4)',
              fontSize: 24,
            }}
          >
            📚
          </div>
          <h1
            style={{
              fontSize: 'var(--text-3xl)',
              fontWeight: 'var(--weight-bold)',
              color: 'var(--color-ink)',
              letterSpacing: '-0.02em',
              lineHeight: 'var(--leading-tight)',
              marginBottom: 'var(--space-2)',
            }}
          >
            Get started
          </h1>
          <p style={{ fontSize: 'var(--text-base)', color: 'var(--color-ink-secondary)' }}>
            Create your profile to track progress and submit answers.
          </p>
        </div>

        <Card>
          <form onSubmit={handleSubmit(onSubmit)} style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-4)' }}>
            <Input
              {...register('name')}
              label="Your name"
              placeholder="Jane Smith"
              error={errors.name?.message}
              autoComplete="name"
              autoFocus
            />

            <Input
              {...register('email')}
              label="Email address"
              type="email"
              placeholder="jane@example.com"
              error={errors.email?.message}
              autoComplete="email"
            />

            {error && (
              <div style={{
                padding: 'var(--space-3)',
                background: 'var(--color-error-bg)',
                border: '1px solid var(--color-error-border)',
                borderRadius: 'var(--radius-md)',
                fontSize: 'var(--text-sm)',
                color: 'var(--color-error)',
              }}>
                {error.message}
              </div>
            )}

            <Button type="submit" loading={isPending} fullWidth size="lg" style={{ marginTop: 'var(--space-2)' }}>
              Create profile
            </Button>
          </form>
        </Card>

        <p style={{ textAlign: 'center', fontSize: 'var(--text-xs)', color: 'var(--color-ink-tertiary)', marginTop: 'var(--space-4)' }}>
          Your data is stored locally on this device.
        </p>
      </div>
    </div>
  );
}
