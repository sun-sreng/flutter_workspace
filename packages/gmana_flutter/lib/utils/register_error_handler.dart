import 'dart:ui';

import 'package:flutter/material.dart';

void registerErrorHandlers({
  void Function(FlutterErrorDetails details)? onFlutterError,
  ErrorWidgetBuilder? errorWidgetBuilder,
  bool presentFlutterErrors = true,
  bool handlePlatformErrors = true,
  bool Function(Object error, StackTrace stack)? onPlatformError,
}) {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (presentFlutterErrors) {
      FlutterError.presentError(details);
    }
    if (onFlutterError != null) {
      onFlutterError(details);
    } else {
      debugPrint(details.toString());
    }
  };

  if (handlePlatformErrors) {
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      if (onPlatformError != null) {
        return onPlatformError(error, stack);
      }
      debugPrint(error.toString());
      return true;
    };
  }

  if (errorWidgetBuilder != null) {
    ErrorWidget.builder = errorWidgetBuilder;
  }
}
