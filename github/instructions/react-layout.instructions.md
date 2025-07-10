---
applyTo: "**/components/layout/*.tsx"
description: "Layout component pattern for web prototype"
prototypeMode: "web"
---

# Layout Component Template
**Used by:** Web prototype mode only  
**Purpose:** Material-UI based layout components for web structure

Create consistent layout wrapper:

```tsx
import { FC } from 'react'
import { Outlet, Link as RouterLink } from 'react-router-dom'
import {
  AppBar,
  Box,
  Toolbar,
  Typography,
  Button,
  Container,
} from '@mui/material'

export const MainLayout: FC = () => {
  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            App Name
          </Typography>
          <Button color="inherit" component={RouterLink} to="/">
            Home
          </Button>
          <Button color="inherit" component={RouterLink} to="/dashboard">
            Dashboard
          </Button>
        </Toolbar>
      </AppBar>
      
      <Box component="main" sx={{ flexGrow: 1, py: 3 }}>
        <Outlet />
      </Box>
      
      <Box component="footer" sx={{ py: 3, px: 2, mt: 'auto', backgroundColor: 'background.paper' }}>
        <Container maxWidth="lg">
          <Typography variant="body2" color="text.secondary" align="center">
            © 2024 App Name. All rights reserved.
          </Typography>
        </Container>
      </Box>
    </Box>
  )
}
```

## Layout Guidelines

1. **Flexbox Structure**: Full height with sticky footer
2. **Router Integration**: Use RouterLink with MUI Button
3. **Semantic HTML**: Use component prop for proper tags
4. **Responsive**: Container component for content width
5. **Outlet**: React Router v6 pattern for nested routes