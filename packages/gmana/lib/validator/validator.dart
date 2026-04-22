import 'package:gmana/validator/validation_rules.dart';
import 'package:gmana/validator/validators.dart';

export 'email_validate.dart';
export 'password_validate.dart';
export 'username_validate.dart';
export 'validation_rule.dart';
export 'validation_rules.dart';
export 'validators.dart';

/// A utility module providing reusable form field validators.
///
/// These functions wrap predefined validation rule sets from [ValidationRules]
/// and apply them via [Validators.validate]. Use them to easily validate
/// standard inputs like email, password, phone number, OTP, etc.

/// Validates an email address using [ValidationRules.email].
///
/// Returns an error message if validation fails, or `null` if valid.
String? validateEmail(String? value) => Validators.validate(value, ValidationRules.email);

/// Validates an OTP (one-time password) using [ValidationRules.otp].
///
/// Returns an error message if validation fails, or `null` if valid.
String? validateOtp(String? value) => Validators.validate(value, ValidationRules.otp);

/// Validates a password using [ValidationRules.password].
///
/// Returns an error message if validation fails, or `null` if valid.
String? validatePassword(String? value) => Validators.validate(value, ValidationRules.password);

/// Validates a phone number using [Validators.phoneNumber].
///
/// Returns an error message if validation fails, or `null` if valid.
String? validatePhoneNumber(String? value) => Validators.validate(value, [Validators.phoneNumber()]);

/// Validates a URL using [Validators.url].
///
/// Returns an error message if validation fails, or `null` if valid.
String? validateUrl(String? value) => Validators.validate(value, [Validators.url()]);

/// Validates a username using [ValidationRules.username].
///
/// Returns an error message if validation fails, or `null` if valid.
String? validateUsername(String? value) => Validators.validate(value, ValidationRules.username);
