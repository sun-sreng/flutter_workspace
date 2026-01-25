import 'package:gmana_flutter/form/models/field_validator.dart';

/// Validator for email fields, ensuring valid email format.
class EmailValidator implements FieldValidator {
  final String? Function(String?)? additionalValidator;

  const EmailValidator({this.additionalValidator});

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }

    // Basic email format check: must contain @ and a domain
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    if (additionalValidator != null) {
      return additionalValidator!(value);
    }

    return null;
  }
}
