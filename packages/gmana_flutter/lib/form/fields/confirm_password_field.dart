import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmana/validation.dart';

import '../models/field_config.dart';
import '../validators/confirm_password_validator.dart';
import '../widgets/obscurable_text_form_field.dart';
import 'base_field.dart';

class GConfirmPasswordField extends GBaseField {
  GConfirmPasswordField({
    super.key,
    required TextEditingController controller,
    required TextEditingController passwordController,
    String labelText = 'Confirm Password',
    String? hintText,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    ConfirmPasswordValidationConfig? validationConfig,
    ValidationMessageResolver<ConfirmPasswordValidationIssue>?
    validationMessageResolver,
    String? Function(String?)? validatorOverride,
    void Function(String)? onChanged,
  }) : super(
         config: GFieldConfig(
           controller: controller,
           labelText: labelText,
           hintText: hintText ?? 'Re-enter your password',
           keyboardType: TextInputType.visiblePassword,
           textInputAction: textInputAction ?? TextInputAction.done,
           inputFormatters: inputFormatters,
           validator: (value) {
             final message = ConfirmPasswordValidator(
                   validationConfig ?? const ConfirmPasswordValidationConfig(),
                 )
                 .validate(
                   password: passwordController.text,
                   confirmation: value ?? '',
                 )
                 .fold(
                   validationMessageResolver ??
                       resolveConfirmPasswordValidationIssue,
                   (_) => null,
                 );
             if (message != null) {
               return message;
             }
             return validatorOverride?.call(value);
           },
           onChanged: onChanged,
           prefixIcon: Icons.lock,
         ),
       );

  @override
  Widget build(BuildContext context) {
    return GObscurableTextFormField(config: config);
  }
}
