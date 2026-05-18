import 'package:flutter/material.dart';

import '../services/theme_mode_service.dart';

extension ThemeModeExt on ThemeMode {
  IconData toIcon() => const ThemeModeService().getIcon(this);

  String toLabel() => const ThemeModeService().getLabel(this);
}

extension ThemeModeStringExt on String {
  IconData toThemeIcon() => const ThemeModeService().getIconFromKey(this);

  String toThemeLabel() => const ThemeModeService().getLabelFromKey(this);

  ThemeMode toThemeMode() => const ThemeModeService().fromKey(this);
}
