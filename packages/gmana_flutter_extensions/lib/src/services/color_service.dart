import 'package:flutter/material.dart';

abstract final class ColorService {
  static const double defaultAmount = 0.1;

  static Color adjustLightness(Color color, {required double amount, required bool darken}) {
    _checkUnitInterval(amount, 'amount');
    final hsl = HSLColor.fromColor(color);
    final lightness = darken ? (hsl.lightness - amount).clamp(0.0, 1.0) : (hsl.lightness + amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  static Color adjustSaturation(Color color, {required double amount, required bool desaturate}) {
    _checkUnitInterval(amount, 'amount');
    final hsl = HSLColor.fromColor(color);
    final saturation =
        desaturate ? (hsl.saturation - amount).clamp(0.0, 1.0) : (hsl.saturation + amount).clamp(0.0, 1.0);

    return hsl.withSaturation(saturation).toColor();
  }

  /// Returns [count] analogous colors evenly spaced around [color].
  static List<Color> analogous(Color color, {int count = 2, double spreadDegrees = 30}) {
    if (count < 1) {
      throw ArgumentError.value(count, 'count', 'must be at least 1');
    }

    final hsl = HSLColor.fromColor(color);
    final step = spreadDegrees / count;

    return [
      for (var i = 1; i <= count; i++) ...[
        hsl.withHue((hsl.hue - step * i) % 360).toColor(),
        hsl.withHue((hsl.hue + step * i) % 360).toColor(),
      ],
    ];
  }

  /// Picks whichever candidate has the highest contrast against [background].
  static Color bestContrast(Color background, [List<Color> candidates = const [Colors.white, Colors.black]]) {
    if (candidates.isEmpty) {
      throw ArgumentError.value(candidates, 'candidates', 'must not be empty');
    }

    return candidates.reduce(
      (best, color) => contrastRatio(color, background) > contrastRatio(best, background) ? color : best,
    );
  }

  static Color complementary(Color color) {
    final hsl = HSLColor.fromColor(color);

    return hsl.withHue((hsl.hue + 180) % 360).toColor();
  }

  static double contrastRatio(Color a, Color b) {
    final luminanceA = a.computeLuminance() + 0.05;
    final luminanceB = b.computeLuminance() + 0.05;

    return luminanceA > luminanceB ? luminanceA / luminanceB : luminanceB / luminanceA;
  }

  /// Generates a [MaterialColor] swatch using HSL lightness steps.
  static MaterialColor createMaterialColor(Color color) {
    final hsl = HSLColor.fromColor(color);

    const shadeMap = {
      50: 0.95,
      100: 0.90,
      200: 0.80,
      300: 0.70,
      400: 0.60,
      500: 0.50,
      600: 0.40,
      700: 0.30,
      800: 0.20,
      900: 0.10,
    };

    final swatch = {for (final entry in shadeMap.entries) entry.key: hsl.withLightness(entry.value).toColor()};

    return MaterialColor(color.toARGB32(), swatch);
  }

  static Color greyscale(Color color) => adjustSaturation(color, amount: 1.0, desaturate: true);

  /// WCAG 2.1 relative luminance. Threshold 0.179 gives 4.5:1 contrast.
  static bool isDark(Color color) => color.computeLuminance() < 0.179;

  static bool isLight(Color color) => !isDark(color);

  static bool meetsWcagAA(Color foreground, Color background) => contrastRatio(foreground, background) >= 4.5;

  static bool meetsWcagAAA(Color foreground, Color background) => contrastRatio(foreground, background) >= 7.0;

  static Color mix(Color a, Color b, [double t = 0.5]) {
    _checkUnitInterval(t, 't');

    return Color.lerp(a, b, t)!;
  }

  /// Mixes [color] with black.
  static Color shade(Color color, [double amount = 0.5]) => mix(color, const Color(0xFF000000), amount);

  static (Color, Color) splitComplementary(Color color) {
    final hsl = HSLColor.fromColor(color);

    return (hsl.withHue((hsl.hue + 150) % 360).toColor(), hsl.withHue((hsl.hue + 210) % 360).toColor());
  }

  /// Mixes [color] with white.
  static Color tint(Color color, [double amount = 0.5]) => mix(color, const Color(0xFFFFFFFF), amount);

  /// Outputs 8-char ARGB hex including alpha, for example `#CCFF5500`.
  static String toHexARGB(Color color, {bool withHashSign = true}) {
    final hex = color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase();

    return withHashSign ? '#$hex' : hex;
  }

  /// Outputs 6-char RGB hex, ignoring alpha, for example `#FF5500`.
  static String toHexRGB(Color color, {bool withHashSign = true}) {
    final r = (color.r * 255).round().toRadixString(16).padLeft(2, '0');
    final g = (color.g * 255).round().toRadixString(16).padLeft(2, '0');
    final b = (color.b * 255).round().toRadixString(16).padLeft(2, '0');
    final hex = '$r$g$b'.toUpperCase();

    return withHashSign ? '#$hex' : hex;
  }

  static (Color, Color) triadic(Color color) {
    final hsl = HSLColor.fromColor(color);

    return (hsl.withHue((hsl.hue + 120) % 360).toColor(), hsl.withHue((hsl.hue + 240) % 360).toColor());
  }

  /// Parses `#RGB`, `#RRGGBB`, or `#AARRGGBB`, with optional hash prefix.
  static Color? tryParseHex(String hex) {
    final clean = hex.startsWith('#') ? hex.substring(1) : hex;

    return switch (clean.length) {
      3 => () {
        final r = clean[0] * 2;
        final g = clean[1] * 2;
        final b = clean[2] * 2;
        final value = int.tryParse('FF$r$g$b', radix: 16);

        return value != null ? Color(value) : null;
      }(),
      6 => () {
        final value = int.tryParse('FF$clean', radix: 16);

        return value != null ? Color(value) : null;
      }(),
      8 => () {
        final value = int.tryParse(clean, radix: 16);

        return value != null ? Color(value) : null;
      }(),
      _ => null,
    };
  }

  static void _checkUnitInterval(double value, String name) {
    if (value.isNaN || value < 0 || value > 1) {
      throw ArgumentError.value(value, name, 'must be between 0 and 1');
    }
  }
}
