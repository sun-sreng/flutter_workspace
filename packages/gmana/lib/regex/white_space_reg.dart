/// A [RegExp] object used to validate if a string contains only whitespace characters.
///
/// Uses the [whiteSpaceStr] pattern to check for strings that include only
/// spaces, tabs, or line breaks.
RegExp whiteSpaceReg = RegExp(whiteSpaceStr);

/// A regular expression pattern that matches strings containing only whitespace characters.
///
/// This pattern ensures the string consists entirely of one or more whitespace
/// characters such as spaces, tabs, or newlines. It will not match an empty string.
String whiteSpaceStr = r'^\s+$';
