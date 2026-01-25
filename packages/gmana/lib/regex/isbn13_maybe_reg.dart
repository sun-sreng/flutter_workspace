/// A regular expression that matches exactly 13 digits.
///
/// Used to validate ISBN-13 codes, which must consist of exactly
/// 13 numeric digits (0–9), with no separators or spaces.
///
/// Example of a valid ISBN-13: `9783161484100`
RegExp isbn13MaybeReg = RegExp(isbn13MaybeRegStr);

/// The pattern used to match exactly 13 numeric digits.
///
/// This pattern ensures that the string is composed strictly of
/// 13 digits from start (^) to end ($), using a non-capturing group.
///
/// Pattern: `^(?:[0-9]{13})$`
String isbn13MaybeRegStr = r'^(?:[0-9]{13})$';
