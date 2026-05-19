import 'package:flutter/material.dart';
import 'package:gmana_flutter/gmana_flutter.dart';

class BackgroundGlow extends StatelessWidget {
  const BackgroundGlow({super.key, required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withAlpha(0)]),
        ),
      ),
    );
  }
}

class SliderField extends StatelessWidget {
  const SliderField({
    super.key,
    required this.title,
    required this.valueLabel,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String valueLabel;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: theme.textTheme.labelLarge)),
            Text(valueLabel, style: theme.textTheme.bodySmall),
          ],
        ),
        Slider(
          value: value,
          onChanged: onChanged,
          min: 0,
          max: 1,
          divisions: 100,
        ),
      ],
    );
  }
}

class PaletteChip extends StatelessWidget {
  const PaletteChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 132,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(36),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          const SizedBox(height: 10),
          Text(label, style: theme.textTheme.labelLarge),
          const SizedBox(height: 2),
          Text(color.toHexRGB(), style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  const StatTile({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.onSurface.withAlpha(8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
