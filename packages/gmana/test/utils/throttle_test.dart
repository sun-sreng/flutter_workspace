import 'dart:async';

import 'package:gmana/utils/throttle.dart';
import 'package:test/test.dart';

void main() {
  test('Throttle suppresses calls during the cooldown window', () async {
    final throttle = Throttle(milliseconds: 20);
    var count = 0;

    throttle.run(() => count += 1);
    throttle.run(() => count += 10);

    await Future<void>.delayed(const Duration(milliseconds: 30));
    throttle.run(() => count += 100);

    expect(count, 101);
    throttle.dispose();
  });
}
