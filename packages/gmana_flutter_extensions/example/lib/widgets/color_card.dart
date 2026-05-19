import 'package:flutter/material.dart';
import 'package:gmana_flutter_extensions/gmana_flutter_extensions.dart';

class ColorCard extends StatelessWidget {
  const ColorCard({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DefaultTextStyle(
          style: context.textTheme.titleMedium!.copyWith(
            color: color.contrastText,
            fontWeight: FontWeight.w700,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(
                color.toHexRGB(),
                style: context.textTheme.bodyMedium!.copyWith(
                  color: color.contrastText.withAlphaOpacity(0.84),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
