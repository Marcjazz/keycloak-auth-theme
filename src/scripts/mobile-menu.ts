export function initMobileMenu(): void {
    const mobileMenuButton = document.getElementById('mobile-menu-button');
    const mobileMenuCloseButton = document.getElementById('mobile-menu-close-button');
    const mobileMenu = document.getElementById('mobile-menu');

    if (mobileMenuButton && mobileMenu && mobileMenuCloseButton) {
        mobileMenuButton.addEventListener('click', () => {
            mobileMenu.classList.remove('hidden');
        });
        mobileMenuCloseButton.addEventListener('click', () => {
            mobileMenu.classList.add('hidden');
        });
        
        // Optional: Close mobile menu if clicking outside of it (on the overlay)
        // The overlay is the first direct child of #mobile-menu in the account template.
        const overlay = mobileMenu.firstElementChild;
        if (overlay) {
            // Check if the overlay has the expected classes before adding the event listener
            // This is what the original logic intended, now with optional chaining for safety.
            if (overlay.classList?.contains('fixed', 'inset-0', 'bg-black')) {
                overlay.addEventListener('click', (event) => {
                    // Ensure the click is on the overlay itself, not its children (like the menu panel).
                    if (event.target === overlay) {
                        mobileMenu.classList.add('hidden');
                    }
                });
            }
        }
    }
}
