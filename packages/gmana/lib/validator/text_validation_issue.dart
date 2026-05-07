import 'validation_issue.dart';

/// Default English messages for text validation issues.
String resolveTextValidationIssue(TextValidationIssue issue) {
  return issue.defaultMessage;
}

/// Base type for text validation failures.
sealed class TextValidationIssue extends ValidationIssue {
  /// Creates a text validation issue.
  const TextValidationIssue();

  /// Default English message.
  String get defaultMessage;
}

/// Text contains one or more blacklisted words.
final class TextContainsBlacklistedIssue extends TextValidationIssue {
  /// Creates a blacklisted-word issue.
  const TextContainsBlacklistedIssue(this.foundWords);

  /// Blacklisted words found in the input.
  final List<String> foundWords;

  @override
  String get code => 'text.blacklistedWords';

  @override
  String get defaultMessage => 'Contains blocked words: ${foundWords.join(', ')}';
}

/// Text input is empty.
final class TextEmptyIssue extends TextValidationIssue {
  /// Creates an empty-text issue.
  const TextEmptyIssue();

  @override
  String get code => 'text.empty';

  @override
  String get defaultMessage => 'This field is required';
}

/// Text contains characters outside the allowed set.
final class TextInvalidCharactersIssue extends TextValidationIssue {
  /// Creates an invalid-characters issue.
  const TextInvalidCharactersIssue(this.invalidCharacters);

  /// Invalid characters found in the input.
  final String invalidCharacters;

  @override
  String get code => 'text.invalidCharacters';

  @override
  String get defaultMessage => 'Contains invalid characters: $invalidCharacters';
}

/// Text does not match the configured pattern.
final class TextInvalidPatternIssue extends TextValidationIssue {
  /// Creates an invalid-pattern issue.
  const TextInvalidPatternIssue();

  @override
  String get code => 'text.invalidPattern';

  @override
  String get defaultMessage => 'This field has an invalid format';
}

/// Text contains only whitespace.
final class TextOnlyWhitespaceIssue extends TextValidationIssue {
  /// Creates an only-whitespace issue.
  const TextOnlyWhitespaceIssue();

  @override
  String get code => 'text.onlyWhitespace';

  @override
  String get defaultMessage => 'This field cannot contain only whitespace';
}

/// Text is longer than allowed.
final class TextTooLongIssue extends TextValidationIssue {
  /// Creates a too-long issue.
  const TextTooLongIssue({
    required this.currentLength,
    required this.maxLength,
  });

  /// The provided input length.
  final int currentLength;

  /// The configured maximum length.
  final int maxLength;

  @override
  String get code => 'text.tooLong';

  @override
  String get defaultMessage => 'Please enter no more than $maxLength characters';
}

/// Text is shorter than allowed.
final class TextTooShortIssue extends TextValidationIssue {
  /// Creates a too-short issue.
  const TextTooShortIssue({
    required this.currentLength,
    required this.minLength,
  });

  /// The provided input length.
  final int currentLength;

  /// The configured minimum length.
  final int minLength;

  @override
  String get code => 'text.tooShort';

  @override
  String get defaultMessage => 'Please enter at least $minLength characters';
}
