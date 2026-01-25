import 'dart:math' show sin, pi;

import 'package:flutter/material.dart';

/// A tween that applies a delay to an animation curve, suitable for staggered effects.
class DelayedAnimationTween extends Tween<double> {
  final double delay;
  final Curve curve;

  DelayedAnimationTween({
    super.begin = 0.0,
    super.end = 1.0,
    required this.delay,
    this.curve = Curves.easeInOut,
  });

  @override
  double lerp(double t) {
    // Apply the delay and transform the input using a sine wave for smooth pulsing
    final adjustedT = (sin((t - delay) * 2 * pi) + 1) / 2;
    return super.lerp(curve.transform(adjustedT));
  }
}
