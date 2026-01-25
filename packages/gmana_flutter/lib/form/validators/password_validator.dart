import 'package:flutter/material.dart';
import 'package:gmana_flutter/form/models/field_validator.dart';

/// Validator for confirming passwords match.
class ConfirmPasswordValidator implements FieldValidator {
  final TextEditingController passwordController;
  final String? Function(String?)? additionalValidator;

  const ConfirmPasswordValidator({
    required this.passwordController,
    this.additionalValidator,
  });

  @override
  String? validate(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    if (additionalValidator != null) {
      return additionalValidator!(value);
    }
    return null;
  }
}
