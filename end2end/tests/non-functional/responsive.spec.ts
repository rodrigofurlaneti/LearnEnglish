import { test, expect } from '@playwright/test';

// Viewport sizes to test
const viewports = [
  { name: 'Mobile S', width: 375, height: 667 },
  { name: 'Mobile L', width: 425, height: 812 },
  { name: 'Tablet', width: 768, height: 1024 },
  { name: 'Laptop', width: 1280, height: 800 },
  { name: 'Desktop', width: 1440, height: 900 },
];

for (const viewport of viewports) {
  test.describe(`Responsive — ${viewport.name} (${viewport.width}x${viewport.height})`, () => {
    test.use({ viewport: { width: viewport.width, height: viewport.height } });

    test('lessons page should render without horizontal scroll', async ({ page }) => {
      await page.goto('/lessons');
      await page.getByRole('heading', { name: 'Lessons' }).waitFor();

      const scrollWidth = await page.evaluate(() => document.body.scrollWidth);
      const clientWidth = await page.evaluate(() => document.body.clientWidth);
      expect(scrollWidth).toBeLessThanOrEqual(clientWidth + 1); // +1 px tolerance
    });

    test('lessons page heading should be visible', async ({ page }) => {
      await page.goto('/lessons');
      await expect(page.getByRole('heading', { name: 'Lessons' })).toBeVisible();
    });

    test('nav brand should be visible', async ({ page }) => {
      await page.goto('/lessons');
      await expect(page.getByText('LearnEnglish').first()).toBeVisible();
    });

    test('user setup page should render without horizontal scroll', async ({ page }) => {
      await page.goto('/setup');
      await page.getByRole('heading', { name: 'Get started' }).waitFor();

      const scrollWidth = await page.evaluate(() => document.body.scrollWidth);
      const clientWidth = await page.evaluate(() => document.body.clientWidth);
      expect(scrollWidth).toBeLessThanOrEqual(clientWidth + 1);
    });

    test('form should be usable on small screens', async ({ page }) => {
      await page.goto('/setup');
      const nameInput = page.getByLabel('Your name');
      const emailInput = page.getByLabel('Email address');
      const submitButton = page.getByRole('button', { name: 'Create profile' });

      await expect(nameInput).toBeVisible();
      await expect(emailInput).toBeVisible();
      await expect(submitButton).toBeVisible();
    });
  });
}
