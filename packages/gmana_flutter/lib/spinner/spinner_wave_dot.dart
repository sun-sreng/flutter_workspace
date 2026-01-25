import 'package:flutter/material.dart';

import 'dot_container.dart';
import 'models/dot_animation_config.dart';

/// A customizable loading spinner with a wave-like animation of scaling dots.
///
/// Example:
/// ```dart
/// SpinnerWaveDot(
///   size: 50.0,
///   color: Colors.blue,
///   dotCount: 5,
/// )
/// ```
class SpinnerWaveDot extends StatefulWidget {
  final double size;
  final Color color;
  final int dotCount;
  final Duration duration;

  const SpinnerWaveDot({
    super.key,
    required this.size,
    required this.color,
    this.dotCount = 5,
    this.duration = const Duration(milliseconds: 1600),
  });

  @override
  State<SpinnerWaveDot> createState() => _SpinnerWaveDotState();
}

class _SpinnerWaveDotState extends State<SpinnerWaveDot>
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
          return DotContainer(
            config: DotAnimationConfig.forIndex(
              index: index,
              dotCount: widget.dotCount,
              baseSize: widget.size,
              isEven: index % 2 == 1,
            ),
            size: widget.size,
            color: widget.color,
            controller: _controller,
          );
        }),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pause animation if widget is not visible
    if (!mounted || !context.mounted) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }
}
