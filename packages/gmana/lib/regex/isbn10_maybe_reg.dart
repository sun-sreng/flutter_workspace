/// RegExp instance for validating ISBN-10 format.
///
/// This regular expression validates if a string conforms to the ISBN-10 format
/// without validating the checksum.
///
/// Pattern breakdown:
/// - `^` - Asserts the start of the string
/// - `(?:...)` - Non-capturing group
///   - `[0-9]{9}X` - Matches exactly 9 digits followed by the character 'X'
///   - `|` - OR operator
///   - `[0-9]{10}` - Matches exactly 10 digits
/// - ` - Asserts the end of the string
///
/// See [isbn10MaybeRegStr] for examples and limitations.
RegExp isbn10MaybeReg = RegExp(isbn10MaybeRegStr);

/// Regular expression string pattern for validating ISBN-10 format.
///
/// This pattern validates if a string matches the basic ISBN-10 format:
/// - Exactly 10 characters
/// - Either 10 digits (0-9), or 9 digits followed by 'X'
///
/// This pattern validates only the format, not the mathematical validity
/// of the ISBN-10 (checksum verification).
///
/// The pattern does not accept hyphens or spaces commonly used in ISBN display
/// format (e.g., "0-306-40615-2").
///
/// Example:
/// ```dart
/// String testISBN1 = "0306406152";    // 10 digits
/// String testISBN2 = "123456789X";    // 9 digits + X
/// String testISBN3 = "0-306-40615-2"; // Contains hyphens (will fail)
///
/// bool isValid1 = isbn10MaybeReg.hasMatch(testISBN1); // true
/// bool isValid2 = isbn10MaybeReg.hasMatch(testISBN2); // true
/// bool isValid3 = isbn10MaybeReg.hasMatch(testISBN3); // false
/// ```
String isbn10MaybeRegStr = r'^(?:[0-9]{9}X|[0-9]{10})$';
