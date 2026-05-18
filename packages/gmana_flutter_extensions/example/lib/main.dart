import 'package:flutter/material.dart';
import 'package:gmana_flutter_extensions/gmana_flutter_extensions.dart';

void main() {
  runApp(const ExtensionsExampleApp());
}

class ExtensionsExampleApp extends StatefulWidget {
  const ExtensionsExampleApp({super.key});

  @override
  State<ExtensionsExampleApp> createState() => _ExtensionsExampleAppState();
}

class _ExtensionsExampleAppState extends State<ExtensionsExampleApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: '#3B82F6'.toColor())),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: '#3B82F6'.toColor(), brightness: Brightness.dark),
      ),
      home: ExampleHome(themeMode: _themeMode, onThemeModeChanged: (mode) => setState(() => _themeMode = mode)),
    );
  }
}

class ExampleHome extends StatelessWidget {
  const ExampleHome({required this.themeMode, required this.onThemeModeChanged, super.key});

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    final color = '#FF5500'.toColor();
    final swatches = [
      _ColorSwatch('Base', color),
      _ColorSwatch('Tint', color.tint(0.35)),
      _ColorSwatch('Shade', color.shade(0.35)),
      _ColorSwatch('Complement', color.complementary),
      _ColorSwatch('Greyscale', color.greyscale),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('gmana_flutter_extensions'),
        actions: [
          IconButton(
            tooltip: themeMode.toLabel(),
            icon: Icon(themeMode.toIcon()),
            onPressed: () => onThemeModeChanged(_nextThemeMode(themeMode)),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.resolve(mobile: 1, tablet: 2, desktop: 3, widescreen: 4);

          return ListView(
            padding: EdgeInsets.all(context.responsive(mobile: 16, tablet: 24)),
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _InfoChip(icon: Icons.devices, label: constraints.breakpoint.name),
                  _InfoChip(
                    icon: Icons.aspect_ratio,
                    label:
                        '${context.screenWidth.round()} x '
                        '${context.screenHeight.round()}',
                  ),
                  _InfoChip(icon: Icons.schedule, label: const TimeOfDay(hour: 13, minute: 5).toCustomString()),
                  _InfoChip(icon: themeMode.toIcon(), label: themeMode.toLabel()),
                ],
              ),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.6,
                ),
                itemCount: swatches.length,
                itemBuilder: (context, index) {
                  final swatch = swatches[index];
                  return _ColorCard(label: swatch.label, color: swatch.color);
                },
              ),
              const SizedBox(height: 24),
              _DetailsPanel(baseColor: color, restoredIcon: IconDataExt.parse(Icons.home.toJsonString())),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: () {
                      context.showSuccessSnackBar(message: 'Shown with BuildContext.showSuccessSnackBar');
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Success'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      context.showWarningSnackBar(message: 'This uses the warning snackbar helper');
                    },
                    icon: const Icon(Icons.warning_amber),
                    label: const Text('Warning'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

ThemeMode _nextThemeMode(ThemeMode current) {
  return switch (current) {
    ThemeMode.system => ThemeMode.light,
    ThemeMode.light => ThemeMode.dark,
    ThemeMode.dark => ThemeMode.system,
  };
}

class _ColorSwatch {
  const _ColorSwatch(this.label, this.color);

  final String label;
  final Color color;
}

class _ColorCard extends StatelessWidget {
  const _ColorCard({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DefaultTextStyle(
          style: context.textTheme.titleMedium!.copyWith(color: color.contrastText, fontWeight: FontWeight.w700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(
                color.toHexRGB(),
                style: context.textTheme.bodyMedium!.copyWith(color: color.contrastText.withAlphaOpacity(0.84)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailsPanel extends StatelessWidget {
  const _DetailsPanel({required this.baseColor, required this.restoredIcon});

  final Color baseColor;
  final IconData restoredIcon;

  @override
  Widget build(BuildContext context) {
    final contrastRatio = baseColor.contrastRatio(Colors.white);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Utilities', style: context.textTheme.titleLarge),
            const SizedBox(height: 12),
            _DetailRow('RGB hex', baseColor.toHexRGB()),
            _DetailRow('ARGB hex', baseColor.toHexARGB()),
            _DetailRow('Meets WCAG AA on white', '${baseColor.meetsWcagAA(Colors.white)}'),
            _DetailRow('Contrast ratio on white', contrastRatio.toStringAsFixed(2)),
            _DetailRow('Theme key', 'dark'.toThemeMode().toLabel()),
            Row(children: [const Text('Restored icon'), const SizedBox(width: 12), Icon(restoredIcon)]),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [Expanded(child: Text(label)), Text(value, style: context.textTheme.labelLarge)]),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(avatar: Icon(icon, size: 18), label: Text(label), visualDensity: VisualDensity.compact);
  }
}
