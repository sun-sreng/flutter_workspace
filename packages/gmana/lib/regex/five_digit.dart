/// This file contains a regular expression to match ASCII characters.
/// A regular expression that matches any string containing only ASCII characters.
/// The pattern used by the asciiReg regular expression.
RegExp fiveDigit = RegExp(fiveDigitStr);

/// The pattern used by the fiveDigit regular expression.
/// The pattern matches any string that contains exactly 5 digits (0-9).
String fiveDigitStr = r'^\d{5}$';
