// color_extensions.dart
import 'package:flutter/material.dart';

import '../services/color_service.dart';

extension ColorExt on Color {
  Color get complementary => ColorService.complementary(this);

  Color get contrastText => ColorService.bestContrast(this);

  Color get greyscale => ColorService.greyscale(this);

  bool get isDark => ColorService.isDark(this);

  bool get isLight => ColorService.isLight(this);

  (Color, Color) get splitComplementary =>
      ColorService.splitComplementary(this);
  (Color, Color) get triadic => ColorService.triadic(this);
  List<Color> analogous({int count = 2, double spreadDegrees = 30}) =>
      ColorService.analogous(this, count: count, spreadDegrees: spreadDegrees);

  double contrastRatio(Color other) => ColorService.contrastRatio(this, other);

  Color darken([double amount = ColorService.defaultAmount]) =>
      ColorService.adjustLightness(this, amount: amount, darken: true);
  Color desaturate([double amount = ColorService.defaultAmount]) =>
      ColorService.adjustSaturation(this, amount: amount, desaturate: true);
  Color lighten([double amount = ColorService.defaultAmount]) =>
      ColorService.adjustLightness(this, amount: amount, darken: false);
  bool meetsWcagAA(Color background) =>
      ColorService.meetsWcagAA(this, background);

  bool meetsWcagAAA(Color background) =>
      ColorService.meetsWcagAAA(this, background);
  Color mix(Color other, [double t = 0.5]) => ColorService.mix(this, other, t);
  Color saturate([double amount = ColorService.defaultAmount]) =>
      ColorService.adjustSaturation(this, amount: amount, desaturate: false);
  Color shade([double amount = 0.5]) => ColorService.shade(this, amount);
  Color tint([double amount = 0.5]) => ColorService.tint(this, amount);

  /// 8-char ARGB: `#CCFF5500`
  String toHexARGB({bool withHashSign = true}) =>
      ColorService.toHexARGB(this, withHashSign: withHashSign);

  /// 6-char RGB: `#FF5500`
  String toHexRGB({bool withHashSign = true}) =>
      ColorService.toHexRGB(this, withHashSign: withHashSign);

  MaterialColor toMaterialColor() => ColorService.createMaterialColor(this);

  Color withAlphaOpacity(double opacity) {
    if (opacity.isNaN || opacity < 0 || opacity > 1) {
      throw ArgumentError.value(opacity, 'opacity', 'must be between 0 and 1');
    }

    return withAlpha((opacity * 255).round());
  }
}
