import 'dart:async';

import 'package:flutter/material.dart';

/// Coordinates a Flutter [Form] and named text controllers.
///
/// This is intentionally small: it handles the repetitive form key,
/// validate/save/reset flow, and controller disposal for forms that do not need
/// a larger state-management solution.
final class GFormController extends ChangeNotifier {
  final GlobalKey<FormState> key;
  final Map<String, TextEditingController> _textControllers = {};
  bool _submitting = false;

  GFormController({GlobalKey<FormState>? key})
    : key = key ?? GlobalKey<FormState>();

  FormState? get state => key.currentState;

  bool get submitting => _submitting;

  TextEditingController textController(String name, {String? text}) {
    return _textControllers.putIfAbsent(
      name,
      () => TextEditingController(text: text),
    );
  }

  String text(String name) => textController(name).text;

  Map<String, String> textValues() {
    return {
      for (final entry in _textControllers.entries) entry.key: entry.value.text,
    };
  }

  bool validate() => state?.validate() ?? false;

  void save() => state?.save();

  void reset() {
    state?.reset();
    for (final controller in _textControllers.values) {
      controller.clear();
    }
  }

  bool validateAndSave() {
    if (!validate()) {
      return false;
    }
    save();
    return true;
  }

  Future<bool> submit(
    FutureOr<void> Function(Map<String, String> values) onSubmit, {
    bool resetOnSuccess = false,
  }) async {
    if (_submitting || !validateAndSave()) {
      return false;
    }

    _setSubmitting(true);
    try {
      await onSubmit(textValues());
      if (resetOnSuccess) {
        reset();
      }
      return true;
    } finally {
      _setSubmitting(false);
    }
  }

  @override
  void dispose() {
    for (final controller in _textControllers.values) {
      controller.dispose();
    }
    _textControllers.clear();
    super.dispose();
  }

  void _setSubmitting(bool value) {
    if (_submitting == value) {
      return;
    }
    _submitting = value;
    notifyListeners();
  }
}
