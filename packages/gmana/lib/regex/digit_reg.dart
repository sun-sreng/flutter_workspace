/// A [RegExp] object used to validate if a string consists entirely of digits.
///
/// Uses the [digitReg] pattern to perform the match.
RegExp digitReg = RegExp(digitRegStr);

/// A regular expression pattern that matches strings containing only digits.
///
/// This pattern ensures the string contains one or more digits (0-9) and
/// nothing else.
String digitRegStr = r'^[0-9]+$';
