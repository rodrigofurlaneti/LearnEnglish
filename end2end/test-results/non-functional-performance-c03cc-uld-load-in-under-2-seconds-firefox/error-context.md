# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: non-functional\performance.spec.ts >> Performance >> user setup page should load in under 2 seconds
- Location: tests\non-functional\performance.spec.ts:24:7

# Error details

```
Error: expect(received).toBeLessThan(expected)

Expected: < 2000
Received:   2526
```

# Page snapshot

```yaml
- generic [ref=e3]:
  - navigation [ref=e4]:
    - generic [ref=e5]:
      - link "LearnEnglish" [ref=e6] [cursor=pointer]:
        - /url: /
      - link "Lessons" [ref=e8] [cursor=pointer]:
        - /url: /lessons
      - link "Get started" [ref=e9] [cursor=pointer]:
        - /url: /setup
  - main [ref=e10]:
    - generic [ref=e12]:
      - generic [ref=e13]:
        - generic [ref=e14]: 📚
        - heading "Get started" [level=1] [ref=e15]
        - paragraph [ref=e16]: Create your profile to track progress and submit answers.
      - generic [ref=e18]:
        - generic [ref=e19]:
          - generic [ref=e20]: Your name
          - textbox "Your name" [active] [ref=e21]:
            - /placeholder: Jane Smith
        - generic [ref=e22]:
          - generic [ref=e23]: Email address
          - textbox "Email address" [ref=e24]:
            - /placeholder: jane@example.com
        - button "Create profile" [ref=e25] [cursor=pointer]
      - paragraph [ref=e26]: Your data is stored locally on this device.
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | test.describe('Performance', () => {
  4  |   test('lessons page should load in under 3 seconds', async ({ page }) => {
  5  |     const start = Date.now();
  6  |     await page.goto('/lessons');
  7  |     await page.getByRole('heading', { name: 'Lessons' }).waitFor({ timeout: 3_000 });
  8  |     const elapsed = Date.now() - start;
  9  |     expect(elapsed).toBeLessThan(3_000);
  10 |   });
  11 | 
  12 |   test('lesson detail page should load in under 3 seconds', async ({ page, request }) => {
  13 |     const response = await request.get('http://localhost:5000/api/lessons');
  14 |     const lessons = await response.json();
  15 |     if (lessons.length === 0) test.skip();
  16 | 
  17 |     const start = Date.now();
  18 |     await page.goto(`/lessons/${lessons[0].id}`);
  19 |     await page.locator('h1').first().waitFor({ timeout: 3_000 });
  20 |     const elapsed = Date.now() - start;
  21 |     expect(elapsed).toBeLessThan(3_000);
  22 |   });
  23 | 
  24 |   test('user setup page should load in under 2 seconds', async ({ page }) => {
  25 |     const start = Date.now();
  26 |     await page.goto('/setup');
  27 |     await page.getByRole('heading', { name: 'Get started' }).waitFor({ timeout: 2_000 });
  28 |     const elapsed = Date.now() - start;
> 29 |     expect(elapsed).toBeLessThan(2_000);
     |                     ^ Error: expect(received).toBeLessThan(expected)
  30 |   });
  31 | 
  32 |   test('lessons page LCP should be under 2500ms', async ({ page }) => {
  33 |     await page.goto('/lessons');
  34 |     const lcp = await page.evaluate(
  35 |       () =>
  36 |         new Promise<number>((resolve) => {
  37 |           new PerformanceObserver((list) => {
  38 |             const entries = list.getEntries();
  39 |             resolve(entries[entries.length - 1].startTime);
  40 |           }).observe({ entryTypes: ['largest-contentful-paint'] });
  41 |           // fallback if LCP never fires
  42 |           setTimeout(() => resolve(0), 5000);
  43 |         }),
  44 |     );
  45 |     // 0 means not fired yet (no large content); non-zero should be < 2500
  46 |     if (lcp > 0) {
  47 |       expect(lcp).toBeLessThan(2500);
  48 |     }
  49 |   });
  50 | });
  51 | 
```