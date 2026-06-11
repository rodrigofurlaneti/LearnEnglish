import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

test.describe('Accessibility', () => {
  test('lessons page should have no critical accessibility violations', async ({ page }) => {
    await page.goto('/lessons');
    await page.getByRole('heading', { name: 'Lessons' }).waitFor();

    const results = await new AxeBuilder({ page })
      .withTags(['wcag2a', 'wcag2aa'])
      .exclude('[aria-hidden="true"]')
      .analyze();

    // Filter to critical/serious only
    const criticalViolations = results.violations.filter(
      (v) => v.impact === 'critical' || v.impact === 'serious',
    );

    if (criticalViolations.length > 0) {
      console.log(
        'Accessibility violations:',
        JSON.stringify(criticalViolations.map((v) => ({ id: v.id, impact: v.impact, description: v.description })), null, 2),
      );
    }

    expect(criticalViolations).toHaveLength(0);
  });

  test('user setup page should have no critical accessibility violations', async ({ page }) => {
    await page.goto('/setup');
    await page.getByRole('heading', { name: 'Get started' }).waitFor();

    const results = await new AxeBuilder({ page })
      .withTags(['wcag2a', 'wcag2aa'])
      .analyze();

    const criticalViolations = results.violations.filter(
      (v) => v.impact === 'critical' || v.impact === 'serious',
    );

    expect(criticalViolations).toHaveLength(0);
  });

  test('form inputs should have associated labels', async ({ page }) => {
    await page.goto('/setup');
    const nameLabel = page.getByLabel('Your name');
    const emailLabel = page.getByLabel('Email address');
    await expect(nameLabel).toBeVisible();
    await expect(emailLabel).toBeVisible();
  });

  test('nav links should be keyboard accessible', async ({ page }) => {
    await page.goto('/lessons');
    // Tab to the nav brand link
    await page.keyboard.press('Tab');
    const focused = page.locator(':focus');
    await expect(focused).toBeVisible();
  });

  test('lesson cards should be operable with keyboard', async ({ page }) => {
    await page.goto('/lessons');
    await page.getByRole('heading', { name: 'Lessons' }).waitFor();
    // Tab through to the first focusable card-related element
    await page.keyboard.press('Tab');
    await page.keyboard.press('Tab');
    const focused = page.locator(':focus');
    await expect(focused).toBeVisible();
  });
});
