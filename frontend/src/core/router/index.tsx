import { createBrowserRouter, Outlet, Navigate } from 'react-router-dom';
import { Nav } from '../../design-system/components/Nav';
import { LessonsPage } from '../../features/lessons/pages/LessonsPage';
import { LessonDetailPage } from '../../features/lessons/pages/LessonDetailPage';
import { UserSetupPage } from '../../features/users/pages/UserSetupPage';

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
        <Outlet />
      </main>
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
    ],
  },
]);
