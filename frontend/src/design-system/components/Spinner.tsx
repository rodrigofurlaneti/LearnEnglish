interface SpinnerProps {
  size?: number;
  color?: string;
}

export function Spinner({ size = 20, color = 'var(--color-ink)' }: SpinnerProps) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 24 24"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      style={{
        animation: 'le-rotate 0.7s linear infinite',
        flexShrink: 0,
      }}
    >
      <style>{`@keyframes le-rotate { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }`}</style>
      <circle cx="12" cy="12" r="10" stroke={color} strokeWidth="2" strokeOpacity="0.25" />
      <path d="M12 2a10 10 0 0 1 10 10" stroke={color} strokeWidth="2" strokeLinecap="round" />
    </svg>
  );
}
