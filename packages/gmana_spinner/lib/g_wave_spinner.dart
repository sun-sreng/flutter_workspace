import 'dart:math';

import 'package:flutter/material.dart';

import 'wave_spinner_painter.dart';

/// A circular spinner with an optional animated wave fill.
class GWaveSpinner extends StatefulWidget {
  /// Active arc color.
  final Color color;

  /// Background arc color.
  final Color trackColor;

  /// Fill wave color.
  final Color waveColor;

  /// Maximum width and height.
  final double size;

  /// Duration for one full animation cycle.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  /// Optional centered child.
  final Widget? child;

  /// Optional external controller.
  ///
  /// When provided, the caller owns disposal.
  final AnimationController? controller;

  const GWaveSpinner({
    super.key,
    required this.color,
    this.trackColor = const Color(0x68757575),
    this.waveColor = const Color(0x68757575),
    this.size = 50,
    this.duration = const Duration(milliseconds: 3000),
    this.curve = Curves.decelerate,
    this.child,
    this.controller,
  }) : assert(size > 0, 'size must be greater than zero.');

  @override
  State<GWaveSpinner> createState() => _GWaveSpinnerState();
}

class _GWaveSpinnerState extends State<GWaveSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size.square(
          min(min(constraints.maxWidth, constraints.maxHeight), widget.size),
        );
        final childMaxSize = Size.square(widget.size * 0.7);
        return SizedBox.fromSize(
          size: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: size,
                painter: WaveSpinnerPainter(
                  size: size,
                  color: widget.color,
                  trackColor: widget.trackColor,
                  waveColor: widget.waveColor,
                  curve: widget.curve,
                  hasChild: widget.child != null,
                  controller: _controller,
                ),
              ),
              if (widget.child != null)
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(childMaxSize),
                    child: widget.child,
                  ),
                ),
            ],
          ),
        );
      },
    );
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
              AnimationController(duration: widget.duration, vsync: this))
          ..repeat();
  }
}
