/// This file contains a regular expression to match ASCII characters.
/// A regular expression that matches any string containing only ASCII characters.
/// The pattern used by the asciiReg regular expression.
/// The pattern matches any string that contains only characters in the range 0-127 (inclusive).
RegExp ipv4Maybe = RegExp(ipv4MaybeStr);

/// The pattern used by the ipv4Maybe regular expression.
/// The pattern matches any string that contains a valid IPv4 address.
/// The pattern allows for optional leading and trailing digits, an optional decimal point,
/// and an optional exponent part (e.g., e+10 or E-10).
String ipv4MaybeStr = r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$';
