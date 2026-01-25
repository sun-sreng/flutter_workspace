import 'package:flutter/material.dart';

/// A class that defines the application's color palette.
/// All colors should be defined here for consistency across the app.
abstract class GColors {
  // Primary brand color
  static const Color gmana = Color(0xFFF57224);

  // Material color swatch based on the primary color
  static const MaterialColor gmanaMaterial = MaterialColor(
    0xFFF57224,
    <int, Color>{
      50: Color(0xFFFFF6ED),
      100: Color(0xFFFEECD6),
      200: Color(0xFFFCD4AC),
      300: Color(0xFFFAB577),
      400: Color(0xFFF78B40),
      500: Color(0xFFF57224), // Primary color
      600: Color(0xFFE65110),
      700: Color(0xFFBE3C10),
      800: Color(0xFF973015),
      900: Color(0xFF7A2A14),
    },
  );

  // Common UI colors
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF8F8F8);
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // Other common UI colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFE0E0E0);
  static const Color overlay = Color(0x80000000);

  // Theme data helper
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: gmanaMaterial,
      primaryColor: gmana,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.light(
        primary: gmana,
        secondary: gmanaMaterial.shade700,
        error: error,
        surface: surface,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textPrimary),
        bodyMedium: TextStyle(color: textPrimary),
        bodySmall: TextStyle(color: textSecondary),
      ),
      dividerColor: divider,
      disabledColor: disabled,
    );
  }

  static Color fromHex(String hexColor) {
    return Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
  }

  static String toHex(Color color) {
    return '#${color.toARGB32().toRadixString(16).substring(2)}';
  }

  // Convenience methods
  static Color withOpacity(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  static Color withOpacityHex(String hexColor, double opacity) {
    final int colorValue = int.parse(hexColor.replaceFirst('#', '0xFF'));
    return Color(colorValue).withAlpha((opacity * 255).round());
  }
}
