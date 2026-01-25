import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/field_config.dart';
import '../widgets/visibility_toggle.dart';
import 'base_field.dart';

class GPasswordField extends GBaseField {
  GPasswordField({
    super.key,
    required TextEditingController controller,
    String labelText = 'Password',
    String? hintText,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) : super(
         config: GFieldConfig(
           controller: controller,
           labelText: labelText,
           hintText: hintText ?? 'Enter your password',
           keyboardType: TextInputType.visiblePassword,
           textInputAction: textInputAction ?? TextInputAction.done,
           inputFormatters: inputFormatters,
           validator: validator,
           onChanged: onChanged,
           prefixIcon: Icons.lock,
         ),
       );

  @override
  Widget build(BuildContext context) {
    return _GPasswordFieldContent(config: config);
  }
}

class _GPasswordFieldContent extends StatefulWidget {
  final GFieldConfig config;

  const _GPasswordFieldContent({required this.config});

  @override
  State<_GPasswordFieldContent> createState() => _GPasswordFieldContentState();
}

class _GPasswordFieldContentState extends State<_GPasswordFieldContent> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.config.controller,
      obscureText: _obscureText,
      keyboardType: widget.config.keyboardType,
      textInputAction: widget.config.textInputAction,
      inputFormatters: widget.config.inputFormatters,
      validator: widget.config.validator,
      onChanged: widget.config.onChanged,
      decoration: InputDecoration(
        labelText: widget.config.labelText,
        hintText: widget.config.hintText,
        prefixIcon: Icon(widget.config.prefixIcon),
        suffixIcon: VisibilityToggle(
          onVisibilityChanged:
              (obscure) => setState(() => _obscureText = obscure),
        ),
      ),
    );
  }
}
