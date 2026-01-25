import 'dart:ui';

/// Extensions on [String] for color conversions
extension StringColorExtension on String {
  /// Converts a hex string (like '#FF5500' or 'FF5500') to a [Color].
  Color toColor() {
    String hexColor = this;
    // Handle strings with or without '#' prefix
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    // Handle different hex formats
    if (hexColor.length == 6) {
      // Add alpha channel if not present
      hexColor = 'FF$hexColor';
    } else if (hexColor.length == 3) {
      // Handle short-hand format like #F50
      final r = hexColor[0];
      final g = hexColor[1];
      final b = hexColor[2];
      hexColor = 'FF$r$r$g$g$b$b';
    }

    return Color(int.parse(hexColor, radix: 16));
  }

  /// Converts a hex string to a [Color] with the specified opacity.]
  Color toColorWithOpacity(double opacity) {
    return toColor().withAlpha((opacity * 255).round());
  }
}
