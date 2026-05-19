import 'package:flutter/material.dart';
import 'package:gmana_flutter_extensions/gmana_flutter_extensions.dart';

class DetailsPanel extends StatelessWidget {
  const DetailsPanel({
    super.key,
    required this.baseColor,
    required this.restoredIcon,
  });

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
            DetailRow('RGB hex', baseColor.toHexRGB()),
            DetailRow('ARGB hex', baseColor.toHexARGB()),
            DetailRow(
              'Meets WCAG AA on white',
              '${baseColor.meetsWcagAA(Colors.white)}',
            ),
            DetailRow(
              'Contrast ratio on white',
              contrastRatio.toStringAsFixed(2),
            ),
            DetailRow('Theme key', 'dark'.toThemeMode().toLabel()),
            Row(
              children: [
                const Text('Restored icon'),
                const SizedBox(width: 12),
                Icon(restoredIcon),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  const DetailRow(this.label, this.value, {super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: context.textTheme.labelLarge),
        ],
      ),
    );
  }
}
