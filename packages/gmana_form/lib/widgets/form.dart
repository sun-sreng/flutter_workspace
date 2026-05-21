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
    return _GFormScope(
      controller: controller,
      child: Form(
        key: controller.key,
        autovalidateMode: autovalidateMode,
        canPop: canPop,
        onPopInvokedWithResult: onPopInvokedWithResult,
        onChanged: onChanged,
        child: child,
      ),
    );
  }

  static GFormController? maybeControllerOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_GFormScope>()
        ?.controller;
  }

  static GFormController controllerOf(BuildContext context) {
    final controller = maybeControllerOf(context);
    if (controller == null) {
      throw FlutterError(
        'No GForm found in context. '
        'Wrap named gmana_form fields with GForm or pass a controller directly.',
      );
    }
    return controller;
  }
}

class _GFormScope extends InheritedWidget {
  final GFormController controller;

  const _GFormScope({required this.controller, required super.child});

  @override
  bool updateShouldNotify(_GFormScope oldWidget) {
    return controller != oldWidget.controller;
  }
}
