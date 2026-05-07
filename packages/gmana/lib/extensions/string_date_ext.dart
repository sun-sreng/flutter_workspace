import 'package:gmana/is/is_after.dart' as after;
import 'package:gmana/is/is_before.dart' as before;
import 'package:gmana/is/is_between.dart' as between;
import 'package:gmana/is/is_date.dart' as date;
import 'package:gmana/is/is_future.dart' as future;
import 'package:gmana/is/is_leap_year.dart' as leap_year;
import 'package:gmana/is/is_past.dart' as past;
import 'package:gmana/is/is_today.dart' as today;
import 'package:gmana/is/is_weekday.dart' as weekday;
import 'package:gmana/is/is_weekend.dart' as weekend;

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
  ///
  /// ```dart
  /// '2024-01-01'.isDate // true
  /// 'hello'.isDate      // false
  /// ```
  bool get isDate => date.isDate(this);

  /// Whether this date is after [reference].
  ///
  /// When [reference] is omitted, compares against the current date/time (now).
  ///
  /// ```dart
  /// '2099-01-01'.isAfter()             // true
  /// '2020-01-01'.isAfter('2019-12-31') // true
  /// ```
  bool isAfter([String? reference]) => after.isAfter(this, reference);

  /// Whether this date is before [reference].
  ///
  /// When [reference] is omitted, compares against the current date/time (now).
  ///
  /// ```dart
  /// '2020-01-01'.isBefore()            // true
  /// '2020-01-01'.isBefore('2021-01-01') // true
  /// ```
  bool isBefore([String? reference]) => before.isBefore(this, reference);

  /// Whether this date falls within the range [[from], [to]], inclusive.
  ///
  /// ```dart
  /// '2024-06-15'.isBetween('2024-01-01', '2024-12-31') // true
  /// '2023-12-31'.isBetween('2024-01-01', '2024-12-31') // false
  /// ```
  bool isBetween(String from, String to) => between.isBetween(this, from, to);

  /// Whether this date represents today's date.
  ///
  /// Time components are ignored; only the date portion is compared.
  ///
  /// ```dart
  /// DateTime.now().toIso8601String().isToday // true
  /// ```
  bool get isToday => today.isToday(this);

  /// Whether this date is strictly before today.
  ///
  /// ```dart
  /// '2000-01-01'.isPast // true
  /// ```
  bool get isPast => past.isPast(this);

  /// Whether this date is strictly after today.
  ///
  /// ```dart
  /// '2099-12-31'.isFuture // true
  /// ```
  bool get isFuture => future.isFuture(this);

  /// Whether this date falls on a Saturday or Sunday.
  ///
  /// ```dart
  /// '2024-03-16'.isWeekend // true  (Saturday)
  /// '2024-03-15'.isWeekend // false (Friday)
  /// ```
  bool get isWeekend => weekend.isWeekend(this);

  /// Whether this date falls on a Monday through Friday.
  ///
  /// ```dart
  /// '2024-03-15'.isWeekday // true  (Friday)
  /// '2024-03-16'.isWeekday // false (Saturday)
  /// ```
  bool get isWeekday => weekday.isWeekday(this);

  /// Whether the year of this date is a leap year.
  ///
  /// A year is a leap year if it is divisible by 4, except for century years,
  /// which must be divisible by 400.
  ///
  /// ```dart
  /// '2024-01-01'.isLeapYear // true
  /// '2023-01-01'.isLeapYear // false
  /// '2000-01-01'.isLeapYear // true
  /// '1900-01-01'.isLeapYear // false
  /// ```
  bool get isLeapYear => leap_year.isLeapYear(this);
}
