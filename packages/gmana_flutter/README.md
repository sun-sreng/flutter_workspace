# gmana_flutter

A Flutter UI utility package with form fields, loading indicators, theme helpers,
color utilities, responsive extensions, and small design-system tokens.

Use `gmana_flutter` when you want app-level Flutter conveniences on top of the
core [`gmana`](https://pub.dev/packages/gmana) validation and utility package.

## Installation

```bash
flutter pub add gmana_flutter
```

Or add it manually:

```yaml
dependencies:
  gmana_flutter: ^0.0.8
```

## Import

Most public APIs are available from the main entrypoint:

```dart
import 'package:flutter/material.dart';
import 'package:gmana_flutter/gmana_flutter.dart';
```

For validator configuration types such as `PasswordValidationConfig` and
`NumberValidationConfig`, import the core validation entrypoint too:

```dart
import 'package:gmana/validation.dart';
```

## What's Included

- `GAppBar`, `GListTile`, `SizedBoxHeight`, and `StarRatingBar`
- `GEmailField`, `GPasswordField`, `GNumberField`, `GTextField`, and `GConfirmPasswordField`
- `GElevatedButton` with a built-in loading state
- `GCircularSpinner`, `GLinearSpinner`, `GSpinnerDot`, `GWaveSpinner`, and `GSpinnerWaveDot`
- `GColors` and `GFontWeight` design-system tokens
- `ColorExt`, `StringColorExtension`, `ThemeModeExt`, `ContextExt`, responsive breakpoints, and icon serialization helpers
- `ThemeModeService`, `ColorService`, locale conversion helpers, and error handler registration

## App Theme

```dart
MaterialApp(
  title: 'gmana_flutter Demo',
  theme: GColors.lightTheme,
  darkTheme: GColors.darkTheme,
  themeMode: 'system'.toThemeMode(),
  home: const DemoHome(),
);
```

## Form Controls

```dart
import 'package:flutter/material.dart';
import 'package:gmana/validation.dart';
import 'package:gmana_flutter/gmana_flutter.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    this.isSubmitting = false,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GEmailField(
          controller: emailController,
          labelText: 'Email Address',
        ),
        const SizedBoxHeight(),
        GPasswordField(
          controller: passwordController,
          validationConfig: PasswordValidationConfig.strong(),
        ),
        const SizedBoxHeight(),
        GElevatedButton(
          isLoading: isSubmitting,
          onPressed: onSubmit,
          text: 'Sign in',
        ),
      ],
    );
  }
}
```

## Loading Indicators

```dart
const GCircularSpinner();
const GLinearSpinner();
const GSpinnerDot(color: Colors.blue);
const GSpinnerWaveDot(size: 24, color: Colors.blue);
const SizedBox(
  width: 48,
  height: 48,
  child: GWaveSpinner(color: Colors.green),
);
```

## Color Utilities

```dart
const primaryColor = Color(0xFF0055FF);

final hex = primaryColor.toHexRGB(); // '#0055FF'
final withAlpha = primaryColor.toHexARGB(); // '#FF0055FF'
final safeTextColor = primaryColor.contrastText;
final hoverColor = primaryColor.lighten(0.1);
final pressedColor = primaryColor.darken(0.2);

final parsed = ColorService.tryParseHex('#0055FF');
final shorthand = '#F50'.toColor();
```

## Theme Mode Helpers

```dart
final mode = 'dark'.toThemeMode(); // ThemeMode.dark
final icon = ThemeMode.dark.toIcon(); // Icons.dark_mode
final label = ThemeMode.dark.toLabel(); // 'Dark Mode'
```

## Responsive Helpers

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final columns = constraints.resolve(
      mobile: 1,
      tablet: 2,
      desktop: 3,
      widescreen: 4,
    );

    return GridView.count(
      crossAxisCount: columns,
      children: const [],
    );
  },
);
```

You can also resolve values from a `BuildContext`:

```dart
final horizontalPadding = context.responsive(
  mobile: 16.0,
  tablet: 24.0,
  desktop: 32.0,
);
```

## Icon Serialization

```dart
final json = Icons.home.toJsonString();
final icon = IconDataExt.tryParse(json) ?? Icons.broken_image;
```

## Locale Helpers

```dart
final tag = fromLocale(const Locale('en', 'US')); // 'en_US'
final locale = toLocale('km_KH'); // Locale('km', 'KH')
```

## Complete Mini Example

```dart
import 'package:flutter/material.dart';
import 'package:gmana_flutter/gmana_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GColors.lightTheme,
      darkTheme: GColors.darkTheme,
      themeMode: 'system'.toThemeMode(),
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GAppBar(title: 'gmana_flutter'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const GSpinnerWaveDot(size: 28, color: GColors.primary),
            const SizedBoxHeight(),
            Text(
              ThemeMode.dark.toLabel(),
              style: TextStyle(color: GColors.primary.contrastText),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Related Packages

For pure Dart extensions, functional helpers, and validator logic, use
[`gmana`](https://pub.dev/packages/gmana). For domain-style value objects, use
`gmana_value_objects` when it is available on pub.dev.
