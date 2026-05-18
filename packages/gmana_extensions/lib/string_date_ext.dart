import 'package:gmana_predicates/predicates/date_predicates.dart' as dates;

/// Date validation and comparison utilities for date strings.
///
/// Assumes ISO 8601 format (`yyyy-MM-dd` or `yyyy-MM-ddTHH:mm:ss`) unless
/// otherwise noted. Behavior with non-date strings is undefined — guard with
/// [isDate] first when input is untrusted.
///
/// ```dart
/// final raw = '2024-03-15';
/// if (raw.isDate && raw.isFuture) {
///   scheduleReminder(raw);
/// }
/// ```
extension StringDateExtension on String {
  /// Whether this string is a recognizable date value.
  ///
  /// Returns `true` for valid ISO 8601 date strings. Use this as a guard
  /// before calling other date utilities on untrusted input.
  bool get isDate => dates.isDate(this);

  /// Whether this date is after [reference].
  ///
  /// When [reference] is omitted, compares against the current date/time (now).
  bool isAfter([String? reference]) => dates.isAfter(this, reference);

  /// Whether this date is before [reference].
  ///
  /// When [reference] is omitted, compares against the current date/time (now).
  bool isBefore([String? reference]) => dates.isBefore(this, reference);

  /// Whether this date falls within the range [[from], [to]] exclusively.
  bool isBetween(String from, String to) => dates.isBetween(this, from, to);

  /// Whether this date represents today's date (UTC).
  bool get isToday => dates.isToday(this);

  /// Whether this date is strictly before today.
  bool get isPast => dates.isPast(this);

  /// Whether this date is strictly after today.
  bool get isFuture => dates.isFuture(this);

  /// Whether this date falls on a Saturday or Sunday.
  bool get isWeekend => dates.isWeekend(this);

  /// Whether this date falls on a Monday through Friday.
  bool get isWeekday => dates.isWeekday(this);

  /// Whether the year of this date is a leap year.
  bool get isLeapYear => dates.isLeapYear(this);
}
