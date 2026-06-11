import { test, expect } from '../../fixtures';

test.describe('Lessons List', () => {
  test.beforeEach(async ({ lessonsPage }) => {
    await lessonsPage.goto();
    await lessonsPage.waitForLoad();
  });

  test('should display the lessons page heading', async ({ lessonsPage }) => {
    await expect(lessonsPage.heading).toBeVisible();
  });

  test('should load and display at least one lesson card', async ({ lessonsPage }) => {
    const cards = await lessonsPage.getLessonCards();
    expect(cards.length).toBeGreaterThan(0);
  });

  test('should display correct lesson count in subtitle', async ({ lessonsPage }) => {
    const cards = await lessonsPage.getLessonCards();
    await expect(
      lessonsPage.page.getByText(`${cards.length} lessons available`),
    ).toBeVisible();
  });

  test('should display lesson title, description and stats on each card', async ({ lessonsPage }) => {
    const cards = await lessonsPage.getLessonCards();
    const firstCard = cards[0];
    // title
    await expect(firstCard.locator('h3')).toBeVisible();
    // stats row: slides, exercises, min
    await expect(firstCard.getByText('slides')).toBeVisible();
    await expect(firstCard.getByText('exercises')).toBeVisible();
    await expect(firstCard.getByText('min')).toBeVisible();
  });

  test('should display a level badge on each card', async ({ lessonsPage }) => {
    const cards = await lessonsPage.getLessonCards();
    const firstCard = cards[0];
    // badge is a span with one of these texts
    const badge = firstCard.locator('span').filter({ hasText: /Beginner|Intermediate|Advanced/ });
    await expect(badge).toBeVisible();
  });

  test('should navigate to lesson detail when a card is clicked', async ({ lessonsPage }) => {
    await lessonsPage.clickLesson(0);
    await expect(lessonsPage.page).not.toHaveURL('/lessons');
    await expect(lessonsPage.page.url()).toContain('/lessons/');
    // should NOT be /lessons/undefined
    expect(lessonsPage.page.url()).not.toContain('undefined');
  });

  test('should redirect root "/" to "/lessons"', async ({ page }) => {
    await page.goto('/');
    await expect(page).toHaveURL(/\/lessons/);
  });

  test('should show navbar with brand and lessons link', async ({ lessonsPage }) => {
    await expect(lessonsPage.navBrand).toBeVisible();
    await expect(lessonsPage.page.getByRole('link', { name: 'Lessons' })).toBeVisible();
  });
});
