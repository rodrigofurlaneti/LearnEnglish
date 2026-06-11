# LearnEnglish — E2E Tests

Playwright test suite covering functional and non-functional requirements.

## Setup

```powershell
cd C:\Users\AMD\Documents\Claude\Projects\LearnEnglish\end2end
npm install
npx playwright install chromium firefox
```

## Running Tests

**All tests:**
```powershell
npm test
```

**Functional tests only:**
```powershell
npm run test:functional
```

**Non-functional tests only:**
```powershell
npm run test:non-functional
```

**Interactive UI mode:**
```powershell
npm run test:ui
```

**Headed (visible browser):**
```powershell
npm run test:headed
```

**View last report:**
```powershell
npm run report
```

## Requirements

Both servers must be running (or started via `webServer` in playwright.config.ts):

| Service  | URL                      |
|----------|--------------------------|
| Frontend | http://localhost:5173     |
| API      | http://localhost:5000     |

## Structure

```
end2end/
├── tests/
│   ├── functional/
│   │   ├── lessons-list.spec.ts      # Lessons page rendering + navigation
│   │   ├── lesson-detail.spec.ts     # Slides carousel + exercises tab
│   │   ├── exercise-submit.spec.ts   # Answer submission (correct/wrong/MC)
│   │   └── user-setup.spec.ts        # User creation form + validation
│   └── non-functional/
│       ├── performance.spec.ts       # Page load < 3s, LCP < 2500ms
│       ├── accessibility.spec.ts     # axe-core WCAG 2.0 AA
│       ├── responsive.spec.ts        # 375px → 1440px viewports
│       ├── error-handling.spec.ts    # 404, API errors, network failures
│       └── security.spec.ts          # XSS prevention, no data leakage
├── pages/                            # Page Object Model
├── fixtures/                         # Playwright custom fixtures
└── helpers/                          # API helpers for test setup
```
