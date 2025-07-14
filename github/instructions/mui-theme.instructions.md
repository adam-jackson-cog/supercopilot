---
applyTo: "**/theme/*.ts"
description: "Material-UI theme configuration for web prototype"
prototypeMode: "web"
---

# Material-UI Theme Configuration

Create consistent theme configuration:

```typescript
import { createTheme } from "@mui/material/styles";

export const theme = createTheme({
  palette: {
    mode: "light",
    primary: {
      main: "#1976d2",
    },
    secondary: {
      main: "#dc004e",
    },
    background: {
      default: "#f5f5f5",
    },
  },
  typography: {
    h4: {
      fontWeight: 600,
    },
    h6: {
      fontWeight: 500,
    },
  },
  shape: {
    borderRadius: 8,
  },
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          textTransform: "none",
        },
      },
    },
    MuiCard: {
      defaultProps: {
        elevation: 2,
      },
    },
  },
});
```

## Theme Guidelines

1. **Consistent Spacing**: Use theme.spacing() multiples
2. **Typography Scale**: Stick to MUI's predefined variants
3. **Component Defaults**: Override via components section
4. **No Hardcoded Colors**: Always reference theme palette
5. **Border Radius**: Use consistent shape.borderRadius
