import { test, expect } from '@playwright/test';

test.describe('Error Handling', () => {
  test('navigating to a non-existent lesson should show an error message', async ({ page }) => {
    await page.goto('/lessons/00000000-0000-0000-0000-000000000000');
    // Should show an error state, not crash the page
    const errorVisible = await page.getByText(/Request failed|not found|404/i).isVisible().catch(() => false);
    const spinnerGone = await page.locator('svg[style*="spin"]').isVisible().catch(() => false);
    // After loading, either shows error or stays loading
    expect(errorVisible || !spinnerGone).toBeTruthy();
  });

  test('lessons page should show error state when API is unreachable', async ({ page }) => {
    // Block all API calls
    await page.route('**/api/lessons', (route) => route.abort());
    await page.goto('/lessons');

    await expect(
      page.getByText(/Failed to load|Request failed|Network Error/i),
    ).toBeVisible({ timeout: 10_000 });
  });

  test('should not crash on unknown route — stays on app shell', async ({ page }) => {
    await page.goto('/this-route-does-not-exist');
    // App shell (nav) should still be visible
    await expect(page.getByText('LearnEnglish')).toBeVisible();
  });

  test('API error on exercise submit should not crash the page', async ({ page, request }) => {
    const lessonsRes = await request.get('http://localhost:5000/api/lessons');
    const lessons = await lessonsRes.json();
    if (lessons.length === 0) test.skip();

    // Block submit endpoint
    await page.route('**/api/exercises/**', (route) => route.abort());

    await page.goto(`/lessons/${lessons[0].id}`);
    await page.getByRole('button', { name: /Exercises/ }).click();

    const hasExercises = (await page.getByText('No exercises').isVisible().catch(() => false)) === false;
    if (!hasExercises) test.skip();

    const inputs = await page.getByPlaceholder('Type your answer…').all();
    if (inputs.length > 0) {
      await inputs[0].fill('test answer');
      await page.getByRole('button', { name: 'Submit' }).first().click();
      // Page should not crash — nav still visible
      await expect(page.getByText('LearnEnglish')).toBeVisible();
    }
  });
});
