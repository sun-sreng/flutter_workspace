/// This file contains a regular expression to match ASCII characters.
/// A regular expression that matches any string containing only ASCII characters.
/// The pattern used by the asciiReg regular expression.
RegExp asciiReg = RegExp(asciiRegStr);

/// The pattern used by the asciiReg regular expression.
/// The pattern matches any string that contains only ASCII characters (0-127).
String asciiRegStr = r'^[\x00-\x7F]+$';
