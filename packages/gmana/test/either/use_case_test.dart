import 'package:gmana/gmana.dart';
import 'package:test/test.dart';

void main() {
  group('use case helpers', () {
    test('Failure has a clean default message and value semantics', () {
      expect(const Failure(), const Failure('An unexpected error occurred.'));
      expect(const Failure('boom'), const Failure('boom'));
      expect(const Failure('boom').hashCode, const Failure('boom').hashCode);
      expect(const Failure('boom').toString(), 'Failure(message: boom)');
    });

    test('NoParams behaves like a value marker', () {
      expect(const NoParams(), const NoParams());
      expect(const NoParams().hashCode, const NoParams().hashCode);
      expect(const NoParams().toString(), 'NoParams()');
    });

    test('unit is a stable singleton-style value', () {
      expect(unit, isA<Unit>());
      expect(unit, equals(unit));
      expect(unit.toString(), '()');
    });

    test('UseCase can be implemented with the shared typedefs', () async {
      const params = NoParams();
      final useCase = _GreetingUseCase();

      expect(await useCase(params), const Right<Failure, String>('hello'));
    });
  });
}

class _GreetingUseCase implements UseCase<String, NoParams> {
  @override
  FutureEither<String> call(NoParams params) async {
    return const Right<Failure, String>('hello');
  }
}
