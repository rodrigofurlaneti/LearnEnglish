import { test, expect } from '../../fixtures';

test.describe('User Setup', () => {
  test.beforeEach(async ({ userSetupPage }) => {
    // Clear persisted user state before each test
    await userSetupPage.page.evaluate(() => localStorage.removeItem('learn-english-user'));
    await userSetupPage.goto();
    await userSetupPage.waitForLoad();
  });

  test('should display the setup form', async ({ userSetupPage }) => {
    await expect(userSetupPage.nameInput).toBeVisible();
    await expect(userSetupPage.emailInput).toBeVisible();
    await expect(userSetupPage.submitButton).toBeVisible();
  });

  test('should show validation error when name is too short', async ({ userSetupPage }) => {
    await userSetupPage.nameInput.fill('A');
    await userSetupPage.submitButton.click();
    await expect(userSetupPage.page.getByText('Name must be at least 2 characters')).toBeVisible();
  });

  test('should show validation error when email is invalid', async ({ userSetupPage }) => {
    await userSetupPage.nameInput.fill('Jane');
    await userSetupPage.emailInput.fill('not-an-email');
    await userSetupPage.submitButton.click();
    await expect(userSetupPage.page.getByText('Enter a valid email address')).toBeVisible();
  });

  test('should show validation errors when form is submitted empty', async ({ userSetupPage }) => {
    await userSetupPage.submitButton.click();
    await expect(userSetupPage.page.getByText('Name must be at least 2 characters')).toBeVisible();
  });

  test('should create user and redirect to /lessons on valid submission', async ({ userSetupPage }) => {
    const email = `e2e-${Date.now()}@test.com`;
    await userSetupPage.fillAndSubmit('Jane Test', email);
    await expect(userSetupPage.page).toHaveURL('/lessons', { timeout: 10_000 });
  });

  test('should show user name in navbar after setup', async ({ userSetupPage }) => {
    const email = `e2e-${Date.now()}@test.com`;
    await userSetupPage.fillAndSubmit('Jane Test', email);
    await userSetupPage.page.waitForURL('/lessons');
    await expect(userSetupPage.page.getByText('Jane Test')).toBeVisible();
  });

  test('should replace "Get started" link with username after setup', async ({ userSetupPage }) => {
    const email = `e2e-${Date.now()}@test.com`;
    await userSetupPage.fillAndSubmit('Jane Test', email);
    await userSetupPage.page.waitForURL('/lessons');
    await expect(userSetupPage.page.getByRole('link', { name: 'Get started' })).not.toBeVisible();
  });

  test('should navigate to /setup from "Get started" link', async ({ page }) => {
    await page.evaluate(() => localStorage.removeItem('learn-english-user'));
    await page.goto('/lessons');
    await page.getByRole('link', { name: 'Get started' }).click();
    await expect(page).toHaveURL('/setup');
  });
});
