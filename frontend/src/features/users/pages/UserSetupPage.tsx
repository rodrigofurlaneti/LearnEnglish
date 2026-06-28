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
  const clearUser = useUserStore((s) => s.clearUser);
  const { mutate, isPending, error, isSuccess } = useCreateUser();

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
              width: 52, height: 52, borderRadius: 'var(--radius-xl)',
              background: 'var(--gradient-develop)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              margin: '0 auto var(--space-5)', fontSize: 22,
              boxShadow: 'var(--shadow-md)',
            }}
          >
            📚
          </div>
          <h1 style={{
            fontSize: 'var(--text-2xl)', fontWeight: 'var(--weight-semibold)',
            color: 'var(--color-ink)', letterSpacing: '-0.04em',
            lineHeight: 'var(--leading-tight)', marginBottom: 'var(--space-2)',
          }}>
            Configurar perfil
          </h1>
          <p style={{ fontSize: 'var(--text-sm)', color: 'var(--color-ink-secondary)', lineHeight: 'var(--leading-relaxed)' }}>
            Crie ou recupere seu perfil para registrar progresso e responder exercícios.
          </p>
        </div>

        {/* Form card */}
        <div style={{
          background: 'var(--color-canvas)', borderRadius: 'var(--radius-2xl)',
          boxShadow: 'var(--shadow-md)', padding: 'var(--space-8)',
        }}>
          <form
            onSubmit={handleSubmit(onSubmit)}
            noValidate
            style={{ display: 'flex', flexDirection: 'column', gap: 'var(--space-5)' }}
          >
            <Input
              {...register('name', {
                required: 'Nome é obrigatório',
                minLength: { value: 2, message: 'Nome deve ter pelo menos 2 caracteres' },
              })}
              label="Seu nome"
              placeholder="Rodrigo Furlaneti"
              error={errors.name?.message}
              autoComplete="name"
              autoFocus
            />

            <Input
              {...register('email', {
                required: 'E-mail é obrigatório',
                pattern: {
                  value: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i,
                  message: 'Digite um e-mail válido',
                },
              })}
              label="E-mail"
              type="email"
              placeholder="rodrigo@exemplo.com"
              error={errors.email?.message}
              autoComplete="email"
            />

            {error && (
              <div style={{
                padding: 'var(--space-3) var(--space-4)',
                background: '#fef2f2', border: '1px solid #fecaca',
                borderRadius: 'var(--radius-lg)', fontSize: 'var(--text-sm)', color: '#b91c1c',
              }}>
                {error.message}
              </div>
            )}

            <Button
              type="submit"
              loading={isPending}
              fullWidth size="lg"
              style={{ marginTop: 'var(--space-2)', borderRadius: 'var(--radius-full)' }}
            >
              Entrar / Criar perfil
            </Button>
          </form>
        </div>

        {/* Info box */}
        <div style={{
          marginTop: 'var(--space-5)',
          padding: 'var(--space-4)',
          background: 'rgba(99,179,237,0.06)',
          borderRadius: 'var(--radius-lg)',
          border: '1px solid rgba(99,179,237,0.2)',
          fontSize: 'var(--text-xs)',
          color: 'var(--color-ink-secondary)',
          lineHeight: 1.6,
        }}>
          <strong style={{ color: 'var(--color-ink)', display: 'block', marginBottom: 4 }}>
            💡 Já tem um perfil?
          </strong>
          Digite seu nome e o mesmo e-mail que usou antes — seu perfil será recuperado automaticamente.{' '}
          {useUserStore.getState().user && (
            <button
              onClick={() => { clearUser(); }}
              style={{
                background: 'none', border: 'none', color: '#ef4444',
                cursor: 'pointer', padding: 0, fontSize: 'inherit',
                textDecoration: 'underline', textUnderlineOffset: 2,
              }}
            >
              Limpar sessão atual
            </button>
          )}
        </div>

        <p style={{
          textAlign: 'center', fontSize: 'var(--text-xs)',
          color: 'var(--color-ink-tertiary)', marginTop: 'var(--space-4)',
          fontFamily: 'var(--font-mono)',
        }}>
          Seus dados são armazenados neste dispositivo.
        </p>
      </div>
    </div>
  );
}
