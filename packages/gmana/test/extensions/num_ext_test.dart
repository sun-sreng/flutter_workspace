import 'package:gmana/extensions/num_ext.dart';
import 'package:test/test.dart';

void main() {
  group('IntNullableX', () {
    test('orZero', () {
      expect((null as int?).orZero, equals(0));
      expect(5.orZero, equals(5));
    });

    test('orDefault', () {
      expect((null as int?).orDefault(10), equals(10));
      expect(5.orDefault(10), equals(5));
    });

    test('isNullOrZero', () {
      expect((null as int?).isNullOrZero, isTrue);
      expect(0.isNullOrZero, isTrue);
      expect(5.isNullOrZero, isFalse);
    });
  });

  group('DoubleNullableX', () {
    test('orZero', () {
      expect((null as double?).orZero, equals(0.0));
      expect(5.5.orZero, equals(5.5));
    });

    test('orDefault', () {
      expect((null as double?).orDefault(10.5), equals(10.5));
      expect(5.5.orDefault(10.5), equals(5.5));
    });

    test('isNullOrZero', () {
      expect((null as double?).isNullOrZero, isTrue);
      expect(0.0.isNullOrZero, isTrue);
      expect(5.5.isNullOrZero, isFalse);
    });
  });

  group('NumNullableX', () {
    test('orZero', () {
      expect((null as num?).orZero, equals(0));
      expect(5.orZero, equals(5));
      expect(5.5.orZero, equals(5.5));
    });

    test('orDefault', () {
      expect((null as num?).orDefault(10), equals(10));
      expect(5.orDefault(10), equals(5));
      expect(5.5.orDefault(10), equals(5.5));
    });

    test('isNullOrZero', () {
      expect((null as num?).isNullOrZero, isTrue);
      expect(0.isNullOrZero, isTrue);
      expect(0.0.isNullOrZero, isTrue);
      expect(5.isNullOrZero, isFalse);
    });
  });

  group('BoolNullableX', () {
    test('orFalse', () {
      expect((null as bool?).orFalse, isFalse);
      expect(true.orFalse, isTrue);
      expect(false.orFalse, isFalse);
    });

    test('orTrue', () {
      expect((null as bool?).orTrue, isTrue);
      expect(true.orTrue, isTrue);
      expect(false.orTrue, isFalse);
    });

    test('isNullOrFalse', () {
      expect((null as bool?).isNullOrFalse, isTrue);
      expect(false.isNullOrFalse, isTrue);
      expect(true.isNullOrFalse, isFalse);
    });
  });

  group('IntX', () {
    test('isEven / isOdd', () {
      expect(4.isEven, isTrue);
      expect(4.isOdd, isFalse);
      expect(5.isEven, isFalse);
      expect(5.isOdd, isTrue);
    });

    test('digitCount', () {
      expect(0.digitCount, equals(1));
      expect(5.digitCount, equals(1));
      expect(123.digitCount, equals(3));
      expect((-123).digitCount, equals(3));
    });

    test('digits', () {
      expect(1234.digits, equals([1, 2, 3, 4]));
      expect((-1234).digits, equals([1, 2, 3, 4]));
      expect(0.digits, equals([0]));
    });

    test('isBetween', () {
      expect(5.isBetween(1, 10), isTrue);
      expect(5.isBetween(5, 10), isTrue);
      expect(5.isBetween(1, 5), isTrue);
      expect(5.isBetween(6, 10), isFalse);
    });

    test('times', () {
      var count = 0;
      3.times(() => count++);
      expect(count, equals(3));

      var zeroCount = 0;
      0.times(() => zeroCount++);
      expect(zeroCount, equals(0));

      var negativeCount = 0;
      (-3).times(() => negativeCount++);
      expect(negativeCount, equals(0));
    });

    test('to', () {
      expect(1.to(5).toList(), equals([1, 2, 3, 4, 5]));
      expect(5.to(1).toList(), equals([5, 4, 3, 2, 1]));
      expect(1.to(5, step: 2).toList(), equals([1, 3, 5]));
      expect(5.to(1, step: 2).toList(), equals([5, 3, 1]));
      expect(() => 1.to(5, step: 0).toList(), throwsArgumentError);
      expect(() => 1.to(5, step: -1).toList(), throwsArgumentError);
    });
  });

  group('NumX', () {
    test('temperature conversions', () {
      expect(0.celsiusToFahrenheit, equals(32));
      expect(32.fahrenheitToCelsius, equals(0));
      expect(0.celsiusToKelvin, equals(273.15));
      expect(273.15.kelvinToCelsius, closeTo(0, 0.0001));
      expect(32.fahrenheitToKelvin, closeTo(273.15, 0.0001));
      expect(273.15.kelvinToFahrenheit, closeTo(32, 0.0001));
    });

    test('roundTo', () {
      expect(3.14159.roundTo(2), equals(3.14));
      expect(3.145.roundTo(2), equals(3.15));
      expect(3.145.roundTo(0), equals(3.0));
      expect(() => 3.145.roundTo(-1), throwsArgumentError);
    });

    test('roundToMultiple', () {
      expect(27.roundToMultiple(5), equals(25));
      expect(28.roundToMultiple(5), equals(30));
      expect(() => 28.roundToMultiple(0), throwsArgumentError);
    });

    test('floorToMultiple', () {
      expect(27.floorToMultiple(5), equals(25));
      expect(29.floorToMultiple(5), equals(25));
      expect(() => 29.floorToMultiple(0), throwsArgumentError);
    });

    test('ceilToMultiple', () {
      expect(21.ceilToMultiple(5), equals(25));
      expect(25.ceilToMultiple(5), equals(25));
      expect(() => 25.ceilToMultiple(0), throwsArgumentError);
    });

    test('normalized / normalizedClamped / safeNormalized', () {
      expect(5.normalized(0, 10), equals(0.5));
      expect(15.normalized(0, 10), equals(1.5));
      expect(15.normalizedClamped(0, 10), equals(1.0));
      expect((-5).normalizedClamped(0, 10), equals(0.0));
      expect(() => 5.normalized(10, 10), throwsArgumentError);

      expect(5.safeNormalized(10, 10, fallback: 0.5), equals(0.5));
    });

    test('isBetween', () {
      expect(5.5.isBetween(1.0, 10.0), isTrue);
      expect(5.5.isBetween(5.5, 10.0), isTrue);
      expect(5.5.isBetween(1.0, 5.0), isFalse);
    });

    test('isWholeNumber', () {
      expect(5.isWholeNumber, isTrue);
      expect(5.0.isWholeNumber, isTrue);
      expect(5.5.isWholeNumber, isFalse);
    });

    test('lerp', () {
      expect(0.25.lerp(0, 100), equals(25.0));
      expect(0.5.lerp(10, 20), equals(15.0));
    });
  });
}
