import 'package:gmana_value_objects/gmana_value_objects.dart';
import 'package:test/test.dart';

final class UnknownValidationError extends ValidationError {
  const UnknownValidationError();
}

void main() {
  group('DefaultValidationErrorMessages', () {
    const messages = DefaultValidationErrorMessages();

    test('formats representative built-in errors', () {
      expect(messages.getMessage(const EmailEmpty()), 'Email cannot be empty');
      expect(
        messages.getMessage(
          const PasswordTooShort(currentLength: 4, minLength: 8),
        ),
        'Password must be at least 8 characters (current: 4)',
      );
      expect(
        messages.getMessage(const TextContainsBlacklisted(['spam', 'banned'])),
        'Contains prohibited words: spam, banned',
      );
      expect(
        messages.getMessage(
          const NumberDecimalPlacesExceeded(currentPlaces: 3, maxPlaces: 2),
        ),
        'Too many decimal places (max: 2, current: 3)',
      );
      expect(
        messages.getMessage(
          const MoneyUnsupportedCurrency(
            currency: 'EUR',
            allowedCurrencies: {'USD'},
          ),
        ),
        'Unsupported currency EUR (allowed: USD)',
      );
    });

    test('falls back for unknown validation errors', () {
      expect(
        messages.getMessage(const UnknownValidationError()),
        'Validation error',
      );
      expect(const UnknownValidationError().code, 'unknown_validation_error');
    });
  });
}
