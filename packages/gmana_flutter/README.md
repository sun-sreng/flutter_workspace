# gmana_flutter

`gmana_flutter` is a comprehensive Flutter utility package designed to accelerate UI development and enforce consistency across applications. It provides a rich set of curated widgets, customized form fields, theme management services, and extensions.

> **Note:** This package is built specifically for Flutter. For pure Dart functional programming utilities, validation logic, and extensions, please refer to the core `gmana` package.

## Features

- **Widgets**
  - Custom implementations including `GAppBar`, `SizedBoxHeight`, and `StarRatingBar`.
  - Reusable loaders and spinners for visual feedback.
- **Form Controls**
  - Ready-to-use custom form fields and form helpers.
- **Services**
  - `ThemeModeService`: Easy persistence and management of application theme states.
  - `ColorService`: Dynamic color manipulation and utilities.
- **Extensions**
  - Flutter-specific extensions natively integrated such as `color_ext.dart` for Color manipulations and `theme_mode_ext.dart`.

## Installation

Add `gmana_flutter` to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  gmana_flutter: ^0.0.5 # Please check pub.dev for the latest version
```

Or install it via CLI:

```bash
flutter pub add gmana_flutter
```

## Usage Examples

```dart
import 'package:flutter/material.dart';
import 'package:gmana_flutter/gmana_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme setup using gmana_flutter extensions & services
    return MaterialApp(
      title: 'gmana_flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GAppBar(
        title: 'Welcome',
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Using custom height box for spacing
            const SizedBoxHeight(spacing: 24.0),
            
            // Using star rating bar
            const StarRatingBar(
              ratingValue: 4.5,
              starSize: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
```
