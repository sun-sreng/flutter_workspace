import 'package:gmana_extensions/gmana_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('DurationNaturalLanguageX', () {
    test('formats compact strings', () {
      expect(const Duration(hours: 2, minutes: 3).toCompactString(), '2h 3m');
      expect(const Duration(seconds: 45).toCompactString(), '45s');
      expect(Duration.zero.toCompactString(), '0s');
    });

    test('formats natural strings', () {
      expect(
        const Duration(hours: 2, minutes: 3).toNaturalString(),
        '2 hours 3 minutes',
      );
      expect(
        const Duration(minutes: 1, seconds: 5).toNaturalString(),
        '1 minute 5 seconds',
      );
      expect(Duration.zero.toNaturalString(), '0 seconds');
    });

    test('formats detailed strings with milliseconds', () {
      expect(
        const Duration(minutes: 1, milliseconds: 500).toDetailedString(),
        '1m 0s 500ms',
      );
      expect(
        const Duration(hours: 1, minutes: 2).toDetailedString(),
        '1h 2m 0s',
      );
    });

    // toClockString was removed — use HumanizedDuration.toHumanizedString instead
    test('clock format via HumanizedDuration', () {
      expect(
        const Duration(hours: 1, minutes: 3, seconds: 7).toHumanizedString(),
        '1:03:07',
      );
      expect(
        const Duration(minutes: 4, seconds: 2).toHumanizedString(),
        '4:02',
      );
    });
  });
}
