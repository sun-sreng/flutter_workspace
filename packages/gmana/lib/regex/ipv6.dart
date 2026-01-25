/// This file contains a regular expression to match ASCII characters.
/// A regular expression that matches any string containing only ASCII characters.
/// The pattern used by the asciiReg regular expression.
/// The pattern matches any string that contains only characters in the range 0-127 (inclusive).
RegExp ipv6 = RegExp(ipv6Str);

/// The pattern used by the ipv6 regular expression.
/// The pattern matches any string that contains a valid IPv6 address.
/// The pattern allows for optional leading and trailing digits, an optional decimal point,
/// and an optional exponent part (e.g., e+10 or E-10).
/// The pattern matches any string that contains only hexadecimal digits (0-9, a-f, A-F).
String ipv6Str = r'^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$';
