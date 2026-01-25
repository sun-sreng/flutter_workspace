import 'package:flutter/material.dart';

/// Domain layer service for theme mode configurations.
class ThemeModeService {
  /// Singleton instance for accessing theme configurations.
  static const ThemeModeService _instance = ThemeModeService._internal();

  /// Map of theme modes to their configurations.
  static const Map<ThemeMode, _ThemeModeConfig> _themeConfigs = {
    ThemeMode.system: _ThemeModeConfig(
      key: 'system',
      label: 'System Mode',
      icon: Icons.brightness_6,
    ),
    ThemeMode.light: _ThemeModeConfig(
      key: 'light',
      label: 'Light Mode',
      icon: Icons.light_mode,
    ),
    ThemeMode.dark: _ThemeModeConfig(
      key: 'dark',
      label: 'Dark Mode',
      icon: Icons.dark_mode,
    ),
  };
  factory ThemeModeService() => _instance;

  const ThemeModeService._internal();

  /// Converts a string key to a ThemeMode.
  ThemeMode fromKey(String key) =>
      _themeConfigs.entries
          .firstWhere(
            (entry) => entry.value.key == key,
            orElse:
                () => const MapEntry(
                  ThemeMode.system,
                  _ThemeModeConfig(
                    key: 'system',
                    label: 'System Mode',
                    icon: Icons.brightness_6,
                  ),
                ),
          )
          .key;

  /// Converts a ThemeMode to its icon.
  IconData getIcon(ThemeMode mode) =>
      _themeConfigs[mode]?.icon ?? Icons.brightness_6;

  /// Converts a string key to its icon.
  IconData getIconFromKey(String key) =>
      _themeConfigs[fromKey(key)]?.icon ?? Icons.brightness_6;

  /// Converts a ThemeMode to its key (e.g., ThemeMode.system -> 'system').
  String getKey(ThemeMode mode) => _themeConfigs[mode]?.key ?? 'system';

  /// Converts a ThemeMode to its display label.
  String getLabel(ThemeMode mode) =>
      _themeConfigs[mode]?.label ?? 'System Mode';

  /// Converts a string key to its display label.
  String getLabelFromKey(String key) =>
      _themeConfigs[fromKey(key)]?.label ?? 'System Mode';

  /// Returns the list of theme keys (e.g., ['system', 'light', 'dark']).
  List<String> getThemeKeys() =>
      _themeConfigs.values.map((config) => config.key).toList();
}

/// Data class for theme mode configuration.
class _ThemeModeConfig {
  final String key;
  final String label;
  final IconData icon;

  const _ThemeModeConfig({
    required this.key,
    required this.label,
    required this.icon,
  });
}
