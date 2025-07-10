---
applyTo: "**/App.tsx"
description: "React Router setup for web prototype"
prototypeMode: "web"
---

# React Router Setup
**Used by:** Web prototype mode only  
**Purpose:** React Router setup with Material-UI integration for web navigation

Configure routing in App.tsx:

```tsx
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import { ThemeProvider, CssBaseline } from '@mui/material'
import { theme } from './theme'

// Pages
import HomePage from './pages/HomePage'
import DashboardPage from './pages/DashboardPage'
import ProfilePage from './pages/ProfilePage'
import NotFoundPage from './pages/NotFoundPage'

// Layout
import { MainLayout } from './components/layout/MainLayout'

function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<MainLayout />}>
            <Route index element={<HomePage />} />
            <Route path="dashboard" element={<DashboardPage />} />
            <Route path="profile/:id" element={<ProfilePage />} />
            <Route path="404" element={<NotFoundPage />} />
            <Route path="*" element={<Navigate to="/404" replace />} />
          </Route>
        </Routes>
      </BrowserRouter>
    </ThemeProvider>
  )
}

export default App
```

## Routing Patterns

1. **Nested Routes**: Use layout wrapper for common UI
2. **Index Route**: Default route for parent path
3. **Dynamic Routes**: Use :param for dynamic segments
4. **404 Handling**: Catch-all route with redirect
5. **Provider Order**: Theme → Router → Routes