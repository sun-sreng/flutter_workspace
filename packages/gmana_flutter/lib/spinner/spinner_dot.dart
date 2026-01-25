import 'package:flutter/material.dart';

import 'models/delayed_animation_tween.dart';

/// A customizable loading spinner with animated scaling dots.
///
/// Example:
/// ```dart
/// GSpinnerDot(
///   size: 50.0,
///   color: Colors.blue,
///   dotCount: 3,
///   duration: Duration(milliseconds: 1200),
/// )
/// ```
class GSpinnerDot extends StatefulWidget {
  final Color? color;
  final double size;
  final int dotCount;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  const GSpinnerDot({
    super.key,
    this.color,
    this.size = 50.0,
    this.dotCount = 3,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  }) : assert(
         !(itemBuilder != null && color != null) &&
             (itemBuilder != null || color != null),
         'Provide either itemBuilder or color, but not both.',
       );

  @override
  State<GSpinnerDot> createState() => _GSpinnerDotState();
}

class _GSpinnerDotState extends State<GSpinnerDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size * 2,
        height: widget.size,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.dotCount, (index) {
            return ScaleTransition(
              scale: DelayedAnimationTween(
                delay: index / widget.dotCount,
              ).animate(_controller),
              child: SizedBox(
                width: widget.size * 0.5,
                height: widget.size * 0.5,
                child: _buildDot(index),
              ),
            );
          }),
        ),
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

  Widget _buildDot(int index) {
    return widget.itemBuilder != null
        ? widget.itemBuilder!(context, index)
        : DecoratedBox(
          decoration: BoxDecoration(
            color: widget.color ?? Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
        );
  }
}
