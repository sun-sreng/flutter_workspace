import 'package:gmana/is/parse.dart';

/// Returns true if [str] represents a date strictly after [reference].
/// [reference] defaults to now (UTC) when null.
bool isAfter(String str, [String? reference]) {
  final date = tryParseDate(str);
  if (date == null) return false;

  final ref = reference == null ? DateTime.now().toUtc() : tryParseDate(reference);
  if (ref == null) return false;

  return date.isAfter(ref);
}
