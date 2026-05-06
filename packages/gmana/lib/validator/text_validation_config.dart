// text_validation_config.dart
final class TextValidationConfig {
  final bool allowEmpty;
  final bool allowOnlyWhitespace;
  final bool trimWhitespace;
  final int? minLength;
  final int? maxLength;

  // Pre-compiled — not raw strings
  final RegExp? pattern;

  /// Allowed character set. Null means all characters allowed.
  final Set<String>? allowedCharacterSet;

  /// Whole-word blacklist matching. Set [wholeWordBlacklist] to false
  /// for substring matching (e.g. profanity filters).
  final Set<String> blacklistedWords;
  final bool wholeWordBlacklist;

  const TextValidationConfig({
    this.allowEmpty = true,
    this.allowOnlyWhitespace = true,
    this.trimWhitespace = false,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.allowedCharacterSet,
    this.blacklistedWords = const {},
    this.wholeWordBlacklist = true,
  }) : assert(!(allowEmpty && !allowOnlyWhitespace), 'allowEmpty=true with allowOnlyWhitespace=false is contradictory');

  factory TextValidationConfig.required({
    int? minLength,
    int? maxLength,
    RegExp? pattern,
    Set<String>? allowedCharacterSet,
    Set<String> blacklistedWords = const {},
    bool wholeWordBlacklist = true,
    bool trimWhitespace = true,
  }) {
    return TextValidationConfig(
      allowEmpty: false,
      allowOnlyWhitespace: false,
      trimWhitespace: trimWhitespace,
      minLength: minLength,
      maxLength: maxLength,
      pattern: pattern,
      allowedCharacterSet: allowedCharacterSet,
      blacklistedWords: blacklistedWords,
      wholeWordBlacklist: wholeWordBlacklist,
    );
  }
}
