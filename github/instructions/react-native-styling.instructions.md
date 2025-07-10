---
applyTo: "**/styles/*.ts"
description: "React Native StyleSheet patterns for mobile prototype"
prototypeMode: "mobile"
---

# React Native Styling Template
**Used by:** Mobile prototype mode only  
**Purpose:** StyleSheet.create patterns and mobile-optimized styling

Create consistent styling using React Native StyleSheet with proper patterns:

## Basic StyleSheet Pattern

```typescript
import { StyleSheet, Dimensions } from 'react-native'

const { width, height } = Dimensions.get('window')

export const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    padding: 16,
  },
  header: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 16,
    textAlign: 'center',
    color: '#333',
  },
  button: {
    backgroundColor: '#6200EE',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
    alignItems: 'center',
    marginVertical: 8,
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  card: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    marginVertical: 8,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 3.84,
    elevation: 5, // Android shadow
  },
})
```

## Theme-based Styling

```typescript
import { StyleSheet } from 'react-native'

// Define theme colors
export const theme = {
  colors: {
    primary: '#6200EE',
    primaryVariant: '#3700B3',
    secondary: '#03DAC6',
    background: '#FFFFFF',
    surface: '#FFFFFF',
    error: '#B00020',
    onPrimary: '#FFFFFF',
    onSecondary: '#000000',
    onBackground: '#000000',
    onSurface: '#000000',
    onError: '#FFFFFF',
  },
  spacing: {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
  },
  typography: {
    h1: { fontSize: 32, fontWeight: 'bold' },
    h2: { fontSize: 24, fontWeight: 'bold' },
    h3: { fontSize: 20, fontWeight: '600' },
    body1: { fontSize: 16, fontWeight: 'normal' },
    body2: { fontSize: 14, fontWeight: 'normal' },
    caption: { fontSize: 12, fontWeight: 'normal' },
  },
}

export const createThemedStyles = () => StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background,
    padding: theme.spacing.md,
  },
  primaryButton: {
    backgroundColor: theme.colors.primary,
    paddingVertical: theme.spacing.sm,
    paddingHorizontal: theme.spacing.md,
    borderRadius: 8,
    alignItems: 'center',
  },
  primaryButtonText: {
    ...theme.typography.body1,
    color: theme.colors.onPrimary,
    fontWeight: '600',
  },
  title: {
    ...theme.typography.h2,
    color: theme.colors.onBackground,
    marginBottom: theme.spacing.md,
  },
})
```

## Responsive Styling

```typescript
import { StyleSheet, Dimensions, PixelRatio } from 'react-native'

const { width, height } = Dimensions.get('window')

// Screen size breakpoints
const isSmallScreen = width < 375
const isMediumScreen = width >= 375 && width < 768
const isLargeScreen = width >= 768

// Responsive font scaling
const scale = (size: number) => {
  const newSize = size * PixelRatio.getFontScale()
  return Math.round(PixelRatio.roundToNearestPixel(newSize))
}

export const responsiveStyles = StyleSheet.create({
  container: {
    flex: 1,
    paddingHorizontal: isSmallScreen ? 12 : isMediumScreen ? 16 : 24,
  },
  title: {
    fontSize: scale(isSmallScreen ? 20 : isMediumScreen ? 24 : 28),
    fontWeight: 'bold',
    marginBottom: 16,
  },
  grid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  gridItem: {
    width: isSmallScreen ? '100%' : isMediumScreen ? '48%' : '30%',
    marginBottom: 16,
  },
})
```

## Layout Patterns

```typescript
import { StyleSheet } from 'react-native'

export const layoutStyles = StyleSheet.create({
  // Flexbox patterns
  row: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  column: {
    flexDirection: 'column',
  },
  centerContent: {
    justifyContent: 'center',
    alignItems: 'center',
  },
  spaceBetween: {
    justifyContent: 'space-between',
  },
  spaceAround: {
    justifyContent: 'space-around',
  },
  spaceEvenly: {
    justifyContent: 'space-evenly',
  },
  
  // Common layouts
  fullScreen: {
    flex: 1,
  },
  absoluteFill: {
    ...StyleSheet.absoluteFillObject,
  },
  overlay: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
})
```

## Platform-specific Styling

```typescript
import { StyleSheet, Platform } from 'react-native'

export const platformStyles = StyleSheet.create({
  header: {
    ...Platform.select({
      ios: {
        paddingTop: 44, // iOS status bar height
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.22,
        shadowRadius: 2.22,
      },
      android: {
        paddingTop: 24, // Android status bar height
        elevation: 3,
      },
    }),
    backgroundColor: '#fff',
    borderBottomWidth: Platform.OS === 'ios' ? StyleSheet.hairlineWidth : 0,
    borderBottomColor: '#e0e0e0',
  },
  button: {
    borderRadius: Platform.OS === 'ios' ? 8 : 4,
    paddingVertical: Platform.OS === 'ios' ? 12 : 10,
  },
})
```

## Animation-ready Styles

```typescript
import { StyleSheet } from 'react-native'

export const animationStyles = StyleSheet.create({
  fadeContainer: {
    flex: 1,
    opacity: 1, // Will be animated
  },
  slideContainer: {
    flex: 1,
    transform: [{ translateX: 0 }], // Will be animated
  },
  scaleContainer: {
    flex: 1,
    transform: [{ scale: 1 }], // Will be animated
  },
  rotateContainer: {
    flex: 1,
    transform: [{ rotate: '0deg' }], // Will be animated
  },
})
```

## Safe Area Patterns

```typescript
import { StyleSheet } from 'react-native'
import { useSafeAreaInsets } from 'react-native-safe-area-context'

// Using useSafeAreaInsets hook for dynamic safe area handling
export const SafeAreaComponent = () => {
  const insets = useSafeAreaInsets()

  return (
    <View style={[styles.container, {
      paddingTop: insets.top,
      paddingBottom: Math.max(insets.bottom, 16), // Minimum padding
      paddingLeft: insets.left,
      paddingRight: insets.right,
    }]}>
      {/* Content */}
    </View>
  )
}

// Safe area styles with fallbacks
export const safeAreaStyles = StyleSheet.create({
  headerContainer: {
    backgroundColor: '#6200EE',
    paddingHorizontal: 16,
    // Top padding will be added dynamically with insets.top
  },
  footerContainer: {
    backgroundColor: '#fff',
    paddingHorizontal: 16,
    // Bottom padding will be added dynamically with Math.max(insets.bottom, 16)
  },
  fullScreenModal: {
    flex: 1,
    // Use SafeAreaView wrapper instead of manual padding for full-screen modals
  },
  safeContent: {
    flex: 1,
    // Apply safe area as margin for special cases like separators
    // Use with SafeAreaView mode="margin"
  },
})
```

## Key Patterns

1. **Performance**: Always use `StyleSheet.create()` for better performance
2. **Platform**: Use `Platform.select()` for platform-specific styles
3. **Responsive**: Consider screen dimensions and pixel density
4. **Themes**: Create consistent color and spacing systems
5. **Shadows**: Use both `shadowColor` (iOS) and `elevation` (Android)
6. **Flexbox**: Leverage flexbox for layout instead of absolute positioning
7. **Typography**: Define consistent text styles and scaling
8. **Safe Areas**: Use `useSafeAreaInsets` hook for dynamic safe area handling

## Common Style Objects

```typescript
// Reusable shadow styles
export const shadows = {
  small: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.18,
    shadowRadius: 1.0,
    elevation: 1,
  },
  medium: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5,
  },
  large: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.30,
    shadowRadius: 4.65,
    elevation: 8,
  },
}
```