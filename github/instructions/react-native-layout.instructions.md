---
applyTo: "**/layouts/*.tsx"
description: "React Native layout patterns for mobile prototype"
prototypeMode: "mobile"
---

# React Native Layout Template
**Used by:** Mobile prototype mode only  
**Purpose:** Flexbox-based layout patterns and common mobile UI structures

Create consistent layouts using React Native Flexbox with proper patterns:

## Basic Layout Patterns

```tsx
import React, { FC } from 'react'
import { View, StyleSheet, ScrollView } from 'react-native'
import { SafeAreaView } from 'react-native-safe-area-context'

// Full screen layout with safe area
export const FullScreenLayout: FC<{ children: React.ReactNode }> = ({ children }) => {
  return (
    <SafeAreaView style={styles.fullScreen}>
      <View style={styles.container}>
        {children}
      </View>
    </SafeAreaView>
  )
}

// Scrollable content layout
export const ScrollableLayout: FC<{ children: React.ReactNode }> = ({ children }) => {
  return (
    <SafeAreaView style={styles.fullScreen}>
      <ScrollView 
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {children}
      </ScrollView>
    </SafeAreaView>
  )
}

// Header + Content + Footer layout
export const HeaderFooterLayout: FC<{
  header: React.ReactNode
  children: React.ReactNode
  footer?: React.ReactNode
}> = ({ header, children, footer }) => {
  return (
    <SafeAreaView style={styles.fullScreen}>
      <View style={styles.headerContainer}>
        {header}
      </View>
      <View style={styles.contentContainer}>
        {children}
      </View>
      {footer && (
        <View style={styles.footerContainer}>
          {footer}
        </View>
      )}
    </SafeAreaView>
  )
}

const styles = StyleSheet.create({
  fullScreen: {
    flex: 1,
    backgroundColor: '#fff',
  },
  container: {
    flex: 1,
    padding: 16,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: 16,
  },
  headerContainer: {
    backgroundColor: '#6200EE',
    paddingHorizontal: 16,
    paddingVertical: 12,
  },
  contentContainer: {
    flex: 1,
    padding: 16,
  },
  footerContainer: {
    backgroundColor: '#f5f5f5',
    paddingHorizontal: 16,
    paddingVertical: 12,
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
  },
})
```

## Flexbox Layout Patterns

```tsx
import React from 'react'
import { View, StyleSheet } from 'react-native'

// Row layouts
export const RowLayout: FC<{ children: React.ReactNode }> = ({ children }) => (
  <View style={styles.row}>{children}</View>
)

export const RowSpaceBetween: FC<{ children: React.ReactNode }> = ({ children }) => (
  <View style={styles.rowSpaceBetween}>{children}</View>
)

export const RowCentered: FC<{ children: React.ReactNode }> = ({ children }) => (
  <View style={styles.rowCentered}>{children}</View>
)

// Column layouts
export const ColumnLayout: FC<{ children: React.ReactNode }> = ({ children }) => (
  <View style={styles.column}>{children}</View>
)

export const ColumnCentered: FC<{ children: React.ReactNode }> = ({ children }) => (
  <View style={styles.columnCentered}>{children}</View>
)

// Grid-like layouts
export const GridLayout: FC<{ children: React.ReactNode }> = ({ children }) => (
  <View style={styles.grid}>{children}</View>
)

export const GridItem: FC<{ children: React.ReactNode }> = ({ children }) => (
  <View style={styles.gridItem}>{children}</View>
)

const styles = StyleSheet.create({
  // Row layouts
  row: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  rowSpaceBetween: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  rowCentered: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
  },
  
  // Column layouts
  column: {
    flexDirection: 'column',
  },
  columnCentered: {
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
  },
  
  // Grid layouts
  grid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  gridItem: {
    width: '48%', // 2 columns with gap
    marginBottom: 16,
  },
})
```

## Card and List Layouts

```tsx
import React from 'react'
import { View, StyleSheet, FlatList } from 'react-native'

// Card container layout
export const CardLayout: FC<{ children: React.ReactNode }> = ({ children }) => (
  <View style={styles.card}>{children}</View>
)

// List item layout
export const ListItemLayout: FC<{ 
  left?: React.ReactNode
  children: React.ReactNode
  right?: React.ReactNode
}> = ({ left, children, right }) => (
  <View style={styles.listItem}>
    {left && <View style={styles.listItemLeft}>{left}</View>}
    <View style={styles.listItemContent}>{children}</View>
    {right && <View style={styles.listItemRight}>{right}</View>}
  </View>
)

// Section layout with title
export const SectionLayout: FC<{
  title: React.ReactNode
  children: React.ReactNode
}> = ({ title, children }) => (
  <View style={styles.section}>
    <View style={styles.sectionHeader}>{title}</View>
    <View style={styles.sectionContent}>{children}</View>
  </View>
)

const styles = StyleSheet.create({
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
    elevation: 5,
  },
  listItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  listItemLeft: {
    marginRight: 12,
  },
  listItemContent: {
    flex: 1,
  },
  listItemRight: {
    marginLeft: 12,
  },
  section: {
    marginBottom: 24,
  },
  sectionHeader: {
    marginBottom: 12,
    paddingHorizontal: 16,
  },
  sectionContent: {
    paddingHorizontal: 16,
  },
})
```

## Modal and Overlay Layouts

```tsx
import React from 'react'
import { View, StyleSheet, Modal, TouchableOpacity } from 'react-native'

// Full screen modal layout
export const FullScreenModal: FC<{
  visible: boolean
  onClose: () => void
  children: React.ReactNode
}> = ({ visible, onClose, children }) => (
  <Modal
    visible={visible}
    animationType="slide"
    presentationStyle="fullScreen"
  >
    <SafeAreaView style={styles.fullScreen}>
      <View style={styles.modalHeader}>
        <TouchableOpacity onPress={onClose} style={styles.closeButton}>
          {/* Close button content */}
        </TouchableOpacity>
      </View>
      <View style={styles.modalContent}>
        {children}
      </View>
    </SafeAreaView>
  </Modal>
)

// Bottom sheet layout
export const BottomSheetLayout: FC<{
  visible: boolean
  onClose: () => void
  children: React.ReactNode
}> = ({ visible, onClose, children }) => (
  <Modal
    visible={visible}
    animationType="slide"
    presentationStyle="pageSheet"
    transparent={true}
  >
    <View style={styles.overlay}>
      <TouchableOpacity 
        style={styles.overlayBackground} 
        onPress={onClose}
        activeOpacity={1}
      />
      <View style={styles.bottomSheet}>
        <View style={styles.bottomSheetHandle} />
        {children}
      </View>
    </View>
  </Modal>
)

const styles = StyleSheet.create({
  overlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'flex-end',
  },
  overlayBackground: {
    flex: 1,
  },
  bottomSheet: {
    backgroundColor: '#fff',
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    paddingHorizontal: 16,
    paddingBottom: 34, // Safe area bottom
    minHeight: 200,
  },
  bottomSheetHandle: {
    width: 40,
    height: 4,
    backgroundColor: '#ccc',
    borderRadius: 2,
    alignSelf: 'center',
    marginTop: 8,
    marginBottom: 16,
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  modalContent: {
    flex: 1,
    padding: 16,
  },
  closeButton: {
    padding: 8,
  },
})
```

## Form Layout Patterns

```tsx
import React from 'react'
import { View, StyleSheet } from 'react-native'

// Form container layout
export const FormLayout: FC<{ children: React.ReactNode }> = ({ children }) => (
  <View style={styles.form}>{children}</View>
)

// Form field layout
export const FormFieldLayout: FC<{
  label?: React.ReactNode
  children: React.ReactNode
  error?: React.ReactNode
}> = ({ label, children, error }) => (
  <View style={styles.formField}>
    {label && <View style={styles.formLabel}>{label}</View>}
    <View style={styles.formInput}>{children}</View>
    {error && <View style={styles.formError}>{error}</View>}
  </View>
)

// Form button layout
export const FormButtonLayout: FC<{ children: React.ReactNode }> = ({ children }) => (
  <View style={styles.formButtons}>{children}</View>
)

const styles = StyleSheet.create({
  form: {
    padding: 16,
  },
  formField: {
    marginBottom: 16,
  },
  formLabel: {
    marginBottom: 8,
  },
  formInput: {
    marginBottom: 4,
  },
  formError: {
    marginTop: 4,
  },
  formButtons: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 24,
    paddingHorizontal: 16,
  },
})
```

## Key Layout Principles

1. **Flexbox First**: Use flexbox for all layouts instead of absolute positioning
2. **Safe Areas**: Always wrap layouts in SafeAreaView for proper device handling
3. **Responsive**: Use flex: 1 for flexible sizing and percentage widths
4. **Spacing**: Use consistent padding and margins (8, 12, 16, 24)
5. **Shadows**: Apply consistent elevation and shadow patterns
6. **Accessibility**: Ensure proper touch targets (minimum 44px)
7. **Performance**: Use FlatList for long lists, avoid deep nesting