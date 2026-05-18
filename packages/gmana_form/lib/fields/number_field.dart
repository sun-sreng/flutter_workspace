import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmana/validation.dart';

import '../models/field_config.dart';
import '../widgets/configured_text_form_field.dart';
import 'base_field.dart';

/// A number input field with min/max validation.
class GNumberField extends GBaseField {
  GNumberField({
    super.key,
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    NumberValidationConfig? validationConfig,
    ValidationMessageResolver<NumberValidationIssue>? validationMessageResolver,
    String? Function(String?)? validatorOverride,
    void Function(String)? onChanged,
  }) : super(
         config: GFieldConfig(
           controller: controller,
           labelText: labelText,
           hintText: hintText ?? '',
           keyboardType: TextInputType.numberWithOptions(
             signed: _effectiveValidationConfig(validationConfig).allowNegative,
             decimal: !_effectiveValidationConfig(validationConfig).integerOnly,
           ),
           textInputAction: textInputAction ?? TextInputAction.next,
           inputFormatters: _buildInputFormatters(
             inputFormatters: inputFormatters,
             validationConfig: validationConfig,
           ),
           validator: asFormValidator(
             validate:
                 NumberValidator(
                   _effectiveValidationConfig(validationConfig),
                 ).validate,
             resolve: validationMessageResolver ?? resolveNumberValidationIssue,
             validatorOverride: validatorOverride,
           ),
           onChanged: onChanged,
           prefixIcon: Icons.onetwothree,
         ),
       );

  @override
  Widget build(BuildContext context) {
    return GConfiguredTextFormField(config: config);
  }

  static NumberValidationConfig _effectiveValidationConfig(
    NumberValidationConfig? validationConfig,
  ) {
    return validationConfig ??
        const NumberValidationConfig(allowNegative: false, integerOnly: true);
  }

  static List<TextInputFormatter>? _buildInputFormatters({
    required List<TextInputFormatter>? inputFormatters,
    required NumberValidationConfig? validationConfig,
  }) {
    final config = _effectiveValidationConfig(validationConfig);
    final defaultFormatter = switch ((
      config.integerOnly,
      config.allowNegative,
    )) {
      (true, false) => FilteringTextInputFormatter.digitsOnly,
      (true, true) => FilteringTextInputFormatter.allow(RegExp(r'^-?\d*$')),
      (false, false) => FilteringTextInputFormatter.allow(
        RegExp(r'^\d*\.?\d*$'),
      ),
      (false, true) => FilteringTextInputFormatter.allow(
        RegExp(r'^-?\d*\.?\d*$'),
      ),
    };

    return [defaultFormatter, if (inputFormatters != null) ...inputFormatters];
  }
}
