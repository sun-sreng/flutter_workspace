/// This file contains a regular expression to match ASCII characters.
/// A regular expression that matches any string containing only ASCII characters.
/// The pattern used by the asciiReg regular expression.
RegExp intReg = RegExp(intRegStr);

/// The pattern used by the intReg regular expression.
/// The pattern matches any string that contains a valid integer.
/// The pattern allows for optional leading and trailing digits, an optional decimal point,
/// and an optional exponent part (e.g., e+10 or E-10).
/// The pattern matches any string that contains only digits (0-9).
String intRegStr = r'^(?:-?(?:0|[1-9][0-9]*))$';
