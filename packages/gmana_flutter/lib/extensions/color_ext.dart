import 'package:flutter/material.dart';

import '../services/color_service.dart';

/// Extension on [Color] for convenient color manipulation utilities.
extension ColorExt on Color {
  /// Gets a contrasting text color (white for dark colors, black for light colors).
  Color get contrastText => ColorService().getContrastText(this);

  /// Returns true if the color is dark (luminance < 0.5).
  bool get isDark => ColorService().isDark(this);

  /// Returns true if the color is light (luminance >= 0.5).
  bool get isLight => ColorService().isLight(this);

  /// Darkens the color by [amount] (default: 0.1).
  Color darken([double amount = ColorService.defaultAmount]) {
    return ColorService().adjustLightness(
      color: this,
      amount: amount,
      darken: true,
    );
  }

  /// Lightens the color by [amount] (default: 0.1).
  Color lighten([double amount = ColorService.defaultAmount]) {
    return ColorService().adjustLightness(
      color: this,
      amount: amount,
      darken: false,
    );
  }

  /// Converts the color to a hex string (e.g., '#FF5500').
  ///
  /// [withHashSign]: If true, includes '#' prefix (default: true).
  String toHex({bool withHashSign = true}) {
    return ColorService().toHex(this, withHashSign: withHashSign);
  }

  /// Creates a version of the color with the specified opacity.
  ///
  /// [opacity]: The opacity value (between 0.0 and 1.0).
  Color withAlphaOpacity(double opacity) {
    return ColorService().withAlphaOpacity(this, opacity);
  }
}
