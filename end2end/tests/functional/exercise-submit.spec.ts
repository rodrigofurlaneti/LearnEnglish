import { test, expect } from '../../fixtures';
import { createTestUser, getLessons, getLessonDetail } from '../../helpers/api';

test.describe('Exercise Submission', () => {
  let userId: string;
  let lessonWithExercises: { id: string; exercises: Array<{ id: string; exerciseType: string; correctAnswer: string; optionsJson?: string }> };

  test.beforeAll(async ({ request }) => {
    // Find a lesson with exercises
    const lessons = await getLessons(request);
    for (const lesson of lessons) {
      const detail = await getLessonDetail(request, lesson.id);
      if (detail.exercises && detail.exercises.length > 0) {
        lessonWithExercises = detail;
        break;
      }
    }
  });

  test.beforeEach(async ({ page, request }) => {
    const user = await createTestUser(request);
    userId = user.id;
    // Inject user into Zustand store via localStorage
    await page.goto('/lessons');
    await page.evaluate(
      ({ id, name, email }) => {
        localStorage.setItem(
          'learn-english-user',
          JSON.stringify({ state: { user: { id, name, email } }, version: 0 }),
        );
      },
      user,
    );
  });

  test('should show "Set up your profile" message when no user is logged in', async ({ page, request }) => {
    await page.evaluate(() => localStorage.removeItem('learn-english-user'));
    const lessons = await getLessons(request);
    await page.goto(`/lessons/${lessons[0].id}`);
    await page.getByRole('button', { name: /Exercises/ }).click();
    const noExercises = await page.getByText('No exercises').isVisible().catch(() => false);
    if (!noExercises) {
      await expect(page.getByText('Set up your profile')).toBeVisible();
    }
  });

  test('should submit a correct answer and show success feedback', async ({ page }) => {
    if (!lessonWithExercises) test.skip();
    await page.goto(`/lessons/${lessonWithExercises.id}`);
    await page.getByRole('button', { name: /Exercises/ }).click();

    const freeTextExercise = lessonWithExercises.exercises.find(
      (e) => e.exerciseType !== 'MultipleChoice',
    );
    if (!freeTextExercise) test.skip();

    const answerInput = page.getByPlaceholder('Type your answer…').first();
    await answerInput.fill(freeTextExercise!.correctAnswer);
    await page.getByRole('button', { name: 'Submit' }).first().click();

    await expect(page.getByText('Correct!')).toBeVisible({ timeout: 8_000 });
  });

  test('should submit a wrong answer and show failure feedback with correct answer', async ({ page }) => {
    if (!lessonWithExercises) test.skip();
    await page.goto(`/lessons/${lessonWithExercises.id}`);
    await page.getByRole('button', { name: /Exercises/ }).click();

    const freeTextExercise = lessonWithExercises.exercises.find(
      (e) => e.exerciseType !== 'MultipleChoice',
    );
    if (!freeTextExercise) test.skip();

    const answerInput = page.getByPlaceholder('Type your answer…').first();
    await answerInput.fill('definitely wrong answer xyz');
    await page.getByRole('button', { name: 'Submit' }).first().click();

    await expect(page.getByText('Not quite')).toBeVisible({ timeout: 8_000 });
    await expect(page.getByText('Correct answer:')).toBeVisible();
  });

  test('should show validation error when submitting empty answer', async ({ page, request }) => {
    const lessons = await getLessons(request);
    let targetLesson = null;
    for (const lesson of lessons) {
      const detail = await getLessonDetail(request, lesson.id);
      if (detail.exercises?.some((e: { exerciseType: string }) => e.exerciseType !== 'MultipleChoice')) {
        targetLesson = detail;
        break;
      }
    }
    if (!targetLesson) test.skip();

    await page.goto(`/lessons/${targetLesson.id}`);
    await page.getByRole('button', { name: /Exercises/ }).click();
    await page.getByRole('button', { name: 'Submit' }).first().click();
    await expect(page.getByText('Please enter an answer')).toBeVisible();
  });

  test('should select and submit a multiple choice answer', async ({ page }) => {
    if (!lessonWithExercises) test.skip();
    const mcExercise = lessonWithExercises.exercises.find((e) => e.exerciseType === 'MultipleChoice');
    if (!mcExercise) test.skip();

    await page.goto(`/lessons/${lessonWithExercises.id}`);
    await page.getByRole('button', { name: /Exercises/ }).click();

    const options = JSON.parse(mcExercise!.optionsJson ?? '[]') as string[];
    if (options.length === 0) test.skip();

    await page.getByRole('button', { name: options[0] }).first().click();
    await page.getByRole('button', { name: 'Submit' }).first().click();

    await expect(
      page.getByText('Correct!').or(page.getByText('Not quite')),
    ).toBeVisible({ timeout: 8_000 });
  });
});
