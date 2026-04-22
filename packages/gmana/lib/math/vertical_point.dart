import 'dart:math';

/// Computes a vertical point on a sine wave for spinner and animation math.
double verticalPoint({
  required double value,
  required double verticalShift,
  required double amplitude,
  required double phaseShift,
  required double waveLength,
}) {
  final period = 2 * pi / waveLength;
  return amplitude * sin(period * (value + phaseShift)) + verticalShift;
}
