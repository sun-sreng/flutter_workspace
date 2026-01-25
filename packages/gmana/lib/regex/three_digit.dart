/// A regular expression that matches exactly 3 digits.
///
/// Commonly used for validating short numeric codes such as postal codes
/// in countries like Iceland (e.g., `101`, `750`, etc.).
///
/// Example of a valid match:
/// - `123`
///
/// Example of an invalid match:
/// - `12`
/// - `1234`
/// - `12a`
RegExp threeDigit = RegExp(threeDigitStr);

/// The pattern used to match strings that consist of exactly three digits.
///
/// Pattern breakdown:
/// - `^` and `$`: Anchors to ensure the entire string is matched.
/// - `\d{3}`: Exactly three digits from 0 to 9.
///
/// Pattern: `^\d{3}$`
String threeDigitStr = r'^\d{3}$';
