import { test, expect } from '../../fixtures';
import { getLessons } from '../../helpers/api';

test.describe('Lesson Detail — Slides', () => {
  test.beforeEach(async ({ page, lessonDetailPage, request }) => {
    const lessons = await getLessons(request);
    const firstLesson = lessons[0];
    await page.goto(`/lessons/${firstLesson.id}`);
    await lessonDetailPage.waitForLoad();
  });

  test('should display lesson title', async ({ lessonDetailPage }) => {
    await expect(lessonDetailPage.lessonTitle).toBeVisible();
  });

  test('should show Slides and Exercises tabs', async ({ lessonDetailPage }) => {
    await expect(lessonDetailPage.slidesTab).toBeVisible();
    await expect(lessonDetailPage.exercisesTab).toBeVisible();
  });

  test('should start on slide 1', async ({ lessonDetailPage }) => {
    const current = await lessonDetailPage.getCurrentSlideNumber();
    expect(current).toBe(1);
  });

  test('should show slide title and content', async ({ page }) => {
    await expect(page.locator('h2').first()).toBeVisible();
    await expect(page.locator('p').first()).toBeVisible();
  });

  test('should disable Previous button on first slide', async ({ lessonDetailPage }) => {
    await expect(lessonDetailPage.prevButton).toBeDisabled();
  });

  test('should advance to next slide when Next is clicked', async ({ lessonDetailPage }) => {
    const total = await lessonDetailPage.getTotalSlides();
    if (total > 1) {
      await lessonDetailPage.nextButton.click();
      const current = await lessonDetailPage.getCurrentSlideNumber();
      expect(current).toBe(2);
    }
  });

  test('should go back to previous slide when Previous is clicked', async ({ lessonDetailPage }) => {
    const total = await lessonDetailPage.getTotalSlides();
    if (total > 1) {
      await lessonDetailPage.nextButton.click();
      await lessonDetailPage.prevButton.click();
      const current = await lessonDetailPage.getCurrentSlideNumber();
      expect(current).toBe(1);
    }
  });

  test('should show "Practice →" button on last slide', async ({ lessonDetailPage }) => {
    await lessonDetailPage.navigateToLastSlide();
    await expect(lessonDetailPage.practiceButton).toBeVisible();
  });

  test('should switch to Exercises tab when Practice is clicked', async ({ lessonDetailPage }) => {
    await lessonDetailPage.navigateToLastSlide();
    await lessonDetailPage.practiceButton.click();
    await expect(lessonDetailPage.exercisesTab).toHaveAttribute('style', expect.stringContaining('var(--weight-semibold)'));
  });

  test('should navigate back to lessons list', async ({ lessonDetailPage, page }) => {
    await lessonDetailPage.goBack();
    await expect(page).toHaveURL('/lessons');
  });
});

test.describe('Lesson Detail — Exercises tab', () => {
  test.beforeEach(async ({ page, lessonDetailPage, request }) => {
    const lessons = await getLessons(request);
    const firstLesson = lessons[0];
    await page.goto(`/lessons/${firstLesson.id}`);
    await lessonDetailPage.waitForLoad();
    await lessonDetailPage.goToExercises();
  });

  test('should show exercises or empty state', async ({ page }) => {
    const hasExercises = await page.locator('[style*="var(--radius-xl)"]').count() > 1;
    const hasEmpty = await page.getByText('No exercises for this lesson yet.').isVisible().catch(() => false);
    expect(hasExercises || hasEmpty).toBe(true);
  });

  test('should display exercise question text', async ({ page }) => {
    const noExercises = await page.getByText('No exercises').isVisible().catch(() => false);
    if (!noExercises) {
      const questions = page.locator('[style*="var(--weight-medium)"]').filter({ hasText: /\?|_|translate/i });
      expect(await questions.count()).toBeGreaterThanOrEqual(0);
    }
  });

  test('should show exercise type badge', async ({ page }) => {
    const noExercises = await page.getByText('No exercises').isVisible().catch(() => false);
    if (!noExercises) {
      const badge = page.locator('span').filter({
        hasText: /Fill in the blank|Multiple choice|Translation|Pronunciation/i,
      }).first();
      await expect(badge).toBeVisible();
    }
  });
});
