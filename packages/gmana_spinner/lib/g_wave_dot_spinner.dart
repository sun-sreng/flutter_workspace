import 'package:flutter/material.dart';

import 'dot_animation_config.dart';
import 'g_wave_dot_spinner_dot.dart';

/// A customizable loading spinner with a wave-like animation of scaling dots.
///
/// Example:
/// ```dart
/// GWaveDotSpinner(
///   size: 50.0,
///   color: Colors.blue,
///   dotCount: 5,
/// )
/// ```
class GWaveDotSpinner extends StatefulWidget {
  /// Width and height of the spinner.
  final double size;

  /// Dot color. Defaults to the active theme primary color.
  final Color? color;

  /// Number of dots in the wave.
  final int dotCount;

  /// Duration for one full animation cycle.
  final Duration duration;

  /// Optional external controller.
  ///
  /// When provided, the caller owns disposal.
  final AnimationController? controller;

  const GWaveDotSpinner({
    super.key,
    required this.size,
    this.color,
    this.dotCount = 5,
    this.duration = const Duration(milliseconds: 1600),
    this.controller,
  }) : assert(size > 0, 'size must be greater than zero.'),
       assert(dotCount > 0, 'dotCount must be greater than zero.');

  @override
  State<GWaveDotSpinner> createState() => _GWaveDotSpinnerState();
}

class _GWaveDotSpinnerState extends State<GWaveDotSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(widget.dotCount, (index) {
          return GWaveDotSpinnerDot(
            config: DotAnimationConfig.forIndex(
              index: index,
              dotCount: widget.dotCount,
              baseSize: widget.size,
              isEven: index % 2 == 1,
            ),
            size: widget.size,
            color: widget.color ?? Theme.of(context).colorScheme.primary,
            controller: _controller,
          );
        }),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!TickerMode.valuesOf(context).enabled) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        (widget.controller ??
              AnimationController(vsync: this, duration: widget.duration))
          ..repeat();
  }
}
