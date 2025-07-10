---
applyTo: "**/data/mockData.ts"
description: "Mock data structure for prototype development"
prototypeMode: "universal"
---

# Mock Data Configuration
**Used by:** Both web and mobile prototype modes  
**Purpose:** Universal mock data structures for React and React Native prototypes

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
  {
    id: 'user_3',
    name: 'Mike Johnson',
    email: 'mike@example.com',
    avatar: 'https://i.pravatar.cc/150?img=3',
    role: 'user',
    createdAt: '2024-01-17T09:15:00Z',
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
  {
    id: 'prod_2',
    name: 'Smart Device',
    description: 'Innovative smart device for modern living',
    price: 149.99,
    image: 'https://via.placeholder.com/300x200',
    category: 'Electronics',
    stock: 25,
  },
  {
    id: 'prod_3',
    name: 'Comfort Chair',
    description: 'Ergonomic chair for maximum comfort',
    price: 299.99,
    image: 'https://via.placeholder.com/300x200',
    category: 'Furniture',
    stock: 15,
  },
]

// Mobile-specific mock data (notifications, tasks, etc.)
export interface Notification {
  id: string
  title: string
  body: string
  time: string
  read: boolean
  type: 'info' | 'warning' | 'success' | 'error'
}

export const mockNotifications: Notification[] = [
  {
    id: 'notif_1',
    title: 'New Message',
    body: 'You have a new message from John',
    time: '2m ago',
    read: false,
    type: 'info',
  },
  {
    id: 'notif_2',
    title: 'Update Available',
    body: 'A new version is ready to install',
    time: '1h ago',
    read: true,
    type: 'success',
  },
  {
    id: 'notif_3',
    title: 'System Alert',
    body: 'Please check your account settings',
    time: '3h ago',
    read: false,
    type: 'warning',
  },
]

// Helper functions for both web and mobile
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
  product: (overrides?: Partial<Product>): Product => ({
    id: `prod_${Date.now()}`,
    name: 'Generated Product',
    description: 'Auto-generated product for testing',
    price: Math.floor(Math.random() * 500) + 10,
    image: 'https://via.placeholder.com/300x200',
    category: 'General',
    stock: Math.floor(Math.random() * 100) + 1,
    ...overrides,
  }),
  notification: (overrides?: Partial<Notification>): Notification => ({
    id: `notif_${Date.now()}`,
    title: 'Generated Notification',
    body: 'This is a generated notification',
    time: 'now',
    read: false,
    type: 'info',
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
6. **Universal Compatibility**: Works with both web (React) and mobile (React Native)
7. **Mobile-Specific**: Include notifications and mobile-relevant data types