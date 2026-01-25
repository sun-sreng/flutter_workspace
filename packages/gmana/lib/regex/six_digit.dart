/// A regular expression that matches exactly 6 digits.
///
/// Useful for validating postal codes in countries like India, Russia, and Romania
/// where 6-digit numeric codes are used.
///
/// Example of a valid match:
/// - `560001`
RegExp sixDigit = RegExp(sixDigitStr);

/// The pattern used to match strings that contain exactly six digits.
///
/// Pattern breakdown:
/// - `^` and `$`: Anchors to match the entire string.
/// - `\d{6}`: Matches exactly six digits (0–9).
///
/// Pattern: `^\d{6}$`
String sixDigitStr = r'^\d{6}$';
