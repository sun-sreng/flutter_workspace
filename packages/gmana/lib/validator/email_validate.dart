import 'validators.dart';

/// Validates an email string using a set of predefined rules.
///
/// This function applies the following validation rules to the [value]:
/// - The field must not be null or empty (`required`)
/// - The field must match a valid email format (`email`)
///
/// Returns:
/// - A validation error message if the input is invalid.
/// - `null` if the input passes all validations.
String? validateEmail(String? value) {
  return Validators.validate(value, [
    Validators.required(message: 'Email is required'),
    Validators.email(message: 'Please enter a valid email address'),
  ]);
}
