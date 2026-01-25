/// A regular expression that matches integer numeric strings, including negatives.
///
/// This regex matches strings that consist of an optional leading minus sign (`-`)
/// followed by one or more digits (`0-9`). It does not allow decimal points,
/// whitespace, or any other characters.
///
/// Examples of valid matches:
/// - `123`
/// - `-456`
///
/// Examples of invalid matches:
/// - `12.3`
/// - `+123`
/// - `abc`
RegExp numericReg = RegExp(numericRegStr);

/// The pattern used to match whole integer numbers (optionally negative).
///
/// Pattern breakdown:
/// - `^` and `$`: Anchors to match the entire string.
/// - `-?`: Optional minus sign for negative numbers.
/// - `[0-9]+`: One or more digits.
///
/// Pattern: `^-?[0-9]+$`
String numericRegStr = r'^-?[0-9]+$';
