import 'dart:async';

import 'package:gmana/utilities.dart';
import 'package:test/test.dart';

void main() {
  test('Throttler suppresses calls during the cooldown window', () async {
    final throttle = Throttler(milliseconds: 20);
    var count = 0;

    throttle.run(() => count += 1);
    throttle.run(() => count += 10);

    await Future<void>.delayed(const Duration(milliseconds: 30));
    throttle.run(() => count += 100);

    expect(count, 101);
    throttle.dispose();
  });

  test('Throttler validates delay', () {
    expect(() => Throttler(milliseconds: 0), throwsArgumentError);
    expect(() => Throttler(milliseconds: -1), throwsArgumentError);
  });
}
