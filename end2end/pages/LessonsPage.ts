import { Page, Locator, expect } from '@playwright/test';

export class LessonsPage {
  readonly page: Page;
  readonly heading: Locator;
  readonly lessonCards: Locator;
  readonly lessonsCount: Locator;
  readonly navBrand: Locator;

  constructor(page: Page) {
    this.page = page;
    this.heading = page.getByRole('heading', { name: 'Lessons' });
    this.lessonCards = page.locator('[style*="cursor: pointer"]');
    this.lessonsCount = page.getByText(/lessons available/);
    this.navBrand = page.getByText('LearnEnglish').first();
  }

  async goto() {
    await this.page.goto('/lessons');
  }

  async waitForLoad() {
    await expect(this.heading).toBeVisible();
    await expect(this.lessonsCount).toBeVisible();
  }

  async getLessonCards() {
    return this.page.locator('div[style*="cursor: pointer"]').all();
  }

  async clickLesson(index: number) {
    const cards = await this.getLessonCards();
    await cards[index].click();
  }

  async getLessonTitles(): Promise<string[]> {
    const cards = await this.getLessonCards();
    const titles: string[] = [];
    for (const card of cards) {
      const title = await card.locator('h3').innerText();
      titles.push(title);
    }
    return titles;
  }

  async expectLessonCount(count: number) {
    await expect(this.page.getByText(`${count} lessons available`)).toBeVisible();
  }
}
