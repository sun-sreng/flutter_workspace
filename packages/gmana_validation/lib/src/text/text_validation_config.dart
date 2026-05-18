/// Configuration for text validation.
final class TextValidationConfig {
  /// Creates text validation rules.
  const TextValidationConfig({
    this.allowEmpty = true,
    this.allowOnlyWhitespace = true,
    this.trimWhitespace = false,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.allowedCharacters,
    this.blacklistedWords = const {},
    this.wholeWordBlacklist = true,
  }) : assert(
         !(allowEmpty && !allowOnlyWhitespace),
         'allowEmpty=true with allowOnlyWhitespace=false is contradictory',
       );

  /// Whether empty input is accepted.
  final bool allowEmpty;

  /// Whether whitespace-only input is accepted.
  final bool allowOnlyWhitespace;

  /// Whether input is trimmed before validation and returned trimmed.
  final bool trimWhitespace;

  /// Minimum allowed input length after optional trimming.
  final int? minLength;

  /// Maximum allowed input length after optional trimming.
  final int? maxLength;

  /// Optional pattern that the whole value must match.
  final RegExp? pattern;

  /// Allowed characters. Null means all characters are allowed.
  final String? allowedCharacters;

  /// Words that are not allowed in the input.
  final Set<String> blacklistedWords;

  /// Whether blacklisted words must match whole words only.
  final bool wholeWordBlacklist;

  /// Preset for required text fields.
  factory TextValidationConfig.required({
    int? minLength,
    int? maxLength,
    RegExp? pattern,
    String? allowedCharacters,
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
      allowedCharacters: allowedCharacters,
      blacklistedWords: blacklistedWords,
      wholeWordBlacklist: wholeWordBlacklist,
    );
  }
}
