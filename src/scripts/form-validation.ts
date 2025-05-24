// Form Validation Logic
function handleFormSubmit(event: Event) {
    const form = event.target as HTMLFormElement;
    const requiredFields = form.querySelectorAll<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>('[aria-required="true"]');
    let firstInvalidField: HTMLElement | null = null;
    let formIsValid = true;

    requiredFields.forEach(field => {
        field.classList.remove('input-error');
        field.classList.remove('border-red-500', 'dark:border-red-400', 'focus:border-red-500', 'dark:focus:border-red-400');

        let isEmpty = false;
        const fieldType = field.type ? field.type.toLowerCase() : (field.tagName.toLowerCase() === 'select' ? 'select' : '');
        
        if (fieldType === 'checkbox') {
            isEmpty = !(field as HTMLInputElement).checked;
        } else if (fieldType === 'radio') {
            const radioGroup = form.querySelectorAll<HTMLInputElement>(`input[type="radio"][name="${field.name}"]`);
            let oneIsChecked = false;
            radioGroup.forEach(radio => {
                if (radio.checked) {
                    oneIsChecked = true;
                }
            });
            isEmpty = !oneIsChecked;
        } else {
            isEmpty = !field.value || field.value.trim() === '';
        }

        if (isEmpty) {
            formIsValid = false;
            field.classList.add('input-error');
            if (!firstInvalidField) {
                firstInvalidField = field;
            }
        }
    });

    const errorSummaryPlaceholder = form.querySelector('.form-validation-error-summary');
    const submitButton = form.querySelector<HTMLButtonElement>('button[type="submit"]');

    if (!formIsValid) {
        event.preventDefault();
        if (firstInvalidField) {
            firstInvalidField.focus();
        }
        if (errorSummaryPlaceholder) {
            errorSummaryPlaceholder.textContent = 'Please correct the highlighted fields.'; // TODO: Localize
            errorSummaryPlaceholder.classList.remove('hidden');
            setTimeout(() => {
                if (errorSummaryPlaceholder) {
                    errorSummaryPlaceholder.textContent = '';
                    errorSummaryPlaceholder.classList.add('hidden');
                }
            }, 5000);
        }
        if (submitButton && submitButton.dataset.originalHtml) {
            submitButton.innerHTML = submitButton.dataset.originalHtml;
            submitButton.disabled = false;
        }
    } else {
        if (errorSummaryPlaceholder) {
            errorSummaryPlaceholder.textContent = '';
            errorSummaryPlaceholder.classList.add('hidden');
        }
        // TODO: Trigger generic success toast: e.g., showToast("Form validation passed, submitting...", "info");
        if (submitButton) {
            if (!submitButton.dataset.originalHtml) {
                submitButton.dataset.originalHtml = submitButton.innerHTML;
            }
            submitButton.disabled = true;
            const loadingText = submitButton.dataset.loadingText || "Submitting..."; // TODO: Localize
            submitButton.innerHTML = `
                <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white inline-block" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                ${loadingText}
            `;
        }
        // TODO: If form submission were handled via AJAX and returned success:
        // showToast("Form submitted successfully!", "success");
        // TODO: If form submission were handled via AJAX and returned an error (after server-side validation):
        // Restore button:
        // if (submitButton && submitButton.dataset.originalHtml) {
        //     submitButton.innerHTML = submitButton.dataset.originalHtml;
        //     submitButton.disabled = false;
        // }
        // showToast("Server validation failed: " + serverErrorMessage, "error");
    }
}

export function initFormValidation(): void {
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', handleFormSubmit);
    });
}
