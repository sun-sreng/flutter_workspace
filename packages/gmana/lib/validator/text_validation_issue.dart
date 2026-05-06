// text_validation_issue.dart
import 'validation_issue.dart';

final class TextContainsBlacklistedIssue extends TextValidationIssue {
  final List<String> foundWords;
  const TextContainsBlacklistedIssue(this.foundWords);
  @override
  String get code => 'text.blacklistedWords';
  @override
  String get defaultMessage =>
      'Contains blocked words: ${foundWords.join(', ')}';
}

final class TextEmptyIssue extends TextValidationIssue {
  const TextEmptyIssue();
  @override
  String get code => 'text.empty';
  @override
  String get defaultMessage => 'This field is required';
}

final class TextInvalidCharactersIssue extends TextValidationIssue {
  final String invalidCharacters;
  const TextInvalidCharactersIssue(this.invalidCharacters);
  @override
  String get code => 'text.invalidCharacters';
  @override
  String get defaultMessage =>
      'Contains invalid characters: $invalidCharacters';
}

final class TextInvalidPatternIssue extends TextValidationIssue {
  // No pattern field — regex is an implementation detail, not UI data
  const TextInvalidPatternIssue();
  @override
  String get code => 'text.invalidPattern';
  @override
  String get defaultMessage => 'This field has an invalid format';
}

final class TextOnlyWhitespaceIssue extends TextValidationIssue {
  const TextOnlyWhitespaceIssue();
  @override
  String get code => 'text.onlyWhitespace';
  @override
  String get defaultMessage => 'This field cannot contain only whitespace';
}

final class TextTooLongIssue extends TextValidationIssue {
  final int currentLength;
  final int maxLength;
  const TextTooLongIssue({
    required this.currentLength,
    required this.maxLength,
  });
  @override
  String get code => 'text.tooLong';
  @override
  String get defaultMessage =>
      'Please enter no more than $maxLength characters';
}

final class TextTooShortIssue extends TextValidationIssue {
  final int currentLength;
  final int minLength;
  const TextTooShortIssue({
    required this.currentLength,
    required this.minLength,
  });
  @override
  String get code => 'text.tooShort';
  @override
  String get defaultMessage => 'Please enter at least $minLength characters';
}

sealed class TextValidationIssue extends ValidationIssue {
  const TextValidationIssue();
  String get defaultMessage;
}
