/// A [RegExp] object used to validate if a string contains only uppercase letters.
///
/// Uses the [upperCaseReg] pattern to perform the match.
RegExp upperCaseReg = RegExp(upperCaseStr);

/// A regular expression pattern that matches strings containing only uppercase letters (A–Z).
///
/// This pattern ensures the entire string is composed of one or more uppercase
/// English alphabet characters with no digits, symbols, or whitespace.
String upperCaseStr = r'^[A-Z]+$';
