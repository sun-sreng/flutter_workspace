// ignore_for_file: public_member_api_docs

import '../either/left.dart';
import '../either/right.dart';
import 'validation_issue.dart';

/// Configuration for password validation.
final class PasswordValidationConfig {
  /// Minimum allowed password length.
  final int minLength;

  /// Maximum allowed password length.
  final int maxLength;

  /// Whether at least one uppercase letter is required.
  final bool requireUppercase;

  /// Whether at least one lowercase letter is required.
  final bool requireLowercase;

  /// Whether at least one digit is required.
  final bool requireDigit;

  /// Whether at least one special character is required.
  final bool requireSpecialCharacter;

  /// Whether common passwords should be rejected.
  final bool rejectCommonPasswords;

  /// Whether repeated-character passwords should be rejected.
  final bool rejectRepeatedCharacters;

  /// Whether sequential character runs should be rejected.
  final bool rejectSequentialPatterns;

  /// Minimum run length that counts as sequential.
  final int minSequentialRun;

  /// List of exact blacklisted passwords.
  final Set<String> commonPasswords;

  /// List of blacklisted prefixes.
  final List<String> commonPrefixes;

  /// Creates a password validation config.
  const PasswordValidationConfig({
    this.minLength = 8,
    this.maxLength = 128,
    this.requireUppercase = true,
    this.requireLowercase = true,
    this.requireDigit = true,
    this.requireSpecialCharacter = true,
    this.rejectCommonPasswords = true,
    this.rejectRepeatedCharacters = true,
    this.rejectSequentialPatterns = true,
    this.minSequentialRun = 4,
    this.commonPasswords = _defaultCommonPasswords,
    this.commonPrefixes = _defaultCommonPrefixes,
  });

  /// Strong preset equivalent to the package default.
  factory PasswordValidationConfig.strong() {
    return const PasswordValidationConfig();
  }

  /// Lenient preset that only enforces a minimum length.
  factory PasswordValidationConfig.lenient() {
    return const PasswordValidationConfig(
      minLength: 4,
      requireUppercase: false,
      requireLowercase: false,
      requireDigit: false,
      requireSpecialCharacter: false,
      rejectCommonPasswords: false,
      rejectRepeatedCharacters: false,
      rejectSequentialPatterns: false,
    );
  }

  static const Set<String> _defaultCommonPasswords = {
    '00000000',
    '11111111',
    '12345678',
    '123456789',
    'admin123',
    'iloveyou',
    'password',
    'password123',
    'qwerty123',
  };

  static const List<String> _defaultCommonPrefixes = [
    'admin',
    'letmein',
    'password',
    'qwerty',
  ];
}

/// Base type for password validation failures.
sealed class PasswordValidationIssue extends ValidationIssue {
  const PasswordValidationIssue();
}

/// Password input is empty.
final class PasswordEmptyIssue extends PasswordValidationIssue {
  const PasswordEmptyIssue();

  @override
  String get code => 'password.empty';
}

/// Password is shorter than allowed.
final class PasswordTooShortIssue extends PasswordValidationIssue {
  final int currentLength;
  final int minLength;

  const PasswordTooShortIssue({
    required this.currentLength,
    required this.minLength,
  });

  @override
  String get code => 'password.tooShort';
}

/// Password is longer than allowed.
final class PasswordTooLongIssue extends PasswordValidationIssue {
  final int currentLength;
  final int maxLength;

  const PasswordTooLongIssue({
    required this.currentLength,
    required this.maxLength,
  });

  @override
  String get code => 'password.tooLong';
}

/// Password is missing an uppercase letter.
final class PasswordMissingUppercaseIssue extends PasswordValidationIssue {
  const PasswordMissingUppercaseIssue();

  @override
  String get code => 'password.missingUppercase';
}

/// Password is missing a lowercase letter.
final class PasswordMissingLowercaseIssue extends PasswordValidationIssue {
  const PasswordMissingLowercaseIssue();

  @override
  String get code => 'password.missingLowercase';
}

/// Password is missing a digit.
final class PasswordMissingDigitIssue extends PasswordValidationIssue {
  const PasswordMissingDigitIssue();

  @override
  String get code => 'password.missingDigit';
}

/// Password is missing a special character.
final class PasswordMissingSpecialCharacterIssue
    extends PasswordValidationIssue {
  const PasswordMissingSpecialCharacterIssue();

  @override
  String get code => 'password.missingSpecialCharacter';
}

/// Password is too common.
final class PasswordTooCommonIssue extends PasswordValidationIssue {
  const PasswordTooCommonIssue();

  @override
  String get code => 'password.tooCommon';
}

/// Password uses a repeated-character pattern.
final class PasswordRepeatedCharacterIssue extends PasswordValidationIssue {
  const PasswordRepeatedCharacterIssue();

  @override
  String get code => 'password.repeatedCharacterPattern';
}

/// Password uses a sequential pattern.
final class PasswordSequentialPatternIssue extends PasswordValidationIssue {
  const PasswordSequentialPatternIssue();

  @override
  String get code => 'password.sequentialPattern';
}

/// Default English messages for password validation issues.
String resolvePasswordValidationIssue(PasswordValidationIssue issue) {
  return switch (issue) {
    PasswordEmptyIssue() => 'Password is required',
    PasswordTooShortIssue(:final minLength) => 'Minimum $minLength characters',
    PasswordTooLongIssue(:final maxLength) => 'Maximum $maxLength characters',
    PasswordMissingUppercaseIssue() => 'At least one uppercase letter',
    PasswordMissingLowercaseIssue() => 'At least one lowercase letter',
    PasswordMissingDigitIssue() => 'At least one number',
    PasswordMissingSpecialCharacterIssue() => 'At least one special character',
    PasswordTooCommonIssue() => 'Password is too common',
    PasswordRepeatedCharacterIssue() => 'Password is too predictable',
    PasswordSequentialPatternIssue() => 'Password is too predictable',
  };
}

/// Canonical validator for password inputs.
final class PasswordValidator {
  /// Rules used during validation.
  final PasswordValidationConfig config;

  /// Creates a password validator.
  const PasswordValidator([this.config = const PasswordValidationConfig()]);

  /// Returns whether the input contains an uppercase letter.
  static bool hasUppercase(String input) => RegExp(r'[A-Z]').hasMatch(input);

  /// Returns whether the input contains a lowercase letter.
  static bool hasLowercase(String input) => RegExp(r'[a-z]').hasMatch(input);

  /// Returns whether the input contains a digit.
  static bool hasDigit(String input) => RegExp(r'\d').hasMatch(input);

  /// Returns whether the input contains a special character.
  static bool hasSpecialCharacter(String input) {
    return RegExp(r'[^A-Za-z\d]').hasMatch(input);
  }

  /// Returns whether every character in the input is identical.
  static bool hasOnlyRepeatedCharacters(String input) {
    if (input.isEmpty) {
      return false;
    }
    final first = input.codeUnitAt(0);
    return input.codeUnits.every((unit) => unit == first);
  }

  /// Returns whether the input contains a long increasing or decreasing run.
  static bool hasSequentialRun(String input, {int minRun = 4}) {
    if (input.length < minRun) {
      return false;
    }

    final lowered = input.toLowerCase();
    var increasing = 1;
    var decreasing = 1;

    for (var index = 1; index < lowered.length; index++) {
      final previous = lowered.codeUnitAt(index - 1);
      final current = lowered.codeUnitAt(index);

      if (current == previous + 1) {
        increasing++;
        if (increasing >= minRun) {
          return true;
        }
      } else {
        increasing = 1;
      }

      if (current == previous - 1) {
        decreasing++;
        if (decreasing >= minRun) {
          return true;
        }
      } else {
        decreasing = 1;
      }
    }

    return false;
  }

  /// Validates a password against the configured policy.
  ValidationResult<PasswordValidationIssue, String> validate(String input) {
    if (input.isEmpty) {
      return const Left(PasswordEmptyIssue());
    }

    if (input.length < config.minLength) {
      return Left(
        PasswordTooShortIssue(
          currentLength: input.length,
          minLength: config.minLength,
        ),
      );
    }

    if (input.length > config.maxLength) {
      return Left(
        PasswordTooLongIssue(
          currentLength: input.length,
          maxLength: config.maxLength,
        ),
      );
    }

    if (config.requireUppercase && !hasUppercase(input)) {
      return const Left(PasswordMissingUppercaseIssue());
    }

    if (config.requireLowercase && !hasLowercase(input)) {
      return const Left(PasswordMissingLowercaseIssue());
    }

    if (config.requireDigit && !hasDigit(input)) {
      return const Left(PasswordMissingDigitIssue());
    }

    if (config.requireSpecialCharacter && !hasSpecialCharacter(input)) {
      return const Left(PasswordMissingSpecialCharacterIssue());
    }

    final lowered = input.toLowerCase();

    if (config.rejectCommonPasswords) {
      if (config.commonPasswords.contains(lowered)) {
        return const Left(PasswordTooCommonIssue());
      }

      final hasCommonPrefix = config.commonPrefixes.any(
        (prefix) =>
            lowered.startsWith(prefix) && lowered.length <= prefix.length + 4,
      );
      if (hasCommonPrefix) {
        return const Left(PasswordTooCommonIssue());
      }
    }

    if (config.rejectRepeatedCharacters && hasOnlyRepeatedCharacters(input)) {
      return const Left(PasswordRepeatedCharacterIssue());
    }

    final sequentialThreshold =
        config.minSequentialRun < 3 ? 3 : config.minSequentialRun;
    if (config.rejectSequentialPatterns &&
        hasSequentialRun(input, minRun: sequentialThreshold)) {
      return const Left(PasswordSequentialPatternIssue());
    }

    return Right(input);
  }
}
