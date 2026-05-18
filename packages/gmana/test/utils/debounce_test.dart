import 'dart:async';

import 'package:gmana/utilities.dart';
import 'package:test/test.dart';

void main() {
  test('Debouncer runs only the latest action', () async {
    final debounce = Debouncer(milliseconds: 20);
    var count = 0;

    debounce.run(() => count += 1);
    debounce.run(() => count += 10);

    await Future<void>.delayed(const Duration(milliseconds: 40));

    expect(count, 10);
    debounce.dispose();
  });

  test('Debouncer validates delay', () {
    expect(() => Debouncer(milliseconds: 0), throwsArgumentError);
    expect(() => Debouncer(milliseconds: -1), throwsArgumentError);
  });
}
