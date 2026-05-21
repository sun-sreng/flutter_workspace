import 'package:flutter/material.dart';

/// Coordinates a Flutter [Form] and named text controllers.
///
/// This is intentionally small: it handles the repetitive form key,
/// validate/save/reset flow, and controller disposal for forms that do not need
/// a larger state-management solution.
final class GFormController {
  final GlobalKey<FormState> key;
  final Map<String, TextEditingController> _textControllers = {};

  GFormController({GlobalKey<FormState>? key})
    : key = key ?? GlobalKey<FormState>();

  FormState? get state => key.currentState;

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

  void dispose() {
    for (final controller in _textControllers.values) {
      controller.dispose();
    }
    _textControllers.clear();
  }
}
