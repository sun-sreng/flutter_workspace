/// Extension on nullable `int` to provide utility methods for null safety.
extension IntNullableExt on int? {
  /// Returns the integer value or `0` if the value is `null`.
  ///
  /// Useful when a nullable int might be `null`, and you want a default value.
  ///
  /// Example:
  /// ```dart
  /// int? value = null;
  /// print(value.orZero()); // 0
  /// ```
  int orZero() {
    return this ?? 0;
  }
}

/// Extension on [num] to provide common numeric utilities,
/// including temperature conversions and normalization.
extension Normalize on num {
  /// Converts Celsius to Fahrenheit.
  ///
  /// Formula: `(°C × 9/5) + 32 = °F`
  ///
  /// Example:
  /// ```dart
  /// print(25.celsiusToFahrenheit()); // 77.0
  /// ```
  double celsiusToFahrenheit() {
    return this * 9 / 5 + 32;
  }

  /// Converts Fahrenheit to Celsius.
  ///
  /// Formula: `(°F − 32) × 5/9 = °C`
  ///
  /// Example:
  /// ```dart
  /// print(77.fahrenheitToCelsius()); // 25.0
  /// ```
  double fahrenheitToCelsius() {
    return (this - 32) * 5 / 9;
  }

  /// Normalizes this number from its own range to a target range.
  ///
  /// For example, normalizing 260 from range 0–300 to 0.0–1.0 will return:
  /// `0.8666666666666667`
  ///
  /// Formula:
  /// ```
  /// normalized = (toMax - toMin) *
  ///              ((value - fromMin) / (fromMax - fromMin)) +
  ///              toMin
  /// ```
  ///
  /// Example:
  /// ```dart
  /// print(260.normalized(0.0, 300)); // 0.866...
  /// ```
  num normalized(
    num selfRangeMin,
    num selfRangeMax, [
    num normalizedRangeMin = 0.0,
    num normalizedRangeMax = 1.0,
  ]) {
    return (normalizedRangeMax - normalizedRangeMin) *
            ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) +
        normalizedRangeMin;
  }
}
