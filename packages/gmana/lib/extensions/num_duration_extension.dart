/// {@template num_duration_extension}
/// Extension on `num` (e.g. `int` and `double`) to easily create [Duration] instances.
///
/// Examples:
/// ```dart
/// 200.ms       // Duration(milliseconds: 200)
/// 3.seconds    // Duration(seconds: 3)
/// 1.5.days     // Duration(hours: 36)
/// ```
///
/// Internally, durations are created in microseconds and rounded to the nearest integer.
/// {@endtemplate}
extension NumDurationExtension on num {
  /// Returns a [Duration] representing [this] number of days.
  Duration get days => (this * 1000 * 1000 * 60 * 60 * 24).microseconds;

  /// Returns a [Duration] representing [this] number of hours.
  Duration get hours => (this * 1000 * 1000 * 60 * 60).microseconds;

  /// Returns a [Duration] representing [this] number of microseconds.
  ///
  /// The value is rounded to the nearest integer.
  Duration get microseconds => Duration(microseconds: round());

  /// Returns a [Duration] representing [this] number of milliseconds.
  Duration get milliseconds => (this * 1000).microseconds;

  /// Returns a [Duration] representing [this] number of minutes.
  Duration get minutes => (this * 1000 * 1000 * 60).microseconds;

  /// Returns a [Duration] representing [this] number of milliseconds.
  ///
  /// Alias for [milliseconds].
  Duration get ms => (this * 1000).microseconds;

  /// Returns a [Duration] representing [this] number of seconds.
  Duration get seconds => (this * 1000 * 1000).microseconds;
}
