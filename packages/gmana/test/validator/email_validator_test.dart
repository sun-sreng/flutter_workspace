import 'package:gmana/validation.dart' hide isNull;
import 'package:test/test.dart';

void main() {
  group('EmailValidator', () {
    test('rejects empty values', () {
      final result = const EmailValidator().validate('');

      expect(result.leftOrNull(), isA<EmailEmptyIssue>());
    });

    test('normalizes valid emails by trimming and lowercasing', () {
      final result = const EmailValidator().validate(' User@Example.COM ');

      expect(result.rightOrNull(), 'user@example.com');
    });

    test('rejects malformed emails', () {
      final result = const EmailValidator().validate('invalid');

      expect(result.leftOrNull(), isA<EmailInvalidFormatIssue>());
    });

    test('rejects disposable domains in strict mode', () {
      final result = EmailValidator(
        EmailValidationConfig.strict(),
      ).validate('user@mailinator.com');

      expect(result.leftOrNull(), isA<EmailDisposableDomainIssue>());
    });

    test('rejects blocked domains', () {
      final result = EmailValidator(
        const EmailValidationConfig(blockedDomains: {'blocked.com'}),
      ).validate('user@blocked.com');

      expect(result.leftOrNull(), isA<EmailBlockedDomainIssue>());
    });

    test('rejects values longer than the configured maximum', () {
      final result = EmailValidator(
        const EmailValidationConfig(maxLength: 10),
      ).validate('user@example.com');

      expect(result.leftOrNull(), isA<EmailTooLongIssue>());
    });
  });
}
