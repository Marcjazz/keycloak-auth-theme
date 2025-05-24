# Modern Keycloak Theme

A modern, responsive, and highly customizable theme for Keycloak, built with TailwindCSS v4 and Vite. This theme provides a clean and user-friendly interface for both login and account management pages, with built-in dark mode support.

## Features

*   **Modern Design:** Clean and contemporary UI built with TailwindCSS v4.
*   **Responsive:** Adapts seamlessly to all devices (desktop, tablet, mobile).
*   **Dark Mode:** Full dark mode support, respecting user system preferences or manually toggled (if JS for toggle is implemented).
*   **Comprehensive Coverage:** Includes themes for both Login pages (login, register, error, etc.) and the Account Management console.
*   **FTL Based:** Leverages Keycloak's Freemarker Template (FTL) engine for integration.
*   **Configurable Assets:** Easily customize the logo and favicon via theme properties.
*   **Client-Side Validation:** Basic client-side validation hints for required fields.
*   **CI/CD Ready:** GitHub Actions workflow for automated theme building, packaging as a zip, and Docker image publishing.
*   **Local Development Environment:** Includes a Docker Compose setup for running Keycloak locally with live theme reloading.
*   **Security Focused:** Includes a recommended baseline Content Security Policy (CSP).

## Preview

<!-- TODO: Add screenshots of the theme -->
*   Login Page
*   Registration Page
*   Account Management Dashboard
*   Dark Mode Examples

## Requirements

*   **Keycloak:** Tested with Keycloak 26.x.x. Adaptations might be needed for other major versions.
*   **Node.js & Yarn:** Node.js (LTS recommended) and Yarn (v1.x) for theme development, building assets, and managing dependencies. npm can also be used.
*   **Docker & Docker Compose:** For running the local Keycloak development environment.

## Getting Started / Local Development

Follow these steps to get the theme running locally with Keycloak for development:

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/your-username/keycloak-modern-auth-theme.git
    cd keycloak-modern-auth-theme
    ```

2.  **Install Dependencies:**
    ```bash
    yarn install
    # or if using npm:
    # npm install
    ```

3.  **Build the Theme (Initial Build):**
    While the development setup uses watch mode, an initial build can be useful.
    ```bash
    yarn build
    # or npm run build
    ```

4.  **Run Keycloak with Docker Compose:**
    This command starts a Keycloak instance with the local `themes/modern-theme` directory mounted, allowing for live updates when using `yarn dev`.
    ```bash
    docker-compose up
    ```
    *   The theme assets will be rebuilt automatically if you run `yarn dev` in a separate terminal.
    *   **Default Admin Credentials:** `admin` / `admin` (as defined in `compose.yml`).
    *   **Keycloak Access:** [http://localhost:8080](http://localhost:8080)
    *   **Admin Console:** [http://localhost:8080/admin/](http://localhost:8080/admin/)

5.  **Applying Realm Configuration:**
    *   The provided realm configuration (`.docker/keycloak-config/realm.theme.custom-01.json`) sets up the `custom-01` realm with `modern-theme` as the default for login and account, and enables features like registration.
    *   Keycloak's `start-dev` mode with the `--import-realm` option in `compose.yml` automatically imports this realm configuration on the first startup.
    *   **Manual Import (if needed):** If the realm is not automatically imported or you need to re-import, you can do so via the Keycloak Admin Console:
        1.  Go to the Admin Console.
        2.  If the `custom-01` realm doesn't exist, click "Create Realm".
        3.  If it exists and you want to update, you might need to delete and re-create or manually adjust settings.
        4.  For a new realm, provide a name (e.g., `custom-01`).
        5.  Once created (or if importing into master), you can often find an "Import" option under Realm Settings (or partial import features) to upload the `realm.theme.custom-01.json` file. *Note: Direct full realm import into an existing realm might overwrite settings, be cautious.*

## Theme Integration into an Existing Keycloak Instance

You have two main options for integrating the `modern-theme` into your Keycloak server:

### Option 1: Using the Packaged Theme (Zip)

The CI/CD pipeline (GitHub Actions) automatically builds the theme and creates a `modern-theme.zip` artifact with each release or push to the main branch.

1.  **Download:** Download the `modern-theme.zip` artifact from the GitHub Actions workflow run or from a release.
2.  **Extract:** Extract the `modern-theme.zip` file. This will typically contain a `modern-theme` directory.
3.  **Deploy:** Copy the extracted `modern-theme` directory into your Keycloak server's `themes/` directory.
    ```
    KEYCLOAK_HOME/
    └── themes/
        └── modern-theme/  <-- Copy here
            ├── account/
            ├── login/
            └── theme.properties (this one is for the overall theme, not typically used directly)
    ```

### Option 2: Building from Source

1.  **Clone Repository:**
    ```bash
    git clone https://github.com/your-username/keycloak-modern-auth-theme.git
    cd keycloak-modern-auth-theme
    ```
2.  **Install Dependencies:**
    ```bash
    yarn install
    ```
3.  **Build Theme Assets:**
    ```bash
    yarn build
    ```
    This command compiles the TailwindCSS and any TypeScript/JavaScript into the `themes/modern-theme/{login,account}/resources/` directories.
4.  **Deploy:** Copy the entire `themes/modern-theme` directory into your Keycloak server's `themes/` directory.

### Activating the Theme

1.  Log in to your Keycloak Admin Console.
2.  Select the realm where you want to apply the theme.
3.  Go to **Realm Settings** -> **Themes**.
4.  From the dropdown menus:
    *   Select `modern-theme` for **Login Theme**.
    *   Select `modern-theme` for **Account Theme**.
5.  Click **Save**.
6.  The theme should now be active for your realm. You might need to clear your browser cache or Keycloak's theme cache in some cases (see Troubleshooting).

## Configuration

### Dynamic Assets (Logo & Favicon)

You can customize the logo and favicon displayed in the theme without modifying the FTL files directly. This is done by providing URLs in the respective `theme.properties` files for the login and account themes.

Create or edit the following files:
*   `themes/modern-theme/login/theme.properties`
*   `themes/modern-theme/account/theme.properties`

Add the following lines, replacing the example URLs with your actual asset URLs:

```properties
# Example for themes/modern-theme/login/theme.properties
# (and/or themes/modern-theme/account/theme.properties)

# URL for your theme's logo
logoUrl=https://your-cdn.com/path/to/your-logo.png

# URL for your theme's favicon
faviconUrl=https://your-cdn.com/path/to/your-favicon.ico
```

If these properties are not set, the theme will not display a custom logo/favicon (the browser might look for a default `/favicon.ico` at the root).

### Realm Settings

Several Keycloak features that interact with the theme are configured at the realm level:
*   **User Registration:** Enabled via `registrationAllowed: true`.
*   **Email as Username:** Configured via `registrationEmailAsUsername: true`.
*   **Login with Email:** Enabled via `loginWithEmailAllowed: true`.
*   **Password Reset:** Enabled via `resetPasswordAllowed: true`.
*   **Internationalization:** Enabled via `internationalizationEnabled: true`, with `supportedLocales` and `defaultLocale`.

These are pre-configured in the provided `.docker/keycloak-config/realm.theme.custom-01.json` file for the local Docker setup. For existing Keycloak instances, ensure these are set appropriately in your realm's configuration via the Admin Console.

## Customization / Extending the Theme

This theme is designed to be customizable:

*   **FTL Templates:** All HTML structure is defined in Freemarker Template (FTL) files located in:
    *   `themes/modern-theme/login/` for login pages.
    *   `themes/modern-theme/account/` for account management pages.
    You can modify these files to change layout, add or remove elements.

*   **Styles (TailwindCSS):**
    *   Styling is primarily done using TailwindCSS utility classes directly in the FTL templates.
    *   The main CSS entry point is `src/style.css`, which imports Tailwind.
    *   TailwindCSS configuration is in `tailwind.config.js`. You can customize your theme (colors, fonts, spacing, etc.) here.
    *   PostCSS configuration is in `postcss.config.js`.

*   **JavaScript:**
    *   Custom client-side JavaScript can be added to `src/main.ts`. This file is compiled by Vite and included in both login and account themes (as `js/main.js`).
    *   The current `main.ts` includes basic form validation and mobile menu toggling for the account theme.

*   **Rebuilding:** After making changes to `src/` files or Tailwind configuration:
    *   For development with live updates (if Keycloak is running via `docker-compose up` with mounted volumes):
        ```bash
        yarn dev
        ```
    *   For a one-time production build:
        ```bash
        yarn build
        ```

## Security

*   **XSS Prevention:** The theme uses Keycloak's `kcSanitize()` function for dynamic data displayed in FTL templates to prevent Cross-Site Scripting (XSS) vulnerabilities.
*   **Content Security Policy (CSP):** A recommended baseline CSP is provided to enhance security. This should be configured in your Keycloak realm (Realm Settings -> Security Defenses -> Headers -> Content-Security-Policy).

    **Recommended Baseline CSP:**
    ```csp
    default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; font-src 'self'; connect-src 'self'; form-action 'self'; frame-ancestors 'self'; object-src 'none'; base-uri 'self';
    ```

    **Important Customization for CSP:**
    *   **External Images (Logo/Favicon):** If you use `logoUrl` or `faviconUrl` pointing to external domains, add those hostnames to the `img-src` directive.
        *   Example: `img-src 'self' data: your-logo-host.com your-favicon-host.com;`
    *   **External Fonts:** If you use web fonts from CDNs (e.g., Google Fonts), add their hostnames to `font-src`.
        *   Example: `font-src 'self' fonts.googleapis.com fonts.gstatic.com;`
    *   **reCAPTCHA (if enabled):** If you enable reCAPTCHA, you'll need to add Google's domains:
        *   `script-src`: Add `https://www.google.com/recaptcha/ https://www.gstatic.com/recaptcha/`
        *   `frame-src`: Add `https://www.google.com/recaptcha/ https://recaptcha.google.com/recaptcha/` (and adjust `frame-ancestors` if needed)
    *   **`style-src 'unsafe-inline'`**: This is included for compatibility as Keycloak or its dependencies might use inline styles. For a stricter policy, try removing it and test thoroughly.

## Build Process & CI/CD

*   **Vite:** The theme uses Vite for fast and modern frontend tooling, building assets (CSS, JS) into the `themes/modern-theme/{login,account}/resources/` directories.
*   **GitHub Actions:** The workflow defined in `.github/workflows/publish-theme.yml` automates:
    1.  Installing dependencies.
    2.  Building the theme assets using Vite (`yarn build`).
    3.  Packaging the complete `themes/modern-theme` directory (including login, account, and their resources) into a `modern-theme.zip` archive. This archive is uploaded as a workflow artifact.
    4.  Building and publishing a Docker image containing Keycloak with the `modern-theme` pre-installed to GitHub Container Registry (ghcr.io).

## Troubleshooting

*   **Theme Not Appearing/Updating:**
    *   Clear Keycloak Caches: Go to Realm Settings -> Themes tab, and try toggling the theme to another one and back, or look for cache clearing options if available in your Keycloak version. Sometimes, a full Keycloak restart might be necessary.
    *   Browser Cache: Clear your browser's cache and cookies for the Keycloak domain.
    *   Ensure `loginTheme` and `accountTheme` are correctly set to `modern-theme` in your realm.
*   **Freemarker Errors:**
    *   Check Keycloak server logs for detailed error messages related to FTL parsing or rendering. This often points to syntax issues or incorrect variable usage in the templates.
*   **Tailwind Styles Not Applied:**
    *   Ensure `yarn build` (or `yarn dev`) has run successfully and populated the `resources/css/style.css` files in both `login` and `account` theme directories.
    *   Verify the CSS link in `login/template.ftl` and `account/template.ftl` correctly points to `${url.resourcesPath}/css/style.css`.

## License

This project is licensed under the MIT License.
