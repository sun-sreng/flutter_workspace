/// Extension on [Duration] to provide a human-readable string representation.
///
/// Converts a [Duration] into a formatted time string, such as `02:34` or `1:02:34`,
/// depending on whether hours are present.
///
/// Example:
/// ```dart
/// final duration = Duration(hours: 1, minutes: 2, seconds: 34);
/// print(duration.toHumanizedString()); // "1:02:34"
/// ```
///
/// This is useful for displaying durations in UI elements like timers, media players, etc.
extension HumanizedDuration on Duration {
  /// Converts the [Duration] into a human-friendly string in the format:
  /// - `HH:MM:SS` if hours are present
  /// - `MM:SS` if no hours
  ///
  /// Minutes and seconds are zero-padded if necessary.
  String toHumanizedString() {
    final seconds = '${inSeconds % 60}'.padLeft(2, '0');
    String minutes = '${inMinutes % 60}';
    if (inHours > 0 || inMinutes == 0) {
      minutes = minutes.padLeft(2, '0');
    }
    String value = '$minutes:$seconds';
    if (inHours > 0) {
      value = '$inHours:$minutes:$seconds';
    }
    return value;
  }
}
