import { test as base, type Page } from '@playwright/test';
import { LessonsPage } from '../pages/LessonsPage';
import { LessonDetailPage } from '../pages/LessonDetailPage';
import { UserSetupPage } from '../pages/UserSetupPage';

type Fixtures = {
  page: Page;
  lessonsPage: LessonsPage;
  lessonDetailPage: LessonDetailPage;
  userSetupPage: UserSetupPage;
};

export const test = base.extend<Fixtures>({
  // Pre-navigate to the app origin so localStorage is accessible before tests
  // run their own page.evaluate() calls (which would fail on about:blank).
  page: async ({ page }, use) => {
    await page.goto('/');
    await use(page);
  },
  lessonsPage: async ({ page }, use) => {
    await use(new LessonsPage(page));
  },
  lessonDetailPage: async ({ page }, use) => {
    await use(new LessonDetailPage(page));
  },
  userSetupPage: async ({ page }, use) => {
    await use(new UserSetupPage(page));
  },
});

export { expect } from '@playwright/test';
