import 'dart:ui';

import '../services/color_service.dart';

extension StringColorExtension on String {
  /// Converts a hex string like `#F50`, `#FF5500`, or `CCFF5500` to a [Color].
  Color toColor() {
    final color = ColorService.tryParseHex(this);
    if (color == null) {
      throw FormatException(
        'Expected #RGB, #RRGGBB, or #AARRGGBB color text.',
        this,
      );
    }

    return color;
  }

  /// Converts a hex string to a [Color] with the specified opacity.
  Color toColorWithOpacity(double opacity) {
    if (opacity.isNaN || opacity < 0 || opacity > 1) {
      throw ArgumentError.value(opacity, 'opacity', 'must be between 0 and 1');
    }

    return toColor().withAlpha((opacity * 255).round());
  }
}
