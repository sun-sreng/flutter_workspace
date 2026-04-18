import '../core/validation_error.dart';

/// Base class for all text-related validation errors.
sealed class TextError extends ValidationError {
  /// Internal constructor for [TextError].
  const TextError();
}

/// Error indicating that the text is empty.
final class TextEmpty extends TextError {
  /// Creates a new [TextEmpty] error.
  const TextEmpty();
}

/// Error indicating that the text does not meet the minimum length requirement.
final class TextTooShort extends TextError {
  /// The length of the provided text.
  final int currentLength;

  /// The minimum allowed length.
  final int minLength;

  /// Creates a new [TextTooShort] error.
  const TextTooShort({required this.currentLength, required this.minLength});
}

/// Error indicating that the text exceeds the maximum allowed length.
final class TextTooLong extends TextError {
  /// The length of the provided text.
  final int currentLength;

  /// The maximum allowed length.
  final int maxLength;

  /// Creates a new [TextTooLong] error.
  const TextTooLong({required this.currentLength, required this.maxLength});
}

/// Error indicating that the text does not match the required regular expression pattern.
final class TextInvalidPattern extends TextError {
  /// The required pattern that was not matched.
  final String pattern;

  /// Creates a new [TextInvalidPattern] error.
  const TextInvalidPattern(this.pattern);
}

/// Error indicating that the text contains prohibited/blacklisted words.
final class TextContainsBlacklisted extends TextError {
  /// The blacklisted words found in the text.
  final List<String> foundWords;

  /// Creates a new [TextContainsBlacklisted] error.
  const TextContainsBlacklisted(this.foundWords);
}

/// Error indicating that the text consists entirely of whitespace.
final class TextOnlyWhitespace extends TextError {
  /// Creates a new [TextOnlyWhitespace] error.
  const TextOnlyWhitespace();
}

/// Error indicating that the text contains invalid characters not allowed by configuration.
final class TextInvalidCharacters extends TextError {
  /// The characters that are considered invalid.
  final String invalidChars;

  /// Creates a new [TextInvalidCharacters] error.
  const TextInvalidCharacters(this.invalidChars);
}
