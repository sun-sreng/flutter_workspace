import 'package:flutter/material.dart';

import '../controllers/form_controller.dart';

/// Thin wrapper around Flutter's [Form] that uses a [GFormController].
class GForm extends StatelessWidget {
  final GFormController controller;
  final Widget child;
  final AutovalidateMode? autovalidateMode;
  final bool canPop;
  final PopInvokedWithResultCallback<Object?>? onPopInvokedWithResult;
  final void Function()? onChanged;

  const GForm({
    super.key,
    required this.controller,
    required this.child,
    this.autovalidateMode,
    this.canPop = true,
    this.onPopInvokedWithResult,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.key,
      autovalidateMode: autovalidateMode,
      canPop: canPop,
      onPopInvokedWithResult: onPopInvokedWithResult,
      onChanged: onChanged,
      child: child,
    );
  }
}
