import 'package:gmana/is/parse.dart';

/// Returns true if [str] represents a date between [from] and [to] (exclusive).
bool isBetween(String str, String from, String to) {
  final date = tryParseDate(str);
  final f = tryParseDate(from);
  final t = tryParseDate(to);
  if (date == null || f == null || t == null) return false;
  return date.isAfter(f) && date.isBefore(t);
}
