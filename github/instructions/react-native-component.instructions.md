---
applyTo: "**/screens/*.tsx"
description: "React Native screen component pattern for mobile prototype"
prototypeMode: "mobile"
---

# React Native Screen Component Template

Create functional screen components using TypeScript with proper React Native patterns:

```tsx
import React, { FC } from "react";
import { View, Text, StyleSheet, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";

interface ScreenNameProps {
  // Define prop types
  title: string;
  onAction?: () => void;
}

export const ScreenName: FC<ScreenNameProps> = ({ title, onAction }) => {
  return (
    <SafeAreaView style={styles.safeArea}>
      <ScrollView style={styles.container}>
        <View style={styles.content}>
          <Text style={styles.title}>{title}</Text>
          {/* Screen content here */}
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: "#fff",
  },
  container: {
    flex: 1,
  },
  content: {
    flex: 1,
    padding: 16,
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
    marginBottom: 16,
    textAlign: "center",
  },
});
```

## Key Patterns

1. **Functional Components**: Always use arrow functions with FC type
2. **Props Interface**: Define explicit TypeScript interfaces
3. **StyleSheet.create**: Use for all styling (better performance than inline)
4. **SafeAreaView**: Always wrap content for safe area handling (use react-native-safe-area-context)
5. **Export Pattern**: Named exports for all screen components
6. **File Naming**: PascalCase matching screen name (e.g., HomeScreen.tsx)

## Common Imports

```tsx
import React, { FC, useState, useEffect } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  ScrollView,
} from "react-native";
import {
  SafeAreaView,
  useSafeAreaInsets,
} from "react-native-safe-area-context";
```

## Navigation Props Pattern

```tsx
import { NativeStackScreenProps } from "@react-navigation/native-stack";

type RootStackParamList = {
  Home: undefined;
  Profile: { userId: string };
};

type Props = NativeStackScreenProps<RootStackParamList, "Home">;

export const HomeScreen: FC<Props> = ({ navigation, route }) => {
  // Screen implementation
};
```
