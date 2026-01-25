import 'package:flutter/material.dart';

import '../services/theme_mode_service.dart';

/// Extension on ThemeMode for theme-related utilities.
extension ThemeModeExt on ThemeMode {
  /// Returns the icon for this ThemeMode.
  IconData toIcon() => ThemeModeService().getIcon(this);

  /// Returns the display label for this ThemeMode.
  String toLabel() => ThemeModeService().getLabel(this);
}

/// Extension on String for theme-related utilities.
extension ThemeModeStringExt on String {
  /// Converts a string key to a theme icon.
  IconData toThemeIcon() => ThemeModeService().getIconFromKey(this);

  /// Converts a string key to a theme display label.
  String toThemeLabel() => ThemeModeService().getLabelFromKey(this);

  /// Converts a string key to a ThemeMode.
  ThemeMode toThemeMode() => ThemeModeService().fromKey(this);
}
