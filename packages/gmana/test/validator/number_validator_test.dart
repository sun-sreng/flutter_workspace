import 'package:gmana/validator/number_validator.dart';
import 'package:test/test.dart';

void main() {
  group('NumberValidator', () {
    test('rejects empty values', () {
      expect(const NumberValidator().validate(null), 'Please enter a number');
      expect(const NumberValidator().validate(''), 'Please enter a number');
    });

    test('rejects non-numeric values', () {
      expect(
        const NumberValidator().validate('abc'),
        'Please enter a valid number',
      );
    });

    test('validates bounds', () {
      const validator = NumberValidator(minValue: 10, maxValue: 20);
      expect(validator.validate('9'), 'Number must be at least 10');
      expect(validator.validate('21'), 'Number must be at most 20');
      expect(validator.validate('15'), isNull);
    });
  });
}
