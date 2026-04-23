import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmana/validation.dart';

import '../models/field_config.dart';
import '../widgets/configured_text_form_field.dart';
import 'base_field.dart';

/// A customizable text input field.
class GTextField extends GBaseField {
  GTextField({
    super.key,
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    TextValidationConfig? validationConfig,
    ValidationMessageResolver<TextValidationIssue>? validationMessageResolver,
    String? Function(String?)? validatorOverride,
    void Function(String)? onChanged,
    IconData? prefixIcon,
  }) : super(
         config: GFieldConfig(
           controller: controller,
           labelText: labelText,
           hintText: hintText ?? '',
           keyboardType: TextInputType.text,
           textInputAction: textInputAction ?? TextInputAction.next,
           inputFormatters: inputFormatters,
           validator: asFormValidator(
             validate:
                 TextValidator(
                   validationConfig ?? const TextValidationConfig(),
                 ).validate,
             resolve: validationMessageResolver ?? resolveTextValidationIssue,
             validatorOverride: validatorOverride,
           ),
           onChanged: onChanged,
           prefixIcon: prefixIcon ?? Icons.text_fields,
         ),
       );

  @override
  Widget build(BuildContext context) {
    return GConfiguredTextFormField(config: config);
  }
}
