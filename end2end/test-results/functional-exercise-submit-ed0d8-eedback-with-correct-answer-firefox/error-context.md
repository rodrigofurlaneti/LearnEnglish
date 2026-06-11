# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: functional\exercise-submit.spec.ts >> Exercise Submission >> should submit a wrong answer and show failure feedback with correct answer
- Location: tests\functional\exercise-submit.spec.ts:64:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: getByText('Not quite')
Expected: visible
Timeout: 8000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 8000ms
  - waiting for getByText('Not quite')

```

```yaml
- navigation:
  - link "LearnEnglish":
    - /url: /
  - link "Lessons":
    - /url: /lessons
  - text: T Test User
- main:
  - button "← Lessons"
  - heading "Verb to Be" [level=1]
  - text: Beginner
  - button "Slides (8)"
  - button "Exercises (4)"
  - paragraph: "Complete the sentence: I ___ a student."
  - text: Multiple choice
  - button "am"
  - button "is"
  - button "are"
  - button "were"
  - paragraph: "Choose the correct sentence:"
  - text: Multiple choice
  - button "She am a teacher."
  - button "She is a teacher."
  - button "She are a teacher."
  - button "She be a teacher."
  - paragraph: What is the past form of "is"?
  - text: Multiple choice
  - button "was"
  - button "were"
  - button "be"
  - button "been"
  - paragraph: "Complete: They ___ students."
  - text: Fill in the blank
  - textbox "Type your answer…": definitely wrong answer xyz
  - button "Submit"
```

# Test source

```ts
  1   | import { test, expect } from '../../fixtures';
  2   | import { createTestUser, getLessons, getLessonDetail } from '../../helpers/api';
  3   | 
  4   | test.describe('Exercise Submission', () => {
  5   |   let userId: string;
  6   |   let lessonWithExercises: { id: string; exercises: Array<{ id: string; exerciseType: string; correctAnswer: string; optionsJson?: string }> };
  7   | 
  8   |   test.beforeAll(async ({ request }) => {
  9   |     // Find a lesson with exercises
  10  |     const lessons = await getLessons(request);
  11  |     for (const lesson of lessons) {
  12  |       const detail = await getLessonDetail(request, lesson.id);
  13  |       if (detail.exercises && detail.exercises.length > 0) {
  14  |         lessonWithExercises = detail;
  15  |         break;
  16  |       }
  17  |     }
  18  |   });
  19  | 
  20  |   test.beforeEach(async ({ page, request }) => {
  21  |     const user = await createTestUser(request);
  22  |     userId = user.id;
  23  |     // Inject user into Zustand store via localStorage
  24  |     await page.goto('/lessons');
  25  |     await page.evaluate(
  26  |       ({ id, name, email }) => {
  27  |         localStorage.setItem(
  28  |           'learn-english-user',
  29  |           JSON.stringify({ state: { user: { id, name, email } }, version: 0 }),
  30  |         );
  31  |       },
  32  |       user,
  33  |     );
  34  |   });
  35  | 
  36  |   test('should show "Set up your profile" message when no user is logged in', async ({ page, request }) => {
  37  |     await page.evaluate(() => localStorage.removeItem('learn-english-user'));
  38  |     const lessons = await getLessons(request);
  39  |     await page.goto(`/lessons/${lessons[0].id}`);
  40  |     await page.getByRole('button', { name: /Exercises/ }).click();
  41  |     const noExercises = await page.getByText('No exercises').isVisible().catch(() => false);
  42  |     if (!noExercises) {
  43  |       await expect(page.getByText('Set up your profile')).toBeVisible();
  44  |     }
  45  |   });
  46  | 
  47  |   test('should submit a correct answer and show success feedback', async ({ page }) => {
  48  |     if (!lessonWithExercises) test.skip();
  49  |     await page.goto(`/lessons/${lessonWithExercises.id}`);
  50  |     await page.getByRole('button', { name: /Exercises/ }).click();
  51  | 
  52  |     const freeTextExercise = lessonWithExercises.exercises.find(
  53  |       (e) => e.exerciseType !== 'MultipleChoice',
  54  |     );
  55  |     if (!freeTextExercise) test.skip();
  56  | 
  57  |     const answerInput = page.getByPlaceholder('Type your answer…').first();
  58  |     await answerInput.fill(freeTextExercise!.correctAnswer);
  59  |     await page.getByRole('button', { name: 'Submit' }).first().click();
  60  | 
  61  |     await expect(page.getByText('Correct!')).toBeVisible({ timeout: 8_000 });
  62  |   });
  63  | 
  64  |   test('should submit a wrong answer and show failure feedback with correct answer', async ({ page }) => {
  65  |     if (!lessonWithExercises) test.skip();
  66  |     await page.goto(`/lessons/${lessonWithExercises.id}`);
  67  |     await page.getByRole('button', { name: /Exercises/ }).click();
  68  | 
  69  |     const freeTextExercise = lessonWithExercises.exercises.find(
  70  |       (e) => e.exerciseType !== 'MultipleChoice',
  71  |     );
  72  |     if (!freeTextExercise) test.skip();
  73  | 
  74  |     const answerInput = page.getByPlaceholder('Type your answer…').first();
  75  |     await answerInput.fill('definitely wrong answer xyz');
  76  |     await page.getByRole('button', { name: 'Submit' }).first().click();
  77  | 
> 78  |     await expect(page.getByText('Not quite')).toBeVisible({ timeout: 8_000 });
      |                                               ^ Error: expect(locator).toBeVisible() failed
  79  |     await expect(page.getByText('Correct answer:')).toBeVisible();
  80  |   });
  81  | 
  82  |   test('should show validation error when submitting empty answer', async ({ page, request }) => {
  83  |     const lessons = await getLessons(request);
  84  |     let targetLesson = null;
  85  |     for (const lesson of lessons) {
  86  |       const detail = await getLessonDetail(request, lesson.id);
  87  |       if (detail.exercises?.some((e: { exerciseType: string }) => e.exerciseType !== 'MultipleChoice')) {
  88  |         targetLesson = detail;
  89  |         break;
  90  |       }
  91  |     }
  92  |     if (!targetLesson) test.skip();
  93  | 
  94  |     await page.goto(`/lessons/${targetLesson.id}`);
  95  |     await page.getByRole('button', { name: /Exercises/ }).click();
  96  |     await page.getByRole('button', { name: 'Submit' }).first().click();
  97  |     await expect(page.getByText('Please enter an answer')).toBeVisible();
  98  |   });
  99  | 
  100 |   test('should select and submit a multiple choice answer', async ({ page }) => {
  101 |     if (!lessonWithExercises) test.skip();
  102 |     const mcExercise = lessonWithExercises.exercises.find((e) => e.exerciseType === 'MultipleChoice');
  103 |     if (!mcExercise) test.skip();
  104 | 
  105 |     await page.goto(`/lessons/${lessonWithExercises.id}`);
  106 |     await page.getByRole('button', { name: /Exercises/ }).click();
  107 | 
  108 |     const options = JSON.parse(mcExercise!.optionsJson ?? '[]') as string[];
  109 |     if (options.length === 0) test.skip();
  110 | 
  111 |     await page.getByRole('button', { name: options[0] }).first().click();
  112 |     await page.getByRole('button', { name: 'Submit' }).first().click();
  113 | 
  114 |     await expect(
  115 |       page.getByText('Correct!').or(page.getByText('Not quite')),
  116 |     ).toBeVisible({ timeout: 8_000 });
  117 |   });
  118 | });
  119 | 
```