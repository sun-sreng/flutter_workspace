import 'package:gmana/validation.dart' hide isNull;
import 'package:test/test.dart';

void main() {
  group('asFormValidator', () {
    test('maps validation issues into form messages', () {
      final validator = asFormValidator(
        validate: const EmailValidator().validate,
        resolve: resolveEmailValidationIssue,
      );

      expect(validator(''), 'Please enter an email address');
      expect(validator('user@example.com'), isNull);
    });

    test('applies the override only after built-in validation succeeds', () {
      final validator = asFormValidator(
        validate: const EmailValidator().validate,
        resolve: resolveEmailValidationIssue,
        validatorOverride:
            (value) =>
                value == 'taken@example.com' ? 'Email already used' : null,
      );

      expect(validator(''), 'Please enter an email address');
      expect(validator('taken@example.com'), 'Email already used');
      expect(validator('fresh@example.com'), isNull);
    });
  });
}
