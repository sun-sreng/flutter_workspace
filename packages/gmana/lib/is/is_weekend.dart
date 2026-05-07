import 'package:gmana/is/parse.dart';

/// Returns true if [str] falls on a weekend (Saturday or Sunday, UTC).
bool isWeekend(String str) {
  final date = tryParseDate(str);
  if (date == null) return false;
  return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
}
