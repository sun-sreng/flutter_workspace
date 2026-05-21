import 'package:flutter/material.dart';
import 'package:gmana_spinner/gmana_spinner.dart';

/// Production-friendly submit button with a loading state.
class GSubmitButton extends StatelessWidget {
  final bool loading;
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final Color loadingColor;
  final double loadingSize;

  const GSubmitButton({
    super.key,
    required this.loading,
    required this.onPressed,
    required this.child,
    this.style,
    this.loadingColor = Colors.white,
    this.loadingSize = 24.0,
  });

  factory GSubmitButton.text({
    Key? key,
    required String label,
    required bool loading,
    required VoidCallback? onPressed,
    TextStyle? textStyle,
    ButtonStyle? style,
    Color loadingColor = Colors.white,
    double loadingSize = 24.0,
  }) {
    return GSubmitButton(
      key: key,
      loading: loading,
      onPressed: onPressed,
      style: style,
      loadingColor: loadingColor,
      loadingSize: loadingSize,
      child: Text(label, style: textStyle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style,
      onPressed: loading ? null : onPressed,
      child:
          loading
              ? GWaveDotSpinner(size: loadingSize, color: loadingColor)
              : child,
    );
  }
}

/// Backward-compatible alias for the original loading elevated button.
class GElevatedButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color loadingColor;
  final double loadingSize;

  const GElevatedButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.loadingColor = Colors.white,
    this.loadingSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return GSubmitButton.text(
      loading: isLoading,
      onPressed: onPressed,
      label: text,
      textStyle: textStyle,
      loadingColor: loadingColor,
      loadingSize: loadingSize,
    );
  }
}
