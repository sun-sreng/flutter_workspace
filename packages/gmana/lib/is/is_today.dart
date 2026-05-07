import 'package:gmana/is/parse.dart';

/// Returns true if [str] is today's date (UTC).
bool isToday(String str) {
  final date = tryParseDate(str);
  if (date == null) return false;
  final now = DateTime.now().toUtc();
  return date.year == now.year && date.month == now.month && date.day == now.day;
}
