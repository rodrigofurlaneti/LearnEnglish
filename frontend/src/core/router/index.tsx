import { lazy, Suspense } from 'react';
import { createBrowserRouter, Outlet, Navigate } from 'react-router-dom';
import { Nav } from '../../design-system/components/Nav';
import { Spinner } from '../../design-system/components/Spinner';

const LessonsPage = lazy(() =>
  import('../../features/lessons/pages/LessonsPage').then((m) => ({ default: m.LessonsPage })),
);
const LessonDetailPage = lazy(() =>
  import('../../features/lessons/pages/LessonDetailPage').then((m) => ({ default: m.LessonDetailPage })),
);
const UserSetupPage = lazy(() =>
  import('../../features/users/pages/UserSetupPage').then((m) => ({ default: m.UserSetupPage })),
);

function PageFallback() {
  return (
    <div style={{ display: 'flex', justifyContent: 'center', padding: 'var(--space-20)' }}>
      <Spinner size={28} />
    </div>
  );
}

function Layout() {
  return (
    <div style={{ minHeight: '100vh', background: 'var(--color-canvas)' }}>
      <Nav />
      <main
        style={{
          maxWidth: 'var(--container-max)',
          margin: '0 auto',
          padding: 'var(--space-8) var(--space-6)',
        }}
      >
        <Suspense fallback={<PageFallback />}>
          <Outlet />
        </Suspense>
      </main>
    </div>
  );
}

function NotFoundPage() {
  return (
    <div style={{ textAlign: 'center', padding: 'var(--space-20)', color: 'var(--color-ink-secondary)' }}>
      <h1 style={{ fontSize: 'var(--text-2xl)', fontWeight: 'var(--weight-bold)', color: 'var(--color-ink)' }}>
        404 - Page not found
      </h1>
      <p style={{ marginTop: 'var(--space-2)', fontSize: 'var(--text-sm)' }}>
        The page you are looking for does not exist.
      </p>
    </div>
  );
}

export const router = createBrowserRouter([
  {
    element: <Layout />,
    children: [
      { index: true, element: <Navigate to="/lessons" replace /> },
      { path: '/lessons', element: <LessonsPage /> },
      { path: '/lessons/:id', element: <LessonDetailPage /> },
      { path: '/setup', element: <UserSetupPage /> },
      { path: '*', element: <NotFoundPage /> },
    ],
  },
]);
