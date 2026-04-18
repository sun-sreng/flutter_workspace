# gmana_flutter

<p align="center">
  A comprehensive Flutter utility package designed to accelerate UI development and enforce consistency across applications. 
</p>

---

> **Note:** This package is built specifically for **Flutter**. For pure Dart functional programming utilities, validation logic, and extensions, please see the core [gmana](https://pub.dev/packages/gmana) package.

## 🚀 Installation

Add `gmana_flutter` to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  gmana_flutter: ^0.0.6 # Please check pub.dev for the latest version
```

Or install it via CLI:

```bash
flutter pub add gmana_flutter
```

---

## 🎨 Features Overview

`gmana_flutter` provides a rich set of curated UI components, customized form helpers, theme management logic, and UI-aware extensions to speed up development.

- [**Custom Widgets**](#custom-widgets) (`SizedBoxHeight`, `StarRatingBar`, `GAppBar`)
- [**Form Fields & Buttons**](#form-controls) (`EmailField`, `PasswordField`, `ElevatedButton`)
- [**Loading Spinners**](#loading-spinners) (`SpinnerCircular`, `SpinnerDot`, `SpinnerWaveDot`)
- [**Theme & Color Services**](#services--extensions) (`ThemeModeService`, `ColorService`)
- [**Flutter Extensions**](#services--extensions) (`ColorExt`, `ThemeModeExt`)

---

## 🧩 Custom Widgets

Standardized UI components built for reusability.

```dart
import 'package:gmana_flutter/gmana_flutter.dart';

// GAppBar avoids boilerplate and centers titles beautifully
Scaffold(
  appBar: GAppBar(
    title: 'Profile',
    centerTitle: true,
  ),
  body: Column(
    children: [
      // Standardize your vertical spacing (uses design system tokens)
      const SizedBoxHeight(spacing: 24.0), 
      
      // Feature-rich star rating bars
      StarRatingBar(
        ratingValue: 4.5,
        starSize: 20.0,
        enableHalfStar: true,
      ),
    ],
  )
)
```

---

## 📝 Form Controls

Ready-to-use form fields that wrap robust validation out of the box (when paired with `gmana`'s text validators).

```dart
Column(
  children: [
    EmailField(
      onChanged: (val) => print(val),
      decoration: InputDecoration(labelText: 'Email Address'),
    ),
    SizedBoxHeight(),
    PasswordField(
      onChanged: (val) => print(val),
      decoration: InputDecoration(labelText: 'Password'),
    ),
    SizedBoxHeight(),
    GElevatedButton(
      onPressed: () => submitForm(),
      child: Text('Submit'),
    ),
  ],
)
```

---

## ⏳ Loading Spinners

Ditch raw Material loaders for stylized, branded loading indicators.
```dart
// Easily throw in pre-built spinners across your app
const SpinnerCircular();
const SpinnerDot();
const SpinnerLinear();
const SpinnerWaveDot();
```

---

## 🛠 Services & Extensions

### Colors & Contrast Engine
Ensure your text is always readable over dynamic background colors!

```dart
final primaryColor = Color(0xFF0055FF);

print(primaryColor.isDark); // true
print(primaryColor.toHex()); // "#0055FF"

// Automatically returns white/black depending on what's safe
final safeTextColor = primaryColor.contrastText; 

// Easily lighten/darken UI elements
final hoverColor = primaryColor.lighten(0.1);
final activeColor = primaryColor.darken(0.2);
```

### Theme Mode Management
Provides strongly typed `ThemeMode` parsers and human-readable tags for your Settings pages.

```dart
// Convert ThemeModes to Icons or Strings easily
ThemeMode.dark.toIcon(); // Icons.dark_mode
ThemeMode.dark.toLabel(); // "Dark Mode"

// Convert from strings (useful when reading from SharedPreferences/SecureStorage)
'light'.toThemeMode(); // ThemeMode.light
'system'.toThemeIcon(); // Icons.brightness_6
```

---

## 🎯 Putting it all together

```dart
import 'package:flutter/material.dart';
import 'package:gmana_flutter/gmana_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gmana_flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: 'system'.toThemeMode(), // Handled elegantly by gmana_flutter
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GAppBar(title: 'Welcome'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinnerWaveDot(),
            const SizedBoxHeight(),
            Text('Processing Theme Settings...', 
              style: TextStyle(
                // Auto-contrast!
                color: Theme.of(context).primaryColor.contrastText 
              )
            ),
          ],
        ),
      ),
    );
  }
}
```
