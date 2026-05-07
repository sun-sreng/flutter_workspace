import 'package:gmana/extensions.dart';
import 'package:gmana/functional.dart';
import 'package:gmana/utilities.dart';
import 'package:gmana/validation.dart' hide isNull;
import 'package:test/test.dart';

void main() {
  test('focused entrypoints expose the curated API surface', () {
    final either = const Right<String, int>(21).map((value) => value * 2);
    const ResultUnit result = Right<Failure, Unit>(unit);
    final emailResult = const EmailValidator().validate(' User@Example.com ');
    final emailFormValidator = asFormValidator(
      validate: const EmailValidator().validate,
      resolve: resolveEmailValidationIssue,
    );
    final debouncer = Debouncer(milliseconds: 1);
    final throttler = Throttler(milliseconds: 1);

    expect(either.getRight(), 42);
    expect(result, const Right<Failure, Unit>(unit));
    expect('hello world'.toTitleCase, 'Hello World');
    expect('user@example.com'.isValidEmail, isTrue);
    expect(emailResult.getRight(), 'user@example.com');
    expect(emailFormValidator(''), 'Please enter an email address');
    expect(GSpacing.md, 12);
    expect(
      waveVerticalOffset(
        value: 0,
        verticalShift: 10,
        amplitude: 5,
        phaseShift: 0,
        waveLength: 20,
      ),
      closeTo(10, 0.000001),
    );

    debouncer.dispose();
    throttler.dispose();
  });
}
