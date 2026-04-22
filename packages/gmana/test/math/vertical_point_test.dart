import 'package:gmana/math/vertical_point.dart';
import 'package:test/test.dart';

void main() {
  test('verticalPoint computes the expected wave position', () {
    expect(
      verticalPoint(
        value: 0,
        verticalShift: 10,
        amplitude: 5,
        phaseShift: 0,
        waveLength: 20,
      ),
      closeTo(10, 0.000001),
    );
  });
}
