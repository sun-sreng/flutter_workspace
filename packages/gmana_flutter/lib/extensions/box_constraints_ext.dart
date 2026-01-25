import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension BreakpointUtils on BoxConstraints {
  bool get isDesktop => maxWidth > 1200;
  bool get isMobile => !isTablet && !isDesktop;
  bool get isTablet => maxWidth > 730;

  BoxConstraints tightenMaxSize(Size? size) {
    if (size == null) return this;
    return copyWith(
      maxWidth: clampDouble(size.width, minWidth, maxWidth),
      maxHeight: clampDouble(size.height, minHeight, maxHeight),
    );
  }
}
