/// A regular expression that matches UTF-16 surrogate pairs.
///
/// This is used to detect characters represented by surrogate pairs in UTF-16,
/// which includes many emoji, rare Chinese characters, and other supplementary Unicode characters
/// (i.e., characters with code points above U+FFFF).
///
/// Surrogate pairs are made up of:
/// - A high surrogate: `\uD800`–`\uDBFF`
/// - A low surrogate:  `\uDC00`–`\uDFFF`
///
/// Example matches:
/// - Emoji: 😀 (U+1F600)
/// - Rare characters: 𠀋 (U+2000B)
RegExp surrogatePairsReg = RegExp(surrogatePairsRegStr);

/// The pattern used to match UTF-16 surrogate pairs.
///
/// Pattern: `[\uD800-\uDBFF][\uDC00-\uDFFF]`
/// - Matches a high surrogate followed immediately by a low surrogate.
/// - Useful when parsing or filtering text containing emoji or other supplementary Unicode symbols.
String surrogatePairsRegStr = r'[\uD800-\uDBFF][\uDC00-\uDFFF]';
