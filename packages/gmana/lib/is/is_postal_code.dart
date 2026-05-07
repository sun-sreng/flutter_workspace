import '../regex/postal_code_patterns.dart';

/// Checks if the given [text] matches the postal code pattern for the specified [locale].
///
/// Looks up the postal code regex pattern for the provided [locale] from
/// `postalCodePatterns`. If a pattern exists, returns whether [text]
/// matches the pattern. If no pattern is found:
/// - If [orElse] callback is provided, calls and returns its result.
/// - Otherwise, throws a [FormatException].
///
/// Parameters:
/// - [text]: The postal code string to validate. Must not be null when a pattern exists.
/// - [locale]: The locale identifier to select the postal code regex pattern.
/// - [orElse]: Optional fallback function invoked if no pattern exists for [locale].
///
/// Returns:
/// - `true` if [text] matches the locale's postal code pattern.
/// - `false` or other value from [orElse] if provided.
///
/// Throws:
/// - [FormatException] if no pattern exists for [locale] and no [orElse] is provided.
///
/// Example:
/// ```dart
/// isPostalCode('12345', 'US'); // true or false based on US postal code pattern
/// isPostalCode('ABCDE', 'XX', orElse: () => false); // false because 'XX' pattern doesn't exist
/// ```
bool isPostalCode(String? text, String locale, {bool Function()? orElse}) {
  final pattern = postalCodePatterns[locale];
  return pattern != null
      ? pattern.hasMatch(text!)
      : orElse != null
      ? orElse()
      : throw FormatException('No postal code pattern for locale: $locale');
}
