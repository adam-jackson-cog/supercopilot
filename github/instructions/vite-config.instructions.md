---
applyTo: "vite.config.ts"
description: "Vite configuration for web prototype"
prototypeMode: "web"
---

# Vite Configuration Template

Standard Vite config for React + TypeScript:

```typescript
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import path from "path";

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
      "@components": path.resolve(__dirname, "./src/components"),
      "@pages": path.resolve(__dirname, "./src/pages"),
      "@services": path.resolve(__dirname, "./src/services"),
      "@data": path.resolve(__dirname, "./src/data"),
      "@types": path.resolve(__dirname, "./src/types"),
    },
  },
  server: {
    port: 3000,
    open: true,
  },
});
```
