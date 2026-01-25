/// This file contains a regular expression to match ASCII characters.
/// A regular expression that matches any string containing only ASCII characters.
/// The pattern used by the asciiReg regular expression.
RegExp fullWidthReg = RegExp(fullWidthRegStr);

/// The pattern used by the fullWidthReg regular expression.
/// The pattern matches any string that contains only full-width characters.
/// The pattern allows for optional leading and trailing digits, an optional decimal point,
String fullWidthRegStr =
    r'[^\u0020-\u007E\uFF61-\uFF9F\uFFA0-\uFFDC\uFFE8-\uFFEE0-9a-zA-Z]';
