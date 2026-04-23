// ignore_for_file: public_member_api_docs

import '../either/left.dart';
import '../either/right.dart';
import '../regex/email_reg.dart';
import 'validation_issue.dart';

/// Configuration for email validation.
final class EmailValidationConfig {
  /// Maximum allowed email length.
  final int maxLength;

  /// Maximum allowed local-part length.
  final int maxLocalPartLength;

  /// Maximum allowed domain length.
  final int maxDomainLength;

  /// Known disposable domains.
  final Set<String> disposableDomains;

  /// Explicitly blocked domains.
  final Set<String> blockedDomains;

  /// Whether disposable domains are allowed.
  final bool allowDisposable;

  /// Creates an email validation config.
  const EmailValidationConfig({
    this.maxLength = 254,
    this.maxLocalPartLength = 64,
    this.maxDomainLength = 253,
    this.disposableDomains = _defaultDisposableDomains,
    this.blockedDomains = const {},
    this.allowDisposable = true,
  });

  /// A stricter preset that rejects disposable domains.
  factory EmailValidationConfig.strict() {
    return const EmailValidationConfig(allowDisposable: false);
  }

  static const Set<String> _defaultDisposableDomains = {
    '10minutemail.com',
    'guerrillamail.com',
    'mailinator.com',
    'temp-mail.org',
    'tempmail.com',
    'throwaway.email',
  };
}

/// Base type for email validation failures.
sealed class EmailValidationIssue extends ValidationIssue {
  const EmailValidationIssue();
}

/// Email input is empty.
final class EmailEmptyIssue extends EmailValidationIssue {
  const EmailEmptyIssue();

  @override
  String get code => 'email.empty';
}

/// Email does not match the expected format.
final class EmailInvalidFormatIssue extends EmailValidationIssue {
  const EmailInvalidFormatIssue();

  @override
  String get code => 'email.invalidFormat';
}

/// Email exceeds the configured maximum length.
final class EmailTooLongIssue extends EmailValidationIssue {
  final int currentLength;
  final int maxLength;

  const EmailTooLongIssue({
    required this.currentLength,
    required this.maxLength,
  });

  @override
  String get code => 'email.tooLong';
}

/// Email local part exceeds the configured maximum length.
final class EmailLocalPartTooLongIssue extends EmailValidationIssue {
  final int currentLength;
  final int maxLength;

  const EmailLocalPartTooLongIssue({
    required this.currentLength,
    required this.maxLength,
  });

  @override
  String get code => 'email.localPartTooLong';
}

/// Email domain exceeds the configured maximum length.
final class EmailDomainTooLongIssue extends EmailValidationIssue {
  final int currentLength;
  final int maxLength;

  const EmailDomainTooLongIssue({
    required this.currentLength,
    required this.maxLength,
  });

  @override
  String get code => 'email.domainTooLong';
}

/// Email uses a disposable domain.
final class EmailDisposableDomainIssue extends EmailValidationIssue {
  final String domain;

  const EmailDisposableDomainIssue(this.domain);

  @override
  String get code => 'email.disposableDomain';
}

/// Email uses a blocked domain.
final class EmailBlockedDomainIssue extends EmailValidationIssue {
  final String domain;

  const EmailBlockedDomainIssue(this.domain);

  @override
  String get code => 'email.blockedDomain';
}

/// Default English messages for email validation issues.
String resolveEmailValidationIssue(EmailValidationIssue issue) {
  return switch (issue) {
    EmailEmptyIssue() => 'Please enter an email address',
    EmailInvalidFormatIssue() => 'Please enter a valid email address',
    EmailTooLongIssue(:final maxLength) =>
      'Email must not exceed $maxLength characters',
    EmailLocalPartTooLongIssue(:final maxLength) =>
      'Email name must not exceed $maxLength characters',
    EmailDomainTooLongIssue(:final maxLength) =>
      'Email domain must not exceed $maxLength characters',
    EmailDisposableDomainIssue() =>
      'Disposable email addresses are not allowed',
    EmailBlockedDomainIssue() => 'Email domain is not allowed',
  };
}

/// Canonical validator for email inputs.
final class EmailValidator {
  /// Rules used during validation.
  final EmailValidationConfig config;

  /// Creates an email validator.
  const EmailValidator([this.config = const EmailValidationConfig()]);

  /// Validates and normalizes an email.
  ValidationResult<EmailValidationIssue, String> validate(String input) {
    final trimmed = input.trim();

    if (trimmed.isEmpty) {
      return const Left(EmailEmptyIssue());
    }

    if (trimmed.length > config.maxLength) {
      return Left(
        EmailTooLongIssue(
          currentLength: trimmed.length,
          maxLength: config.maxLength,
        ),
      );
    }

    if (!emailReg.hasMatch(trimmed)) {
      return const Left(EmailInvalidFormatIssue());
    }

    final parts = trimmed.split('@');
    if (parts.length != 2) {
      return const Left(EmailInvalidFormatIssue());
    }

    final localPart = parts[0];
    final domain = parts[1];

    if (localPart.length > config.maxLocalPartLength) {
      return Left(
        EmailLocalPartTooLongIssue(
          currentLength: localPart.length,
          maxLength: config.maxLocalPartLength,
        ),
      );
    }

    if (domain.length > config.maxDomainLength) {
      return Left(
        EmailDomainTooLongIssue(
          currentLength: domain.length,
          maxLength: config.maxDomainLength,
        ),
      );
    }

    final lowerDomain = domain.toLowerCase();

    if (config.blockedDomains.contains(lowerDomain)) {
      return Left(EmailBlockedDomainIssue(lowerDomain));
    }

    if (!config.allowDisposable &&
        config.disposableDomains.contains(lowerDomain)) {
      return Left(EmailDisposableDomainIssue(lowerDomain));
    }

    return Right(trimmed.toLowerCase());
  }
}
