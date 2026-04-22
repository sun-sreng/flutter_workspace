import 'validation_rule.dart';
import 'validators.dart';

/// Validates a password string based on the provided [requirements].
///
/// This function applies a customizable set of [ValidationRule]s depending
/// on which [PasswordRequirement]s are passed in. It supports the following:
/// - Required: Password must not be empty.
/// - Minimum Length: Defined by [minLength] (default is 8).
/// - At least one uppercase letter.
/// - At least one lowercase letter.
/// - At least one digit.
/// - At least one special character from [specialCharacters].
/// - Cannot be a common or easily guessable password.
///
/// Returns:
/// - `null` if the password passes all validations.
/// - A string error message if a validation fails.
String? validatePassword(
  String? value, {
  int minLength = 8,
  Set<PasswordRequirement> requirements = const {PasswordRequirement.minLength},
  String specialCharacters = r'[#?!@$%^&*-]',
}) {
  final rules = <ValidationRule>[Validators.required(message: 'Password is required')];

  if (requirements.contains(PasswordRequirement.minLength)) {
    rules.add(Validators.minLength(minLength, message: 'Password must be at least $minLength characters'));
  }

  if (requirements.contains(PasswordRequirement.upperCase)) {
    rules.add(Validators.oneUpperCase(message: PasswordRequirement.upperCase.message));
  }

  if (requirements.contains(PasswordRequirement.lowerCase)) {
    rules.add(Validators.oneLowerCase(message: PasswordRequirement.lowerCase.message));
  }

  if (requirements.contains(PasswordRequirement.digit)) {
    rules.add(Validators.oneNumber(message: PasswordRequirement.digit.message));
  }

  if (requirements.contains(PasswordRequirement.special)) {
    final escapedSpecialChars = RegExp.escape(specialCharacters);
    rules.add(
      Validators.pattern(
        '(?=.*[$escapedSpecialChars])',
        message: 'Password must contain at least one special character ($specialCharacters)',
      ),
    );
  }

  if (requirements.contains(PasswordRequirement.notCommon)) {
    rules.add(
      Validators.custom(
        (value) => _isCommonPassword(value) ? '' : null,
        message: PasswordRequirement.notCommon.message,
      ),
    );
  }

  return Validators.validate(value, rules);
}

/// Checks if the [password] is a common or easily guessable password.
///
/// This includes passwords like '123456', 'password', 'admin', etc.
bool _isCommonPassword(String? password) {
  const commonPasswords = [
    'password',
    '123456',
    'qwerty',
    'letmein',
    'admin',
    'welcome',
    '12345678',
    '123456789',
    '123123',
    '111111',
  ];
  return password != null && commonPasswords.contains(password.toLowerCase());
}

/// Defines the set of possible requirements for password validation.
///
/// Each enum value also includes a default error [message] used during validation.
enum PasswordRequirement {
  /// Ensures the password meets the minimum character length.
  minLength(message: 'Password must meet minimum length'),

  /// Ensures the password contains at least one uppercase letter.
  upperCase(message: 'Password must contain uppercase letter'),

  /// Ensures the password contains at least one lowercase letter.
  lowerCase(message: 'Password must contain lowercase letter'),

  /// Ensures the password contains at least one numeric digit.
  digit(message: 'Password must contain digit'),

  /// Ensures the password contains at least one special character.
  special(message: 'Password must contain special character'),

  /// Ensures the password is not among common or weak passwords.
  notCommon(message: 'Password is too common');

  /// The default message to be used when this rule fails.
  final String message;

  const PasswordRequirement({required this.message});
}
