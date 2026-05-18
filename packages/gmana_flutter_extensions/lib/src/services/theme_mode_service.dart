import 'package:flutter/material.dart';

class ThemeModeService {
  static const Map<ThemeMode, _ThemeModeConfig> _themeConfigs = {
    ThemeMode.system: _ThemeModeConfig(key: 'system', label: 'System Mode', icon: Icons.brightness_6),
    ThemeMode.light: _ThemeModeConfig(key: 'light', label: 'Light Mode', icon: Icons.light_mode),
    ThemeMode.dark: _ThemeModeConfig(key: 'dark', label: 'Dark Mode', icon: Icons.dark_mode),
  };

  const ThemeModeService();

  ThemeMode fromKey(String key) =>
      _themeConfigs.entries
          .firstWhere(
            (entry) => entry.value.key == key,
            orElse:
                () => const MapEntry(
                  ThemeMode.system,
                  _ThemeModeConfig(key: 'system', label: 'System Mode', icon: Icons.brightness_6),
                ),
          )
          .key;

  IconData getIcon(ThemeMode mode) => _themeConfigs[mode]?.icon ?? Icons.brightness_6;

  IconData getIconFromKey(String key) => _themeConfigs[fromKey(key)]?.icon ?? Icons.brightness_6;

  String getKey(ThemeMode mode) => _themeConfigs[mode]?.key ?? 'system';

  String getLabel(ThemeMode mode) => _themeConfigs[mode]?.label ?? 'System Mode';

  String getLabelFromKey(String key) => _themeConfigs[fromKey(key)]?.label ?? 'System Mode';

  List<String> getThemeKeys() => _themeConfigs.values.map((config) => config.key).toList();
}

class _ThemeModeConfig {
  final String key;
  final String label;
  final IconData icon;

  const _ThemeModeConfig({required this.key, required this.label, required this.icon});
}
