import { Page, Locator, expect } from '@playwright/test';

export class LessonDetailPage {
  readonly page: Page;
  readonly backButton: Locator;
  readonly lessonTitle: Locator;
  readonly slidesTab: Locator;
  readonly exercisesTab: Locator;
  readonly nextButton: Locator;
  readonly prevButton: Locator;
  readonly practiceButton: Locator;
  readonly progressBar: Locator;

  constructor(page: Page) {
    this.page = page;
    this.backButton = page.getByText('← Lessons');
    this.lessonTitle = page.locator('h1').first();
    this.slidesTab = page.getByRole('button', { name: /Slides/ });
    this.exercisesTab = page.getByRole('button', { name: /Exercises/ });
    this.nextButton = page.getByRole('button', { name: 'Next →' });
    this.prevButton = page.getByRole('button', { name: '← Previous' });
    this.practiceButton = page.getByRole('button', { name: 'Practice →' });
    this.progressBar = page.locator('[style*="background: var(--color-ink)"][style*="border-radius: var(--radius-full)"]').last();
  }

  async waitForLoad() {
    await expect(this.lessonTitle).toBeVisible();
    await expect(this.slidesTab).toBeVisible();
  }

  async getCurrentSlideNumber(): Promise<number> {
    const text = await this.page.locator('[style*="color: var(--color-ink-tertiary)"]').last().innerText();
    return parseInt(text.split('/')[0].trim());
  }

  async getTotalSlides(): Promise<number> {
    const text = await this.page.locator('[style*="color: var(--color-ink-tertiary)"]').last().innerText();
    return parseInt(text.split('/')[1].trim());
  }

  async goToExercises() {
    await this.exercisesTab.click();
  }

  async goBack() {
    await this.backButton.click();
  }

  async navigateToLastSlide() {
    while (await this.nextButton.isVisible()) {
      const isPractice = await this.practiceButton.isVisible();
      if (isPractice) break;
      await this.nextButton.click();
    }
  }
}
