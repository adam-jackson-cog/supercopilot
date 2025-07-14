---
applyTo: "**/navigation/*.tsx"
description: "React Navigation setup for mobile prototype"
prototypeMode: "mobile"
---

# React Native Navigation Template

Create navigation structure using React Navigation with proper TypeScript patterns:

## Stack Navigator Setup

```tsx
import React from "react";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { HomeScreen } from "../screens/HomeScreen";
import { DetailsScreen } from "../screens/DetailsScreen";

export type RootStackParamList = {
  Home: undefined;
  Details: { itemId: string };
  Profile: { userId: string };
};

const Stack = createNativeStackNavigator<RootStackParamList>();

export const RootNavigator = () => {
  return (
    <Stack.Navigator
      initialRouteName="Home"
      screenOptions={{
        headerStyle: {
          backgroundColor: "#6200EE",
        },
        headerTintColor: "#fff",
        headerTitleStyle: {
          fontWeight: "bold",
        },
      }}
    >
      <Stack.Screen
        name="Home"
        component={HomeScreen}
        options={{ title: "Home" }}
      />
      <Stack.Screen
        name="Details"
        component={DetailsScreen}
        options={{ title: "Details" }}
      />
      <Stack.Screen
        name="Profile"
        component={ProfileScreen}
        options={{ title: "Profile" }}
      />
    </Stack.Navigator>
  );
};
```

## Tab Navigator Setup

```tsx
import React from "react";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { Ionicons } from "@expo/vector-icons";
import { HomeScreen } from "../screens/HomeScreen";
import { SettingsScreen } from "../screens/SettingsScreen";

export type TabParamList = {
  HomeTab: undefined;
  SettingsTab: undefined;
};

const Tab = createBottomTabNavigator<TabParamList>();

export const TabNavigator = () => {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        tabBarIcon: ({ focused, color, size }) => {
          let iconName: keyof typeof Ionicons.glyphMap;

          if (route.name === "HomeTab") {
            iconName = focused ? "home" : "home-outline";
          } else if (route.name === "SettingsTab") {
            iconName = focused ? "settings" : "settings-outline";
          }

          return <Ionicons name={iconName} size={size} color={color} />;
        },
        tabBarActiveTintColor: "#6200EE",
        tabBarInactiveTintColor: "gray",
      })}
    >
      <Tab.Screen
        name="HomeTab"
        component={HomeScreen}
        options={{ title: "Home" }}
      />
      <Tab.Screen
        name="SettingsTab"
        component={SettingsScreen}
        options={{ title: "Settings" }}
      />
    </Tab.Navigator>
  );
};
```

## App Container Setup

```tsx
import React from "react";
import { NavigationContainer } from "@react-navigation/native";
import { RootNavigator } from "./navigation/RootNavigator";

export default function App() {
  return (
    <NavigationContainer>
      <RootNavigator />
    </NavigationContainer>
  );
}
```

## Screen Props Pattern

```tsx
import React, { FC } from 'react'
import { NativeStackScreenProps } from '@react-navigation/native-stack'
import { RootStackParamList } from '../navigation/RootNavigator'

type Props = NativeStackScreenProps<RootStackParamList, 'Details'>

export const DetailsScreen: FC<Props> = ({ navigation, route }) => {
  const { itemId } = route.params

  const handleGoBack = () => {
    navigation.goBack()
  }

  const handleNavigateToProfile = () => {
    navigation.navigate('Profile', { userId: '123' })
  }

  return (
    // Screen implementation
  )
}
```

## Key Patterns

1. **Type Safety**: Always define param lists as TypeScript types
2. **Navigator Factory**: Use `createNativeStackNavigator<ParamList>()`
3. **Screen Props**: Use specific screen props types from React Navigation
4. **Navigation Actions**: Use typed navigation methods (navigate, goBack, etc.)
5. **Screen Options**: Configure headers, tabs, and transitions consistently

## Common Navigation Actions

```tsx
// Navigate with parameters
navigation.navigate("Details", { itemId: "42" });

// Navigate without parameters
navigation.navigate("Home");

// Go back
navigation.goBack();

// Replace current screen
navigation.replace("Login");

// Reset navigation stack
navigation.reset({
  index: 0,
  routes: [{ name: "Home" }],
});
```

## Nested Navigation Pattern

```tsx
// Tab navigator inside stack navigator
export const AppNavigator = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="Main"
        component={TabNavigator}
        options={{ headerShown: false }}
      />
      <Stack.Screen name="Details" component={DetailsScreen} />
      <Stack.Screen name="Profile" component={ProfileScreen} />
    </Stack.Navigator>
  );
};
```
