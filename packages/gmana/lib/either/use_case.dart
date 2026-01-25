import '../gmana.dart';

/// A singleton instance representing a unit of work with no meaningful value.
///
/// Similar to `void`, but usable in functional chains and as a return type in [Either].
const unit = Unit._unit;

/// A type alias for an [Either] that has [Failure] as its `Left` type and [T] as its `Right` type.
///
/// Typically used for functions that may fail and return a result of type [T] on success.
typedef EitherFailure<T> = Either<Failure, T>;

/// A type alias for a `Future` that completes with an [EitherFailure].
///
/// Used for asynchronous operations that can fail and return a result of type [T].
typedef FutureEither<T> = Future<Either<Failure, T>>;

/// A shorthand for a [FutureEither] that completes with a [Unit] result.
///
/// Represents asynchronous operations that return no value on success.
typedef FutureEitherUnit = FutureEither<Unit>;

/// A type alias for a `Map<String, dynamic>` often used for generic JSON-like objects or data payloads.
typedef GMap = Map<String, dynamic>;

/// Represents a failure in an operation, usually as the `Left` value of an [Either].
///
/// Contains a human-readable error [message].
class Failure {
  /// The error message describing the failure.
  final String message;

  /// Creates a [Failure] with an optional [message]. Defaults to a generic error message.
  Failure([this.message = 'An unexpected error occurred,']);
}

/// A class that represents a lack of parameters.
///
/// Useful when a [UseCase] requires no input but must still follow a uniform interface.
class NoParams {}

/// Represents a void-like value in functional programming.
///
/// Used to indicate success where no meaningful value is returned (similar to `void` in Dart).
final class Unit {
  static const Unit _unit = Unit._instance();

  /// Private constant constructor.
  const Unit._instance();

  /// String representation of [Unit] — returns `'()'`.
  @override
  String toString() => '()';
}

/// A contract for defining use cases (application business logic) in a clean architecture approach.
///
/// [SuccessType] is the type returned on success, and [Params] is the type of the input parameters.
///
/// Use cases should return a [FutureEither] to indicate both asynchronous and fallible behavior.
abstract interface class UseCase<SuccessType, Params> {
  /// Executes the use case with the given [params] and returns a [FutureEither] result.
  FutureEither<SuccessType> call(Params params);
}
