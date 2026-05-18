import 'package:flutter/material.dart';

import '../models/field_config.dart';

class GConfiguredTextFormField extends StatelessWidget {
  const GConfiguredTextFormField({
    super.key,
    required this.config,
    this.obscureText = false,
    this.suffixIcon,
  });

  final GFieldConfig config;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: config.controller,
      focusNode: config.focusNode,
      obscureText: obscureText,
      keyboardType: config.keyboardType,
      textInputAction: config.textInputAction,
      inputFormatters: config.inputFormatters,
      validator: config.validator,
      onChanged: config.onChanged,
      onFieldSubmitted: config.onFieldSubmitted,
      onSaved: config.onSaved,
      autovalidateMode: config.autovalidateMode,
      enabled: config.enabled,
      readOnly: config.readOnly,
      minLines: config.minLines,
      maxLines: obscureText ? 1 : config.maxLines,
      maxLength: config.maxLength,
      textCapitalization: config.textCapitalization,
      textAlign: config.textAlign,
      style: config.style,
      decoration: (config.decoration ?? const InputDecoration()).copyWith(
        labelText: config.decoration?.labelText ?? config.labelText,
        hintText: config.decoration?.hintText ?? config.hintText,
        prefixIcon:
            config.decoration?.prefixIcon ??
            (config.prefixIcon != null ? Icon(config.prefixIcon) : null),
        suffixIcon: config.decoration?.suffixIcon ?? suffixIcon,
      ),
    );
  }
}
