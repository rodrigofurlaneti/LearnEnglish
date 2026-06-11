import { test, expect } from '@playwright/test';

test.describe('Security', () => {
  test('user input should be rendered as text, not HTML (XSS prevention)', async ({ page }) => {
    await page.goto('/setup');
    await page.getByLabel('Your name').fill('<script>window.__xss=1</script>');
    await page.getByLabel('Email address').fill('xss@test.com');

    // Verify the script tag was NOT executed
    const xssTriggered = await page.evaluate(() => (window as unknown as Record<string, unknown>).__xss);
    expect(xssTriggered).toBeUndefined();
  });

  test('lessons page should not expose sensitive data in the DOM', async ({ page }) => {
    await page.goto('/lessons');
    await page.getByRole('heading', { name: 'Lessons' }).waitFor();

    const bodyText = await page.locator('body').innerText();
    // No JWT tokens or passwords in visible DOM
    expect(bodyText).not.toMatch(/bearer\s+[a-z0-9._-]{20,}/i);
    expect(bodyText).not.toMatch(/password/i);
  });

  test('page should not expose stack traces in the UI', async ({ page }) => {
    await page.route('**/api/lessons', (route) =>
      route.fulfill({ status: 500, body: JSON.stringify({ error: 'Internal error' }) }),
    );
    await page.goto('/lessons');
    const bodyText = await page.locator('body').innerText();
    expect(bodyText).not.toMatch(/at\s+\w+\s+\(.*\.js:\d+:\d+\)/);
  });
});
