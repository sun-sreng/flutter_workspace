/// Utility extension on nullable integer values.
extension IntNullableExt on int? {
  /// Returns the value or `0` if `null`.
  int get orZero => this ?? 0;

  /// Returns the value or [fallback] if `null`.
  int orDefault(int fallback) => this ?? fallback;
}

/// Utility extension on [num] providing temperature conversion and normalization functions.
extension NumExt on num {
  // ---------------------------------------------------------------------------
  // Temperature
  // ---------------------------------------------------------------------------

  /// Converts Celsius → Fahrenheit. `(°C × 9/5) + 32`
  double get celsiusToFahrenheit => this * 9 / 5 + 32;

  /// Converts Fahrenheit → Celsius. `(°F − 32) × 5/9`
  double get fahrenheitToCelsius => (this - 32) * 5 / 9;

  // ---------------------------------------------------------------------------
  // Normalization
  // ---------------------------------------------------------------------------

  /// Maps this value from `[fromMin, fromMax]` into `[toMin, toMax]`.
  ///
  /// Throws [ArgumentError] if source range is zero (would produce NaN).
  ///
  /// ```dart
  /// 260.normalized(0, 300);              // 0.8667 (maps to 0.0–1.0)
  /// 260.normalized(0, 300, 0, 100);      // 86.67  (maps to 0–100)
  /// ```
  double normalized(num fromMin, num fromMax, [num toMin = 0.0, num toMax = 1.0]) {
    final range = fromMax - fromMin;
    if (range == 0) {
      throw ArgumentError('Source range cannot be zero (fromMin == fromMax == $fromMin)');
    }
    return ((toMax - toMin) * ((this - fromMin) / range) + toMin).toDouble();
  }

  /// Same as [normalized] but clamps the result to `[toMin, toMax]`.
  ///
  /// Use when [this] may fall outside the source range and you want
  /// to avoid overshooting the target range.
  ///
  /// ```dart
  /// 350.normalizedClamped(0, 300);  // 1.0  (clamped, not 1.1667)
  /// (-50).normalizedClamped(0, 300); // 0.0 (clamped, not -0.1667)
  /// ```
  double normalizedClamped(num fromMin, num fromMax, [num toMin = 0.0, num toMax = 1.0]) {
    return normalized(fromMin, fromMax, toMin, toMax).clamp(toMin.toDouble(), toMax.toDouble());
  }
}
