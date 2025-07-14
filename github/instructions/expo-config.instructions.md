---
applyTo: "app.json"
description: "Expo app.json configuration for mobile prototype"
prototypeMode: "mobile"
---

# Expo App Configuration Template

Configure Expo projects with essential settings for rapid prototyping:

## Basic App Configuration

```json
{
  "expo": {
    "name": "Mobile Prototype",
    "slug": "mobile-prototype",
    "version": "1.0.0",
    "orientation": "portrait",
    "icon": "./assets/icon.png",
    "userInterfaceStyle": "light",
    "splash": {
      "image": "./assets/splash.png",
      "resizeMode": "contain",
      "backgroundColor": "#ffffff"
    },
    "assetBundlePatterns": ["**/*"],
    "ios": {
      "supportsTablet": true,
      "bundleIdentifier": "com.prototype.mobile"
    },
    "android": {
      "adaptiveIcon": {
        "foregroundImage": "./assets/adaptive-icon.png",
        "backgroundColor": "#ffffff"
      },
      "package": "com.prototype.mobile"
    },
    "web": {
      "favicon": "./assets/favicon.png"
    }
  }
}
```

## Essential Plugins Configuration

```json
{
  "expo": {
    "plugins": [
      "expo-router",
      [
        "expo-dev-client",
        {
          "launchMode": "most-recent"
        }
      ],
      [
        "expo-build-properties",
        {
          "android": {
            "compileSdkVersion": 35,
            "targetSdkVersion": 35,
            "buildToolsVersion": "35.0.0"
          },
          "ios": {
            "deploymentTarget": "13.0"
          }
        }
      ]
    ]
  }
}
```

## Navigation and Deep Linking

```json
{
  "expo": {
    "scheme": "mobile-prototype",
    "plugins": ["expo-router"],
    "experiments": {
      "typedRoutes": true
    }
  }
}
```

## Permissions Configuration

```json
{
  "expo": {
    "plugins": [
      [
        "expo-camera",
        {
          "cameraPermission": "Allow $(PRODUCT_NAME) to access your camera",
          "microphonePermission": "Allow $(PRODUCT_NAME) to access your microphone",
          "recordAudioAndroid": true
        }
      ],
      [
        "expo-location",
        {
          "locationAlwaysAndWhenInUsePermission": "Allow $(PRODUCT_NAME) to use your location."
        }
      ],
      [
        "expo-sensors",
        {
          "motionPermission": "Allow $(PRODUCT_NAME) to access your device motion."
        }
      ],
      [
        "expo-local-authentication",
        {
          "faceIDPermission": "Allow $(PRODUCT_NAME) to use Face ID."
        }
      ]
    ]
  }
}
```

## Complete Prototype Configuration

```json
{
  "expo": {
    "name": "Mobile Prototype",
    "slug": "mobile-prototype",
    "version": "1.0.0",
    "orientation": "portrait",
    "icon": "./assets/icon.png",
    "userInterfaceStyle": "light",
    "scheme": "mobile-prototype",
    "splash": {
      "image": "./assets/splash.png",
      "resizeMode": "contain",
      "backgroundColor": "#6200EE"
    },
    "assetBundlePatterns": ["**/*"],
    "ios": {
      "supportsTablet": true,
      "bundleIdentifier": "com.prototype.mobile",
      "requireFullScreen": false
    },
    "android": {
      "adaptiveIcon": {
        "foregroundImage": "./assets/adaptive-icon.png",
        "backgroundColor": "#6200EE"
      },
      "package": "com.prototype.mobile"
    },
    "web": {
      "favicon": "./assets/favicon.png",
      "bundler": "metro"
    },
    "plugins": [
      "expo-router",
      [
        "expo-dev-client",
        {
          "launchMode": "most-recent"
        }
      ],
      [
        "expo-build-properties",
        {
          "android": {
            "compileSdkVersion": 35,
            "targetSdkVersion": 35,
            "buildToolsVersion": "35.0.0"
          },
          "ios": {
            "deploymentTarget": "13.0"
          }
        }
      ],
      [
        "expo-screen-orientation",
        {
          "initialOrientation": "DEFAULT"
        }
      ]
    ],
    "experiments": {
      "typedRoutes": true
    },
    "extra": {
      "eas": {
        "projectId": "your-project-id"
      }
    }
  }
}
```

## Platform-Specific Configurations

### iOS Configuration

```json
{
  "expo": {
    "ios": {
      "supportsTablet": true,
      "bundleIdentifier": "com.prototype.mobile",
      "requireFullScreen": false,
      "buildNumber": "1",
      "infoPlist": {
        "UIBackgroundModes": ["background-audio"]
      },
      "entitlements": {
        "com.apple.security.application-groups": ["group.com.prototype.mobile"]
      }
    }
  }
}
```

### Android Configuration

```json
{
  "expo": {
    "android": {
      "package": "com.prototype.mobile",
      "versionCode": 1,
      "adaptiveIcon": {
        "foregroundImage": "./assets/adaptive-icon.png",
        "backgroundColor": "#6200EE"
      },
      "permissions": [
        "CAMERA",
        "RECORD_AUDIO",
        "ACCESS_FINE_LOCATION",
        "ACCESS_COARSE_LOCATION"
      ],
      "intentFilters": [
        {
          "action": "VIEW",
          "data": [
            {
              "scheme": "mobile-prototype"
            }
          ],
          "category": ["BROWSABLE", "DEFAULT"]
        }
      ]
    }
  }
}
```

## Asset Management

```json
{
  "expo": {
    "assetBundlePatterns": ["**/*"],
    "plugins": [
      [
        "expo-asset",
        {
          "assets": ["./assets/images/", "./assets/fonts/"]
        }
      ],
      [
        "expo-font",
        {
          "fonts": [
            "./assets/fonts/Inter-Regular.ttf",
            "./assets/fonts/Inter-Bold.ttf"
          ]
        }
      ]
    ]
  }
}
```

## Development Configuration

```json
{
  "expo": {
    "plugins": [
      [
        "expo-dev-client",
        {
          "launchMode": "most-recent"
        }
      ]
    ],
    "experiments": {
      "typedRoutes": true
    },
    "extra": {
      "eas": {
        "projectId": "your-project-id"
      }
    }
  }
}
```

## Configuration Guidelines

1. **Project Identity**: Set unique `name`, `slug`, `bundleIdentifier`, and `package`
2. **Permissions**: Only include permissions your prototype actually uses
3. **Assets**: Use proper asset paths and bundle patterns
4. **Plugins**: Configure essential plugins for prototype functionality
5. **Platform Support**: Enable both iOS and Android with appropriate settings
6. **Deep Linking**: Set up schemes for navigation and testing
7. **Development**: Include dev client for enhanced debugging experience

## Common Plugin Configurations

### Navigation

- `expo-router`: File-based routing
- `expo-screen-orientation`: Control screen orientation

### Development

- `expo-dev-client`: Enhanced development experience
- `expo-build-properties`: Build configuration

### Hardware Access

- `expo-camera`: Camera and microphone access
- `expo-location`: GPS and location services
- `expo-sensors`: Device motion and sensors
- `expo-local-authentication`: Biometric authentication

### Storage & Data

- `expo-secure-store`: Secure storage
- `expo-sqlite`: Local database
- `expo-document-picker`: File system access

## Key Configuration Properties

1. **name**: Display name in app stores
2. **slug**: URL-friendly identifier
3. **bundleIdentifier/package**: Unique app identifiers
4. **scheme**: Deep linking scheme
5. **orientation**: Portrait/landscape/default
6. **userInterfaceStyle**: Light/dark/automatic
7. **supportsTablet**: iPad support
8. **requireFullScreen**: iPhone X+ handling
