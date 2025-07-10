---
applyTo: "tsconfig.json"
description: "TypeScript configuration for web and mobile prototypes"
prototypeMode: "universal"
---

# TypeScript Configuration Template
**Used by:** Web prototype mode, Mobile prototype mode  
**Purpose:** Universal TypeScript configuration for both platforms

Optimized tsconfig for Vite + React:

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "types": ["vite/client"],
    
    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    
    /* Linting */
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    
    /* Path aliases */
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@components/*": ["src/components/*"],
      "@pages/*": ["src/pages/*"],
      "@services/*": ["src/services/*"],
      "@data/*": ["src/data/*"],
      "@types/*": ["src/types/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

## TypeScript Settings

1. **Bundler Mode**: Optimized for Vite's esbuild
2. **Strict Mode**: All strict checks enabled
3. **Path Mapping**: Matches Vite aliases
4. **React JSX**: New transform (no React import needed)
5. **Isolated Modules**: Required for Vite