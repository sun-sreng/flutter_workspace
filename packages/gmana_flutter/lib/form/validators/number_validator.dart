import 'package:gmana_flutter/form/models/field_validator.dart';

class NumberValidator implements FieldValidator {
  final int? minValue;
  final int? maxValue;
  final String? Function(String?)? additionalValidator;

  const NumberValidator({
    this.minValue,
    this.maxValue,
    this.additionalValidator,
  });

  @override
  String? validate(String? value) {
    if (additionalValidator != null) {
      final result = additionalValidator!(value);
      if (result != null) return result;
    }
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (minValue != null && number < minValue!) {
      return 'Number must be at least $minValue';
    }
    if (maxValue != null && number > maxValue!) {
      return 'Number must be at most $maxValue';
    }
    return null;
  }
}
