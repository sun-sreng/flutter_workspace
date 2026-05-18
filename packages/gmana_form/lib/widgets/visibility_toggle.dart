import 'package:flutter/material.dart';

/// Reusable widget for toggling password visibility.
class VisibilityToggle extends StatefulWidget {
  final ValueChanged<bool>? onVisibilityChanged;

  const VisibilityToggle({super.key, this.onVisibilityChanged});

  @override
  State<VisibilityToggle> createState() => _VisibilityToggleState();
}

class _VisibilityToggleState extends State<VisibilityToggle> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
          widget.onVisibilityChanged?.call(_obscureText);
        });
      },
    );
  }
}
