/// A map of UUID versions (as strings) to their corresponding regular expressions.
///
/// This is used to validate UUID (Universally Unique Identifier) strings
/// according to their version-v3, v4, v5-or a general catch-all pattern.
///
/// All patterns match uppercase hexadecimal UUIDs. If needed, convert input to uppercase
/// before applying the regex, or make the regex case-insensitive.
///
/// Supported versions:
/// - `3`: UUID version 3 (name-based, MD5)
/// - `4`: UUID version 4 (random)
/// - `5`: UUID version 5 (name-based, SHA-1)
/// - `all`: General UUID structure without version constraints
Map<String, RegExp> uuidReg = {
  /// UUID version 3:
  /// - 8-4-4-4-12 hex digits
  /// - Version digit is `3` (third group)
  '3': RegExp(
    r'^[0-9A-F]{8}-[0-9A-F]{4}-3[0-9A-F]{3}-[0-9A-F]{4}-[0-9A-F]{12}$',
  ),

  /// UUID version 4:
  /// - Version digit is `4`
  /// - Variant digit is one of `8`, `9`, `A`, or `B` (first character of fourth group)
  '4': RegExp(
    r'^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$',
  ),

  /// UUID version 5:
  /// - Version digit is `5`
  /// - Variant digit is one of `8`, `9`, `A`, or `B`
  '5': RegExp(
    r'^[0-9A-F]{8}-[0-9A-F]{4}-5[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$',
  ),

  /// General UUID pattern without version or variant validation
  /// - Useful when any UUID format is acceptable
  'all': RegExp(
    r'^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$',
  ),
};
