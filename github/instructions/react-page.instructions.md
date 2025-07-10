---
applyTo: "**/pages/*.tsx"
description: "Page component pattern for web prototype"
---

# React Page Component Template

Page components serve as route entry points with layout structure:

```tsx
import { FC, useState } from 'react'
import { Container, Box, Typography, Button, Stack } from '@mui/material'

interface PageNameProps {
  // Route params if needed
}

const PageName: FC<PageNameProps> = () => {
  const [state, setState] = useState<string>('')

  return (
    <Container maxWidth="lg">
      <Box sx={{ py: 4 }}>
        <Typography variant="h4" component="h1" gutterBottom>
          Page Title
        </Typography>
        
        <Stack spacing={3}>
          {/* Page content */}
        </Stack>
      </Box>
    </Container>
  )
}

export default PageName
```

## Page Patterns

1. **Default Export**: Pages use default export for routing
2. **Container**: Wrap content in MUI Container for responsive margins
3. **Box Padding**: Use consistent vertical padding (py: 4)
4. **Typography Hierarchy**: h4 for page titles, proper semantic HTML
5. **Stack Layout**: Use Stack for vertical spacing between sections