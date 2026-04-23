// ignore_for_file: public_member_api_docs

import '../either/left.dart';
import '../either/right.dart';
import 'validation_issue.dart';

/// Configuration for generic text validation.
final class TextValidationConfig {
  /// Whether empty values are allowed.
  final bool allowEmpty;

  /// Whether whitespace-only values are allowed.
  final bool allowOnlyWhitespace;

  /// Whether the input should be trimmed before validation.
  final bool trimWhitespace;

  /// Minimum allowed length.
  final int? minLength;

  /// Maximum allowed length.
  final int? maxLength;

  /// Required pattern.
  final String? pattern;

  /// Allowed characters, if restricted.
  final String? allowedCharacters;

  /// Blacklisted words.
  final Set<String> blacklistedWords;

  /// Creates a text validation config.
  const TextValidationConfig({
    this.allowEmpty = true,
    this.allowOnlyWhitespace = true,
    this.trimWhitespace = false,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.allowedCharacters,
    this.blacklistedWords = const {},
  });

  /// Preset for required text input.
  factory TextValidationConfig.required({
    int? minLength,
    int? maxLength,
    String? pattern,
    String? allowedCharacters,
    Set<String> blacklistedWords = const {},
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
    );
  }
}

/// Base type for text validation failures.
sealed class TextValidationIssue extends ValidationIssue {
  const TextValidationIssue();
}

/// Text input is empty.
final class TextEmptyIssue extends TextValidationIssue {
  const TextEmptyIssue();

  @override
  String get code => 'text.empty';
}

/// Text contains only whitespace.
final class TextOnlyWhitespaceIssue extends TextValidationIssue {
  const TextOnlyWhitespaceIssue();

  @override
  String get code => 'text.onlyWhitespace';
}

/// Text is shorter than allowed.
final class TextTooShortIssue extends TextValidationIssue {
  final int currentLength;
  final int minLength;

  const TextTooShortIssue({
    required this.currentLength,
    required this.minLength,
  });

  @override
  String get code => 'text.tooShort';
}

/// Text is longer than allowed.
final class TextTooLongIssue extends TextValidationIssue {
  final int currentLength;
  final int maxLength;

  const TextTooLongIssue({
    required this.currentLength,
    required this.maxLength,
  });

  @override
  String get code => 'text.tooLong';
}

/// Text does not match the required pattern.
final class TextInvalidPatternIssue extends TextValidationIssue {
  final String pattern;

  const TextInvalidPatternIssue(this.pattern);

  @override
  String get code => 'text.invalidPattern';
}

/// Text includes disallowed characters.
final class TextInvalidCharactersIssue extends TextValidationIssue {
  final String invalidCharacters;

  const TextInvalidCharactersIssue(this.invalidCharacters);

  @override
  String get code => 'text.invalidCharacters';
}

/// Text contains blacklisted words.
final class TextContainsBlacklistedIssue extends TextValidationIssue {
  final List<String> foundWords;

  const TextContainsBlacklistedIssue(this.foundWords);

  @override
  String get code => 'text.blacklistedWords';
}

/// Default English messages for text validation issues.
String resolveTextValidationIssue(TextValidationIssue issue) {
  return switch (issue) {
    TextEmptyIssue() => 'This field is required',
    TextOnlyWhitespaceIssue() => 'This field cannot contain only whitespace',
    TextTooShortIssue(:final minLength) =>
      'Please enter at least $minLength characters',
    TextTooLongIssue(:final maxLength) =>
      'Please enter no more than $maxLength characters',
    TextInvalidPatternIssue() => 'This field has an invalid format',
    TextInvalidCharactersIssue(:final invalidCharacters) =>
      'Contains invalid characters: $invalidCharacters',
    TextContainsBlacklistedIssue(:final foundWords) =>
      'Contains blocked words: ${foundWords.join(', ')}',
  };
}

/// Canonical validator for generic text inputs.
final class TextValidator {
  /// Rules used during validation.
  final TextValidationConfig config;

  /// Creates a text validator.
  const TextValidator([this.config = const TextValidationConfig()]);

  /// Validates and optionally normalizes a text value.
  ValidationResult<TextValidationIssue, String> validate(String input) {
    final value = config.trimWhitespace ? input.trim() : input;

    if (value.isEmpty) {
      if (config.allowEmpty) {
        return Right(value);
      }
      return const Left(TextEmptyIssue());
    }

    if (!config.allowOnlyWhitespace && value.trim().isEmpty) {
      return const Left(TextOnlyWhitespaceIssue());
    }

    if (config.minLength != null && value.length < config.minLength!) {
      return Left(
        TextTooShortIssue(
          currentLength: value.length,
          minLength: config.minLength!,
        ),
      );
    }

    if (config.maxLength != null && value.length > config.maxLength!) {
      return Left(
        TextTooLongIssue(
          currentLength: value.length,
          maxLength: config.maxLength!,
        ),
      );
    }

    if (config.pattern != null && !RegExp(config.pattern!).hasMatch(value)) {
      return Left(TextInvalidPatternIssue(config.pattern!));
    }

    if (config.allowedCharacters != null) {
      final invalidCharacters =
          value
              .split('')
              .where((char) => !config.allowedCharacters!.contains(char))
              .toSet()
              .join();
      if (invalidCharacters.isNotEmpty) {
        return Left(TextInvalidCharactersIssue(invalidCharacters));
      }
    }

    if (config.blacklistedWords.isNotEmpty) {
      final lowered = value.toLowerCase();
      final foundWords =
          config.blacklistedWords
              .where((word) => lowered.contains(word.toLowerCase()))
              .toList();
      if (foundWords.isNotEmpty) {
        return Left(TextContainsBlacklistedIssue(foundWords));
      }
    }

    return Right(value);
  }
}
