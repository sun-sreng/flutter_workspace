/// This file contains a regular expression to match ASCII characters.
/// A regular expression that matches any string containing only ASCII characters.
/// The pattern used by the asciiReg regular expression.
RegExp floatReg = RegExp(floatRegStr);

/// The pattern used by the floatReg regular expression.
/// The pattern matches any string that contains a valid floating-point number.
/// The pattern allows for optional leading and trailing digits, an optional decimal point,
String floatRegStr =
    r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$';
