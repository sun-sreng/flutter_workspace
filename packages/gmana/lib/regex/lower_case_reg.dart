/// A [RegExp] object used to validate if a string contains only lowercase letters.
///
/// Uses the [lowerCaseReg] pattern to perform the match.
RegExp lowerCaseReg = RegExp(lowerCaseRegStr);

/// A regular expression pattern that matches strings containing only lowercase letters (a–z).
///
/// This pattern ensures that the entire string consists of one or more lowercase
/// English alphabet characters with no uppercase letters, digits, symbols, or whitespace.
String lowerCaseRegStr = r'^[a-z]+$';
