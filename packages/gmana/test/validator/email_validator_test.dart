import 'package:gmana/validator/email_validator.dart';
import 'package:test/test.dart';

void main() {
  group('EmailValidator', () {
    test('rejects empty values', () {
      expect(
        const EmailValidator().validate(null),
        'Please enter an email address',
      );
      expect(
        const EmailValidator().validate(''),
        'Please enter an email address',
      );
    });

    test('rejects malformed emails', () {
      expect(
        const EmailValidator().validate('invalid'),
        'Please enter a valid email address',
      );
    });

    test('accepts valid emails', () {
      expect(const EmailValidator().validate('user@example.com'), isNull);
    });
  });
}
