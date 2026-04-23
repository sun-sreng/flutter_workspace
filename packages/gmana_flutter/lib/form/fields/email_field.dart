import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmana/validation.dart';
import 'package:gmana_flutter/form/models/field_config.dart';

import '../widgets/configured_text_form_field.dart';
import 'base_field.dart';

/// A customizable email input field with default validation and email-specific keyboard.
class GEmailField extends GBaseField {
  GEmailField({
    super.key,
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    EmailValidationConfig? validationConfig,
    ValidationMessageResolver<EmailValidationIssue>? validationMessageResolver,
    String? Function(String?)? validatorOverride,
    void Function(String)? onChanged,
    IconData? prefixIcon,
  }) : super(
         config: GFieldConfig(
           controller: controller,
           labelText: labelText,
           hintText: hintText ?? 'Enter your email',
           keyboardType: TextInputType.emailAddress,
           textInputAction: textInputAction ?? TextInputAction.next,
           inputFormatters: inputFormatters,
           validator: asFormValidator(
             validate:
                 EmailValidator(
                   validationConfig ?? const EmailValidationConfig(),
                 ).validate,
             resolve: validationMessageResolver ?? resolveEmailValidationIssue,
             validatorOverride: validatorOverride,
           ),
           onChanged: onChanged,
           prefixIcon: prefixIcon ?? Icons.email,
         ),
       );

  @override
  Widget build(BuildContext context) {
    return GConfiguredTextFormField(config: config);
  }
}
