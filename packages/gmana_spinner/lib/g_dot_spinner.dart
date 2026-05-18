import 'package:flutter/material.dart';

import 'delayed_animation_tween.dart';

/// A customizable loading spinner with animated scaling dots.
///
/// Example:
/// ```dart
/// GDotSpinner(
///   size: 50.0,
///   color: Colors.blue,
///   dotCount: 3,
///   duration: Duration(milliseconds: 1200),
/// )
/// ```
class GDotSpinner extends StatefulWidget {
  /// Dot color. Defaults to the active theme primary color.
  final Color? color;

  /// Height of the spinner. Individual dots use half this size.
  final double size;

  /// Number of animated dots.
  final int dotCount;

  /// Optional builder for custom dot widgets.
  final IndexedWidgetBuilder? itemBuilder;

  /// Duration for one full animation cycle.
  final Duration duration;

  /// Optional external controller.
  ///
  /// When provided, the caller owns disposal.
  final AnimationController? controller;

  const GDotSpinner({
    super.key,
    this.color,
    this.size = 50.0,
    this.dotCount = 3,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  }) : assert(itemBuilder == null || color == null, 'Provide either itemBuilder or color, but not both.'),
       assert(size > 0, 'size must be greater than zero.'),
       assert(dotCount > 0, 'dotCount must be greater than zero.');

  @override
  State<GDotSpinner> createState() => _GDotSpinnerState();
}

class _GDotSpinnerState extends State<GDotSpinner> with SingleTickerProviderStateMixin {
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
              scale: DelayedAnimationTween(delay: index / widget.dotCount).animate(_controller),
              child: SizedBox(width: widget.size * 0.5, height: widget.size * 0.5, child: _buildDot(index)),
            );
          }),
        ),
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
    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))..repeat();
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
