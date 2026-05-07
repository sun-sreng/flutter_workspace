import 'package:gmana/is/parse.dart';

/// Returns true if [str] is a parseable ISO 8601 date string.
bool isDate(String str) => tryParseDate(str) != null;
