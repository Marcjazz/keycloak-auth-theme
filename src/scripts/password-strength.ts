// Password Strength Indicator Logic
export function initPasswordStrengthIndicator(): void {
    const passwordInput = document.getElementById('password') as HTMLInputElement; // Assumes 'password' is the ID for new password on registration
    const passwordFeedback = document.getElementById('password-strength-feedback');

    if (passwordInput && passwordFeedback) {
        passwordInput.addEventListener('input', () => {
            const value = passwordInput.value;
            let strengthText = '';
            let strengthClass = '';

            if (!value) {
                passwordFeedback.textContent = '';
                passwordFeedback.className = 'mt-1 text-xs'; // Reset classes
                return;
            }

            let score = 0;
            if (value.length >= 8) score++;
            if (value.length >= 12) score++;
            
            let hasLower = /[a-z]/.test(value);
            let hasUpper = /[A-Z]/.test(value);
            let hasNumber = /\d/.test(value);
            let hasSymbol = /[^a-zA-Z0-9]/.test(value);

            if (hasLower && hasUpper) score++;
            if (hasNumber) score++;
            if (hasSymbol) score++;
            
            if (value.length === 0) {
                strengthText = '';
            } else if (value.length < 8) {
                strengthText = 'Weak (Too short)'; // TODO: Localize
                strengthClass = 'text-red-500 dark:text-red-400';
            } else {
                if (score < 3) {
                    strengthText = 'Medium (Consider more variety)'; // TODO: Localize
                    strengthClass = 'text-yellow-500 dark:text-yellow-400';
                } else if (score < 4 && value.length < 12) {
                    strengthText = 'Medium (Good)'; // TODO: Localize
                    strengthClass = 'text-yellow-500 dark:text-yellow-400';
                } else if (score < 4) {
                    strengthText = 'Strong (Good length, more variety recommended)'; // TODO: Localize
                    strengthClass = 'text-green-500 dark:text-green-400';
                } else if (score >= 4 && value.length < 12) {
                    strengthText = 'Strong (Good variety, longer is better)'; // TODO: Localize
                     strengthClass = 'text-green-500 dark:text-green-400';
                } else {
                    strengthText = 'Very Strong'; // TODO: Localize
                    strengthClass = 'text-green-500 dark:text-green-400';
                }
            }

            passwordFeedback.textContent = strengthText;
            passwordFeedback.className = `mt-1 text-xs ${strengthClass}`;
        });
    }
}
