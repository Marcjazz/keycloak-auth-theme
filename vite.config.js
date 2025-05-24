import { defineConfig } from 'vite';
// import path from 'path'; // Import path if needed for resolving paths

export default defineConfig({
  build: {
    rollupOptions: {
      input: {
        // If src/main.ts and src/style.css are common for both themes:
        main: 'src/main.ts', 
        // If they need to be separate, you might have:
        // login: 'src/login-main.ts',
        // account: 'src/account-main.ts',
        // For now, stick to a single 'main' input.
      },
      output: [
        {
          dir: 'themes/modern-theme/login/resources',
          format: 'es', // Or 'iife', 'umd' depending on Keycloak's JS needs in FTLs
          entryFileNames: 'js/main.js',
          assetFileNames: (assetInfo) => {
            // Ensure assetInfo.name exists before calling endsWith
            if (assetInfo.name && assetInfo.name.endsWith('.css')) {
              return 'css/style.css';
            }
            return 'assets/[name].[hash][extname]';
          },
        },
        {
          dir: 'themes/modern-theme/account/resources',
          format: 'es', // Keep format consistent or adjust as needed
          entryFileNames: 'js/main.js',
          assetFileNames: (assetInfo) => {
            if (assetInfo.name && assetInfo.name.endsWith('.css')) {
              return 'css/style.css';
            }
            return 'assets/[name].[hash][extname]';
          },
        },
      ],
    },
    // Ensure Vite doesn't automatically clear the other theme's outDir.
    // Vite's default behavior for `emptyOutDir` might be sufficient if `outDir` 
    // is not specified at the top level of `build` when using multiple outputs.
    // If issues arise, you might need `emptyOutDir: false` at the top `build` level,
    // and handle cleaning manually in build scripts if needed.
    // For now, let this be default. (Vite default is true if outDir is project root, which is not the case here)
    // Setting emptyOutDir: false is safer when dealing with multiple outputs to avoid accidental cleaning.
    emptyOutDir: false, 
  },
});
