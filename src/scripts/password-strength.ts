// Password Strength Indicator Logic
export function initPasswordStrengthIndicator(): void {
    const passwordInput = document.getElementById('password') as HTMLInputElement; // Assumes 'password' is the ID for new password on registration
    const passwordFeedback = document.getElementById('password-strength-feedback');

    if (passwordInput && passwordFeedback) {
        passwordInput.addEventListener('input', () => {
            const value = passwordInput.value;
            let strengthText = '';
            let strengthClass = '';

            // Removed initial check for !value to allow empty string to be handled by length check.

            let score = 0;
            // Score calculation should only happen if there's a value,
            // but length checks will handle the empty string appropriately first.
            if (value.length > 0) { // Only calculate score for non-empty strings
                if (value.length >= 8) score++;
                if (value.length >= 12) score++;
                
                let hasLower = /[a-z]/.test(value);
                let hasUpper = /[A-Z]/.test(value);
                let hasNumber = /\d/.test(value);
                let hasSymbol = /[^a-zA-Z0-9]/.test(value);

                if (hasLower && hasUpper) score++;
                if (hasNumber) score++;
                if (hasSymbol) score++;
            }
            
            // The condition value.length < 8 will now also catch value.length === 0
            if (value.length < 8) {
                strengthText = 'Weak (Too short)'; // TODO: Localize
                strengthClass = 'text-red-500 dark:text-red-400';
            } else { // value.length >= 8
                if (score < 3) {
                    strengthText = 'Medium (Consider more variety)'; // TODO: Localize
                    strengthClass = 'text-yellow-500 dark:text-yellow-400';
                } else if (score < 4 && value.length < 12) { // length is 8-11, score 3
                    strengthText = 'Medium (Good)'; // TODO: Localize
                    strengthClass = 'text-yellow-500 dark:text-yellow-400';
                } else if (score < 4) { // length >= 12, but score < 4 (missing variety)
                    strengthText = 'Strong (Good length, more variety recommended)'; // TODO: Localize
                    strengthClass = 'text-green-500 dark:text-green-400';
                } else if (score >= 4 && value.length < 12) { // length is 8-11, score >=4
                    strengthText = 'Strong (Good variety, longer is better)'; // TODO: Localize
                     strengthClass = 'text-green-500 dark:text-green-400';
                } else { // score >= 4 and length >= 12
                    strengthText = 'Very Strong'; // TODO: Localize
                    strengthClass = 'text-green-500 dark:text-green-400';
                }
            }
            
            // If the password input is completely empty, we might want to clear the feedback
            // instead of showing "Weak (Too short)". This is a UX choice.
            // The current refactoring makes it show "Weak (Too short)".
            // If specific empty state is needed:
            // if (value.length === 0) { // This block is removed to ensure empty string falls into "Weak (Too short)"
            //      strengthText = ''; 
            //      strengthClass = ''; 
            // }


            passwordFeedback.textContent = strengthText;
            passwordFeedback.className = `mt-1 text-xs ${strengthClass}`;
        });
    }
}
