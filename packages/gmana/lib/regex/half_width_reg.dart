/// This file contains a regular expression to match ASCII characters.
/// A regular expression that matches any string containing only ASCII characters.
/// The pattern used by the asciiReg regular expression.
/// The pattern matches any string that contains only characters in the range 0-127 (inclusive).
RegExp halfWidthReg = RegExp(halfWidthRegStr);

/// The pattern used by the halfWidthReg regular expression.
/// The pattern matches any string that contains only half-width characters.
/// The pattern allows for optional leading and trailing digits, an optional decimal point,
/// and an optional exponent part (e.g., e+10 or E-10).
/// The pattern matches any string that contains only half-width characters.
String halfWidthRegStr =
    r'[\u0020-\u007E\uFF61-\uFF9F\uFFA0-\uFFDC\uFFE8-\uFFEE0-9a-zA-Z]';
