import 'package:gmana/is/parse.dart';

/// Returns true if [str] is a leap year.
bool isLeapYear(String str) {
  final date = tryParseDate(str);
  if (date == null) return false;
  final y = date.year;
  return (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0);
}
