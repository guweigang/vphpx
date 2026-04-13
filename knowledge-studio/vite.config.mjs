import { defineConfig } from "vite";

export default defineConfig({
  publicDir: false,
  build: {
    outDir: "public/assets",
    emptyOutDir: false,
    cssCodeSplit: false,
    rollupOptions: {
      input: "frontend/main.ts",
      output: {
        entryFileNames: "knowledge-studio.js",
        chunkFileNames: "chunks/[name]-[hash].js",
        assetFileNames: (assetInfo) => {
          if (assetInfo.names.includes("style.css")) {
            return "knowledge-studio.css";
          }
          return "assets/[name]-[hash][extname]";
        }
      }
    }
  }
});
