---
applyTo: "**/services/*.ts"
description: "API service pattern for web and mobile prototypes"
prototypeMode: "universal"
---

# Service Layer with Mock Data
**Used by:** Web prototype mode, Mobile prototype mode  
**Purpose:** Universal API service pattern for both platforms

Create service modules that simulate API calls:

```typescript
import { mockUsers, mockProducts } from '../data/mockData'

export interface ApiResponse<T> {
  data: T
  status: 'success' | 'error'
  message?: string
}

export const userService = {
  getAll: async (): Promise<ApiResponse<typeof mockUsers>> => {
    // Simulate network delay
    await new Promise(resolve => setTimeout(resolve, 500))
    
    return {
      data: mockUsers,
      status: 'success',
    }
  },

  getById: async (id: string): Promise<ApiResponse<typeof mockUsers[0]>> => {
    await new Promise(resolve => setTimeout(resolve, 300))
    
    const user = mockUsers.find(u => u.id === id)
    
    if (!user) {
      return {
        data: null as any,
        status: 'error',
        message: 'User not found',
      }
    }
    
    return {
      data: user,
      status: 'success',
    }
  },

  create: async (user: Omit<typeof mockUsers[0], 'id'>): Promise<ApiResponse<typeof mockUsers[0]>> => {
    await new Promise(resolve => setTimeout(resolve, 800))
    
    const newUser = {
      ...user,
      id: `user_${Date.now()}`,
    }
    
    // In prototype, just return without persisting
    return {
      data: newUser,
      status: 'success',
    }
  },
}
```

## Service Patterns

1. **Mock Delays**: 300-800ms to simulate real API
2. **TypeScript Generics**: Proper typing for responses
3. **Error Simulation**: Return error states for testing
4. **Consistent Interface**: All services return ApiResponse<T>
5. **No Real Persistence**: Data resets on page reload