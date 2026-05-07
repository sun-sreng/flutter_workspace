import 'package:gmana/is/parse.dart';

/// Returns true if [str] falls on a weekday (Mon–Fri, UTC).
bool isWeekday(String str) {
  final date = tryParseDate(str);
  if (date == null) return false;
  return date.weekday >= DateTime.monday && date.weekday <= DateTime.friday;
}
