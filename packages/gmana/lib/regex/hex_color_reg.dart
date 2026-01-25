/// This file contains a regular expression to match ASCII characters.
/// A regular expression that matches any string containing only ASCII characters.
/// The pattern used by the asciiReg regular expression.
/// The pattern matches any string that contains only characters in the range 0-127 (inclusive).
RegExp hexColorReg = RegExp(hexColorRegStr);

/// - The pattern used by the hexColorReg regular expression.
/// - The pattern matches any string that contains a valid hexadecimal color code.
/// - The pattern allows for an optional leading '#' character, followed by either 3 or 6 hexadecimal digits (0-9, a-f, A-F).
String hexColorRegStr = r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$';
