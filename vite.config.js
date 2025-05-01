// vite.config.ts
import { defineConfig } from 'vite'

export default defineConfig({
  build: {
    outDir: './themes/login/resources/',
    rollupOptions: {
      input: 'src/main.ts',
      output: {
        entryFileNames: 'js/main.js',
        assetFileNames: (assetInfo) => {
          if (assetInfo.names.some((name) => name.endsWith('.css'))) {
            return 'css/style.css' // ✅ fixed CSS name
          }
          return 'assets/[name][extname]'
        },
      },
    },
  },
})
