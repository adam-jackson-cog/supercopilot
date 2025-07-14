---
applyTo: "**/hooks/*.ts"
description: "React hooks pattern for web and mobile prototypes"
prototypeMode: "universal"
---

# Custom Hook Template

Create reusable custom hooks:

```typescript
import { useState, useEffect, useCallback } from "react";
import { ApiResponse } from "@/services/types";

// Example: Data fetching hook
export function useApi<T>(
  fetchFn: () => Promise<ApiResponse<T>>,
  deps: any[] = []
) {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const refetch = useCallback(async () => {
    setLoading(true);
    setError(null);

    try {
      const response = await fetchFn();

      if (response.status === "error") {
        setError(response.message || "An error occurred");
      } else {
        setData(response.data);
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Unknown error");
    } finally {
      setLoading(false);
    }
  }, deps);

  useEffect(() => {
    refetch();
  }, [refetch]);

  return { data, loading, error, refetch };
}

// Example: Local storage hook
export function useLocalStorage<T>(key: string, initialValue: T) {
  const [storedValue, setStoredValue] = useState<T>(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      return initialValue;
    }
  });

  const setValue = (value: T | ((val: T) => T)) => {
    try {
      const valueToStore =
        value instanceof Function ? value(storedValue) : value;
      setStoredValue(valueToStore);
      window.localStorage.setItem(key, JSON.stringify(valueToStore));
    } catch (error) {
      console.error(`Error saving to localStorage:`, error);
    }
  };

  return [storedValue, setValue] as const;
}
```

## Hook Patterns

1. **Prefix**: Always start with "use"
2. **Generic Types**: Use TypeScript generics for flexibility
3. **Error Handling**: Include loading and error states
4. **Dependencies**: Proper dep arrays to avoid stale closures
5. **Return Tuple/Object**: Consistent return patterns
