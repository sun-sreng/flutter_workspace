/// Returns a UTC [DateTime] if [str] is a valid ISO 8601 date string,
/// otherwise returns null.
DateTime? tryParseDate(String str) => DateTime.tryParse(str.trim())?.toUtc();