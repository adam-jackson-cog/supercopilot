---
applyTo: "**/*.tsx"
description: "React component creation pattern for web prototype"
prototypeMode: "web"
---

# React Component Template

Create functional components using TypeScript with proper typing and Material-UI integration:

```tsx
import { FC } from "react";
import { Box, Typography } from "@mui/material";

interface ComponentNameProps {
  // Define prop types
  title: string;
  onAction?: () => void;
}

export const ComponentName: FC<ComponentNameProps> = ({ title, onAction }) => {
  return (
    <Box sx={{ p: 2 }}>
      <Typography variant="h6">{title}</Typography>
    </Box>
  );
};
```

## Key Patterns

1. **Functional Components**: Always use arrow functions with FC type
2. **Props Interface**: Define explicit TypeScript interfaces
3. **Material-UI sx prop**: Use for all styling (no inline styles)
4. **Export Pattern**: Named exports for all components
5. **File Naming**: PascalCase matching component name
