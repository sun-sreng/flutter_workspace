/// This file contains a regular expression to match ASCII characters.
/// A regular expression that matches any string containing only ASCII characters.
/// The pattern used by the asciiReg regular expression.
/// The pattern matches any string that contains only characters in the range 0-127 (inclusive).
RegExp hexadecimalReg = RegExp(hexadecimalRegStr);

/// The pattern used by the hexadecimalReg regular expression.
/// The pattern matches any string that contains only hexadecimal digits (0-9, a-f, A-F).
/// The pattern allows for an optional leading and trailing digits, an optional decimal point,
/// and an optional exponent part (e.g., e+10 or E-10).
String hexadecimalRegStr = r'^[0-9a-fA-F]+$';
