import { Page, Locator, expect } from '@playwright/test';

export class UserSetupPage {
  readonly page: Page;
  readonly heading: Locator;
  readonly nameInput: Locator;
  readonly emailInput: Locator;
  readonly submitButton: Locator;

  constructor(page: Page) {
    this.page = page;
    this.heading = page.getByRole('heading', { name: 'Get started' });
    this.nameInput = page.getByLabel('Your name');
    this.emailInput = page.getByLabel('Email address');
    this.submitButton = page.getByRole('button', { name: 'Create profile' });
  }

  async goto() {
    await this.page.goto('/setup');
  }

  async waitForLoad() {
    await expect(this.heading).toBeVisible();
  }

  async fillAndSubmit(name: string, email: string) {
    await this.nameInput.fill(name);
    await this.emailInput.fill(email);
    await this.submitButton.click();
  }

  async expectNameError(message: string) {
    await expect(this.page.getByText(message)).toBeVisible();
  }

  async expectEmailError(message: string) {
    await expect(this.page.getByText(message)).toBeVisible();
  }
}
