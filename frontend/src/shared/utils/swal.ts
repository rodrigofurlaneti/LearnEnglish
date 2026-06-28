import Swal from 'sweetalert2';

/* ────────────────────────────────────────────────────────────────
   LearnEnglish — SweetAlert2 helpers
   Centralises all toast/modal styling so the whole app speaks one
   visual language.
──────────────────────────────────────────────────────────────── */

const BASE = Swal.mixin({
  customClass: {
    popup:          'le-swal-popup',
    title:          'le-swal-title',
    htmlContainer:  'le-swal-html',
    confirmButton:  'le-swal-confirm',
    cancelButton:   'le-swal-cancel',
  },
  buttonsStyling: false,
  allowOutsideClick: true,
  showClass: {
    popup: 'le-swal-enter',
  },
  hideClass: {
    popup: 'le-swal-exit',
  },
});

/* ── inject styles once ── */
if (typeof document !== 'undefined' && !document.getElementById('le-swal-styles')) {
  const style = document.createElement('style');
  style.id = 'le-swal-styles';
  style.textContent = `
    /* Keyframes */
    @keyframes le-swal-in  { from { opacity:0; transform:scale(.88) translateY(12px); } to  { opacity:1; transform:scale(1)   translateY(0); } }
    @keyframes le-swal-out { from { opacity:1; transform:scale(1);                    } to  { opacity:0; transform:scale(.92) translateY(-8px); } }

    .le-swal-enter { animation: le-swal-in  .22s cubic-bezier(.16,1,.3,1) both; }
    .le-swal-exit  { animation: le-swal-out .18s ease-in both; }

    /* Popup shell */
    .le-swal-popup {
      font-family: -apple-system, BlinkMacSystemFont, 'Inter', sans-serif !important;
      border-radius: 20px !important;
      padding: 32px 28px 24px !important;
      box-shadow: 0 24px 60px rgba(0,0,0,.14), 0 4px 16px rgba(0,0,0,.08) !important;
      max-width: 420px !important;
      width: 92vw !important;
      border: 1px solid rgba(0,0,0,.06) !important;
    }

    /* Title */
    .le-swal-title {
      font-size: 1.25rem !important;
      font-weight: 650 !important;
      letter-spacing: -.03em !important;
      color: #0f0f0f !important;
      margin-bottom: 8px !important;
      padding: 0 !important;
    }

    /* Body */
    .le-swal-html {
      font-size: .875rem !important;
      color: #555 !important;
      line-height: 1.6 !important;
      margin: 0 !important;
      padding: 0 !important;
    }
    .le-swal-html strong { color: #0f0f0f; font-weight: 600; }
    .le-swal-html .le-answer {
      display: inline-block;
      margin-top: 8px;
      padding: 4px 10px;
      background: #f3f3f3;
      border-radius: 6px;
      font-family: 'Geist Mono', 'Fira Code', monospace;
      font-size: .8rem;
      color: #0f0f0f;
    }

    /* Confirm button */
    .le-swal-confirm {
      padding: 10px 28px !important;
      border-radius: 100px !important;
      font-size: .875rem !important;
      font-weight: 600 !important;
      letter-spacing: -.01em !important;
      border: none !important;
      cursor: pointer !important;
      transition: opacity .15s, transform .1s !important;
      min-width: 100px !important;
    }
    .le-swal-confirm:hover  { opacity:.88 !important; }
    .le-swal-confirm:active { transform: scale(.97) !important; }

    .le-swal-confirm.swal2-confirm { background: #0f0f0f; color: #fff; }

    /* Icon overrides */
    .swal2-icon.swal2-success { border-color: #22c55e !important; color: #22c55e !important; }
    .swal2-icon.swal2-success [class^=swal2-success-line] { background: #22c55e !important; }
    .swal2-icon.swal2-success .swal2-success-ring { border-color: rgba(34,197,94,.25) !important; }

    .swal2-icon.swal2-error { border-color: #ef4444 !important; color: #ef4444 !important; }
    .swal2-icon.swal2-error [class^=swal2-x-mark-line] { background: #ef4444 !important; }
  `;
  document.head.appendChild(style);
}

/* ────────────────────────────────────────────────────────────────
   Public helpers
──────────────────────────────────────────────────────────────── */

export interface AnswerResult {
  isCorrect: boolean;
  correctAnswer?: string;
  explanation?: string;
}

/**
 * Show correct / incorrect feedback after an exercise is submitted.
 */
export async function showAnswerFeedback(result: AnswerResult): Promise<void> {
  if (result.isCorrect) {
    await BASE.fire({
      icon: 'success',
      title: '🎉 Correct!',
      html: result.explanation
        ? `<p>${result.explanation}</p>`
        : '<p>Great job! Keep it up.</p>',
      confirmButtonText: 'Continue',
    });
  } else {
    const answerHtml = result.correctAnswer
      ? `<span class="le-answer">${result.correctAnswer}</span>`
      : '';

    await BASE.fire({
      icon: 'error',
      title: 'Not quite…',
      html: [
        result.correctAnswer ? `<p>The correct answer is: ${answerHtml}</p>` : '',
        result.explanation   ? `<p style="margin-top:8px">${result.explanation}</p>` : '',
      ].filter(Boolean).join('') || '<p>Try again!</p>',
      confirmButtonText: 'Got it',
    });
  }
}

/**
 * Generic success toast (top-right, auto-dismiss).
 */
export function toastSuccess(message: string): void {
  Swal.fire({
    toast: true,
    position: 'top-end',
    icon: 'success',
    title: message,
    showConfirmButton: false,
    timer: 2500,
    timerProgressBar: true,
    customClass: { popup: 'le-swal-popup' },
    buttonsStyling: false,
  });
}

/**
 * Generic error toast.
 */
export function toastError(message: string): void {
  Swal.fire({
    toast: true,
    position: 'top-end',
    icon: 'error',
    title: message,
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    customClass: { popup: 'le-swal-popup' },
    buttonsStyling: false,
  });
}
