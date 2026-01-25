/// Checks if the given [str] contains the substring [seed].
///
/// Both parameters are treated as strings, and [seed] is converted
/// to a string just in case it’s not one already.
///
/// Example:
/// ```dart
/// contains("Hello world", "world"); // true
/// contains("Hello world", "World"); // false (case-sensitive)
/// ```
bool contains(String str, String seed) {
  return str.contains(seed.toString());
}

/// Checks if the given [str] contains the substring [seed], ignoring case.
///
/// Both [str] and [seed] are converted to lowercase before performing
/// the check, making this a case-insensitive operation.
///
/// Example:
/// ```dart
/// containsIgnoreCase("Hello world", "world"); // true
/// containsIgnoreCase("Hello world", "WORLD"); // true
/// containsIgnoreCase("Hello world", "Planet"); // false
/// ```

bool containsIgnoreCase(String str, String seed) {
  return str.toLowerCase().contains(seed.toLowerCase());
}
