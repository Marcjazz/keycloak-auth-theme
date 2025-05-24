import './styles/style.css'; // Updated path
import { initMobileMenu } from './scripts/mobile-menu';
import { initFormValidation } from './scripts/form-validation';
import { initPasswordStrengthIndicator } from './scripts/password-strength';

document.addEventListener('DOMContentLoaded', () => {
    initMobileMenu();
    initFormValidation();
    initPasswordStrengthIndicator();

    // Placeholder for any other global initializations if needed in the future
    // console.log("Modern theme main.ts initialized.");
});