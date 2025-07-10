---
applyTo: "**/data/mockData.ts"
description: "Mock data structure for web prototype"
---

# Mock Data Configuration

Create comprehensive mock data sets:

```typescript
export interface User {
  id: string
  name: string
  email: string
  avatar: string
  role: 'admin' | 'user' | 'guest'
  createdAt: string
}

export interface Product {
  id: string
  name: string
  description: string
  price: number
  image: string
  category: string
  stock: number
}

export const mockUsers: User[] = [
  {
    id: 'user_1',
    name: 'John Doe',
    email: 'john@example.com',
    avatar: 'https://i.pravatar.cc/150?img=1',
    role: 'admin',
    createdAt: '2024-01-15T10:00:00Z',
  },
  {
    id: 'user_2',
    name: 'Jane Smith',
    email: 'jane@example.com',
    avatar: 'https://i.pravatar.cc/150?img=2',
    role: 'user',
    createdAt: '2024-01-16T14:30:00Z',
  },
]

export const mockProducts: Product[] = [
  {
    id: 'prod_1',
    name: 'Premium Widget',
    description: 'High-quality widget for all your needs',
    price: 99.99,
    image: 'https://via.placeholder.com/300x200',
    category: 'Electronics',
    stock: 50,
  },
  // Add 5-10 items per collection
]

// Helper functions
export const generateMockData = {
  user: (overrides?: Partial<User>): User => ({
    id: `user_${Date.now()}`,
    name: 'Generated User',
    email: `user${Date.now()}@example.com`,
    avatar: `https://i.pravatar.cc/150?img=${Math.floor(Math.random() * 70)}`,
    role: 'user',
    createdAt: new Date().toISOString(),
    ...overrides,
  }),
}
```

## Mock Data Guidelines

1. **Realistic Data**: Use believable names and values
2. **Image Placeholders**: Use pravatar.cc or placeholder.com
3. **Sufficient Quantity**: 5-10 items minimum per collection
4. **Type Safety**: Export interfaces for all data structures
5. **Helper Functions**: Include generators for dynamic data