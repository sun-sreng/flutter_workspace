/// A regular expression that matches any non-ASCII (multi byte) character.
///
/// This is useful for detecting characters outside the standard ASCII range,
/// such as characters from non-Latin scripts (e.g., Khmer, Chinese, Arabic),
/// emoji, and other symbols.
///
/// Matches any character **not** in the ASCII range (0x00 to 0x7F).
RegExp multiByteReg = RegExp(multiByteRegStr);

/// The pattern used to match non-ASCII characters.
///
/// `[^\x00-\x7F]` matches any character that is **not** between
/// hex 00 and 7F (i.e., standard ASCII characters).
///
/// Pattern: `[^\x00-\x7F]`
String multiByteRegStr = r'[^\x00-\x7F]';
