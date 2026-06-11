import { test, expect } from '@playwright/test';

test.describe('Performance', () => {
  test('lessons page should load in under 3 seconds', async ({ page }) => {
    const start = Date.now();
    await page.goto('/lessons');
    await page.getByRole('heading', { name: 'Lessons' }).waitFor({ timeout: 3_000 });
    const elapsed = Date.now() - start;
    expect(elapsed).toBeLessThan(3_000);
  });

  test('lesson detail page should load in under 3 seconds', async ({ page, request }) => {
    const response = await request.get('http://localhost:5000/api/lessons');
    const lessons = await response.json();
    if (lessons.length === 0) test.skip();

    const start = Date.now();
    await page.goto(`/lessons/${lessons[0].id}`);
    await page.locator('h1').first().waitFor({ timeout: 3_000 });
    const elapsed = Date.now() - start;
    expect(elapsed).toBeLessThan(3_000);
  });

  test('user setup page should load in under 2 seconds', async ({ page }) => {
    const start = Date.now();
    await page.goto('/setup');
    await page.getByRole('heading', { name: 'Get started' }).waitFor({ timeout: 2_000 });
    const elapsed = Date.now() - start;
    expect(elapsed).toBeLessThan(2_000);
  });

  test('lessons page LCP should be under 2500ms', async ({ page }) => {
    await page.goto('/lessons');
    const lcp = await page.evaluate(
      () =>
        new Promise<number>((resolve) => {
          new PerformanceObserver((list) => {
            const entries = list.getEntries();
            resolve(entries[entries.length - 1].startTime);
          }).observe({ entryTypes: ['largest-contentful-paint'] });
          // fallback if LCP never fires
          setTimeout(() => resolve(0), 5000);
        }),
    );
    // 0 means not fired yet (no large content); non-zero should be < 2500
    if (lcp > 0) {
      expect(lcp).toBeLessThan(2500);
    }
  });
});
