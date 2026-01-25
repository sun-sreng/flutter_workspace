/// This file contains a regular expression to match ASCII characters.
/// A regular expression that matches any string containing only ASCII characters.
/// The pattern used by the asciiReg regular expression.
/// The pattern matches any string that contains only characters in the range 0-127 (inclusive).
RegExp fourDigit = RegExp(fourDigitStr);

/// The pattern used by the fourDigit regular expression.
/// The pattern matches any string that contains exactly 4 digits (0-9).
/// The pattern allows for optional leading and trailing digits, an optional decimal point,
String fourDigitStr = r'^\d{4}$';
