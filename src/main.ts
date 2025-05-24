import "./style.css";

document.addEventListener('DOMContentLoaded', () => {
    // Preserve any existing mobile menu toggle logic for account theme
    // Example from a previous subtask for account template.ftl:
    const mobileMenuButton = document.getElementById('mobile-menu-button');
    const mobileMenuCloseButton = document.getElementById('mobile-menu-close-button');
    const mobileMenu = document.getElementById('mobile-menu');

    if (mobileMenuButton && mobileMenu && mobileMenuCloseButton) {
        mobileMenuButton.addEventListener('click', () => {
            // The account/template.ftl uses: <div class="lg:hidden hidden" id="mobile-menu">
            // and the inner container is: <div class="fixed inset-y-0 left-0 max-w-xs w-full bg-white dark:bg-gray-800 p-4 z-50 shadow-xl">
            // Removing 'hidden' should make it visible based on its other styles.
            mobileMenu.classList.remove('hidden');
        });
        mobileMenuCloseButton.addEventListener('click', () => {
            mobileMenu.classList.add('hidden');
        });
        // Optional: Close mobile menu if clicking outside of it (on the overlay)
        // The overlay is the first direct child of #mobile-menu in the account template.
        if (mobileMenu.firstElementChild && mobileMenu.firstElementChild.classList.contains('fixed', 'inset-0', 'bg-black')) {
            mobileMenu.firstElementChild.addEventListener('click', (event) => {
                // Ensure the click is on the overlay itself, not its children (like the menu panel).
                if (event.target === mobileMenu.firstElementChild) {
                    mobileMenu.classList.add('hidden');
                }
            });
        }
    }

    // New form validation logic
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', handleFormSubmit);
    });
});

function handleFormSubmit(event: Event) {
    const form = event.target as HTMLFormElement;
    // Query for input, select, and textarea elements specifically
    const requiredFields = form.querySelectorAll<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>('[aria-required="true"]');
    let firstInvalidField: HTMLElement | null = null;
    let formIsValid = true;

    requiredFields.forEach(field => {
        // Remove previous error styling (border and custom class)
        field.classList.remove('input-error'); // Custom class for outline
        // Remove Tailwind border classes if they were added for error indication by JS previously
        field.classList.remove('border-red-500', 'dark:border-red-400', 'focus:border-red-500', 'dark:focus:border-red-400');
        // Add back default border classes if they were removed (assuming they are standard)
        // This part is tricky as default classes vary. It's better if .input-error handles all visual error states.
        // For this example, we'll rely on .input-error and the browser's default focus outline on error.

        let isEmpty = false;
        const fieldType = field.type ? field.type.toLowerCase() : (field.tagName.toLowerCase() === 'select' ? 'select' : '');
        
        if (fieldType === 'checkbox') {
            isEmpty = !(field as HTMLInputElement).checked;
        } else if (fieldType === 'radio') {
            // For radio buttons, check if any in the group with the same name is checked
            const radioGroup = form.querySelectorAll<HTMLInputElement>(`input[type="radio"][name="${field.name}"]`);
            let oneIsChecked = false;
            radioGroup.forEach(radio => {
                if (radio.checked) {
                    oneIsChecked = true;
                }
            });
            isEmpty = !oneIsChecked;
        } else { // Handles text, password, email, textarea, select-one, etc.
            isEmpty = !field.value || field.value.trim() === '';
        }

        if (isEmpty) {
            formIsValid = false;
            field.classList.add('input-error'); // Add error class for outline
            if (!firstInvalidField) {
                firstInvalidField = field;
            }
            // console.warn(`Validation failed: Field ${field.name || field.id} is required.`);
        }
    });

    if (!formIsValid) {
        event.preventDefault(); // Prevent form submission
        // console.warn('Form submission prevented due to validation errors.', form.id || form.name || form);
        if (firstInvalidField) {
            firstInvalidField.focus(); 
            // Attempt to scroll to the field for better UX
            // firstInvalidField.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
        // Display a general error message on the form (this needs a dedicated element in FTL)
        // This relies on the template.ftl having a #kc-feedback-message element.
        const feedbackMessageContainer = document.getElementById('kc-feedback-message'); // General feedback container from template
        if (feedbackMessageContainer) {
            // Update message content and style - this example assumes template.ftl handles message types
            // For a simple validation error, we'll make it look like a standard error message.
            // This might conflict if there's already a server-side message.
            // A more robust solution would be a dedicated client-side error message area per form.
            // For now, we'll just log and focus.
            console.warn("Client-side validation failed. Please check required fields.");
        }
    }
}