import 'package:flutter/material.dart';

import 'dot_animation_config.dart';

/// A single animated dot for the GWaveDotSpinner widget.
class GWaveDotSpinnerDot extends StatelessWidget {
  /// Animation intervals and size limits for this dot.
  final DotAnimationConfig config;

  /// Base spinner size used to derive the dot size.
  final double size;

  /// Dot color.
  final Color color;

  /// Shared spinner animation controller.
  final AnimationController controller;

  const GWaveDotSpinnerDot({
    super.key,
    required this.config,
    required this.size,
    required this.color,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final dotSize = size * 0.13;

    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        final isForward = controller.value <= config.offsetInterval.end;
        final offsetTween = Tween<Offset>(
          begin: isForward ? Offset.zero : Offset(0, config.maxOffset),
          end: isForward ? Offset(0, config.maxOffset) : Offset.zero,
        );
        final heightTween = Tween<double>(
          begin: isForward ? dotSize : config.maxHeight,
          end: isForward ? config.maxHeight : dotSize,
        );

        return Transform.translate(
          offset:
              offsetTween
                  .animate(
                    CurvedAnimation(
                      parent: controller,
                      curve: isForward ? config.offsetInterval : config.reverseOffsetInterval,
                    ),
                  )
                  .value,
          child: Container(
            width: dotSize,
            height:
                heightTween
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: isForward ? config.heightInterval : config.reverseHeightInterval,
                      ),
                    )
                    .value,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(dotSize / 2)),
          ),
        );
      },
    );
  }
}
