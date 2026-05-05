# gmana_value_objects

Production-ready domain value objects with configurable validation for Email,
Password, Text, Number, and Money types, built on top of `gmana`.

`gmana_value_objects` is pure Dart and framework independent. Use it in CLI
apps, Dart servers, Flutter apps, or shared domain packages when you want typed
values, `Either`-based validation, and rich error models.

Use `gmana` for low-level rules and field validators. Use
`gmana_value_objects` when input should become a typed domain value before it
moves deeper into your application.

For complete API examples, see [doc/api.md](doc/api.md). For ecommerce money
modeling, see [doc/money.md](doc/money.md).

## Installation

```yaml
dependencies:
  gmana_value_objects: ^0.0.5
```

Or install it from the command line:

```bash
dart pub add gmana_value_objects
```

## Features

- Typed value objects for `Email`, `Password`, `TextValue`, `NumberValue`, and
  `Money`.
- Pure validators for each type when you want `Either<ValidationError, T>`
  without constructing a value object.
- Sealed error hierarchies for exhaustive `switch` handling.
- Stable `ValidationError.code` values for logs, APIs, analytics, and UI keys.
- Configurable validation presets for common application constraints.
- Default English validation messages with a small interface for i18n.
- Currency-aware money stored as exact integer minor units.

## Quick Start

```dart
import 'package:gmana_value_objects/gmana_value_objects.dart';

final email = Email('user@example.com');

if (email.isValid) {
  print(email.valueOrNull); // user@example.com
} else {
  print(email.errorOrNull?.code);
}
```

Every value object exposes:

| API | Meaning |
| --- | --- |
| `value` | Full `Either<ValidationError, T>` validation result. |
| `isValid` / `isInvalid` | Boolean validation state. |
| `valueOrNull` | Valid typed value, or `null`. |
| `errorOrNull` | Validation error, or `null`. |
| `isSensitive` | `true` for sensitive objects such as `Password`. |

## Email

```dart
final email = Email('USER@Example.COM');
print(email.valueOrNull); // user@example.com

final strictEmail = Email(
  'user@tempmail.com',
  config: EmailValidationConfig.strict(),
);

switch (strictEmail.errorOrNull) {
  case EmailDisposableDomain(:final domain):
    print('Disposable domain: $domain');
  case null:
    print('Valid email');
  default:
    print('Invalid email');
}
```

Email validation supports format checks, max lengths, disposable domains, and
custom blocked domains.

## Password

```dart
final password = Password(
  'MyP@ssw0rd!2026',
  config: PasswordValidationConfig.strict(),
);

print(password.isSensitive); // true
print(password.toString()); // Password(valid)
```

Password validation supports min/max length, ASCII-only rules, common password
checks, predictable sequence checks, and complexity scoring.

## Text

```dart
final username = TextValue(
  'john_doe',
  config: TextValidationConfig.username(),
);

final title = TextValue(
  'Hello World',
  config: TextValidationConfig(
    minLength: 5,
    maxLength: 50,
    pattern: r'^[a-zA-Z\s]+$',
    blacklistedWords: {'spam', 'banned'},
  ),
);
```

Text validation supports trimming, empty/whitespace rules, length bounds,
regular expressions, allowed characters, blacklisted words, and common presets.

## Number

```dart
final age = NumberValue('25', config: NumberValidationConfig.age());
final price = NumberValue('19.99', config: NumberValidationConfig.price());
final quantity = NumberValue.fromNum(
  10,
  config: NumberValidationConfig.positiveInteger(),
);
```

Number validation supports min/max bounds, integer-only mode, negative controls,
decimal-place limits, finite number checks, and presets for age, rating,
percentage, prices, and integer values.

## Money

`Money` stores exact integer minor units with currency metadata, so arithmetic
does not depend on floating-point decimal storage.

```dart
final unitPrice = Money.fromDecimalString('19.99', Currency.usd);
final shipping = Money.fromDecimalString('5.00', Currency.usd);
final total = unitPrice * 2 + shipping;
final discounted = total.applyDiscountPercent(10);

print(unitPrice.minorUnits); // 1999
print(discounted.formatted); // $40.48
```

Money supports:

- exact minor-unit storage, such as cents for USD
- zero, major/minor, decimal string, numeric, and `MoneyAmount` constructors
- same-currency arithmetic and comparison
- half-up rounding for multiplication and percentages
- proportional allocation without losing remainders
- deterministic display strings and API decimal strings
- `MoneyValidator` for `Either`-based form and pipeline validation

```dart
final result = MoneyValidator(MoneyValidationConfig.ecommerce())
    .validate('1,234.56', currency: 'USD');

result.fold(
  (error) => print(DefaultValidationErrorMessages().getMessage(error)),
  (amount) => print(amount.formattedWithCode), // USD 1234.56
);
```

## Default Messages

```dart
final messages = DefaultValidationErrorMessages();
final email = Email('invalid');

if (email.errorOrNull case final error?) {
  print(messages.getMessage(error)); // Invalid email format
}
```

For app-specific localization, switch on `ValidationError` subclasses directly:

```dart
String localize(ValidationError error) {
  return switch (error) {
    EmailEmpty() => 'Email is required',
    EmailInvalidFormat() => 'Enter a valid email',
    PasswordTooShort(:final minLength) =>
      'Use at least $minLength characters',
    _ => DefaultValidationErrorMessages().getMessage(error),
  };
}
```

## Composing With gmana

This package re-exports `Either`, `Left`, and `Right` from `gmana`, so value
object validation can compose with your own domain failures.

```dart
import 'package:gmana_value_objects/gmana_value_objects.dart' as vo;

sealed class Failure {}

final class ValidationFailure extends Failure {
  ValidationFailure(this.error);

  final vo.ValidationError error;
}

final class AppEmail {
  const AppEmail._(this.value);

  factory AppEmail(String input) {
    return AppEmail._(
      vo.Email(input).value.mapLeft(ValidationFailure.new),
    );
  }

  final vo.Either<Failure, String> value;
}
```

## Documentation

- [API guide](doc/api.md)
- [Email](doc/email.md)
- [Password](doc/password.md)
- [Text](doc/text.md)
- [Number](doc/number.md)
- [Money](doc/money.md)
- [Default validation messages](doc/default_validation_error_messages.md)
