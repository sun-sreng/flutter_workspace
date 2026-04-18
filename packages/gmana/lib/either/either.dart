/// A generic type that represents a value of one of two possible types (a disjoint union).
///
/// Instances of `Either` are either an instance of [Left] or [Right].
/// - [Left] is used to represent failure, typically holding an error or exception.
/// - [Right] is used to represent success, typically holding a valid result.
///
/// `Either<L, R>` is commonly used as a functional alternative to throwing exceptions.
///
/// ### Example:
/// ```dart
/// void main() {
///   final result1 = divide(10, 2);
///   final result2 = divide(5, 0);
///
///   result1.fold(
///     (error) => print('Error: $error'),
///     (value) => print('Result: $value'),
///   ); // Prints: Result: 5
///
///   result2.fold(
///     (error) => print('Error: $error'),
///     (value) => print('Result: $value'),
///   ); // Prints: Error: Cannot divide by zero
///
///   // Using map
///   final mappedResult = result1.map((value) => value * 2);
///   print(mappedResult.getRight()); // Prints: 10
/// }
///
/// Either<String, int> divide(int a, int b) {
///   if (b == 0) {
///     return const Left('Cannot divide by zero');
///   } else {
///     return Right(a ~/ b);
///   }
/// }
/// ```
abstract class Either<L, R> {
  /// Creates an [Either] instance.
  const Either();

  /// Maps the [Left] value using [f], if present.
  ///
  /// If this is a [Right], the same successful value is returned unchanged.
  Either<L2, R> mapLeft<L2>(L2 Function(L left) f);

  /// Applies the function [f] to the value contained in [Right], if it exists,
  /// and returns a new [Either] containing the result. If this is a [Left],
  /// it is returned unchanged.
  Either<L, R2> flatMap<R2>(Either<L, R2> Function(R right) f);

  /// Applies [ifLeft] or [ifRight] and returns a new [Either] with mapped values.
  Either<L2, R2> bimap<L2, R2>(
    L2 Function(L left) ifLeft,
    R2 Function(R right) ifRight,
  );

  /// Applies one of two functions depending on whether this is a [Left] or [Right].
  ///
  /// - If this is a [Left], returns `ifLeft(left)`.
  /// - If this is a [Right], returns `ifRight(right)`.
  B fold<B>(B Function(L left) ifLeft, B Function(R right) ifRight);

  /// Returns the [Left] value if this is a [Left], otherwise throws.
  L getLeft();

  /// Returns the [Right] value if this is a [Right], otherwise throws.
  R getRight();

  /// Returns the [Left] value if this is a [Left], otherwise `null`.
  L? leftOrNull();

  /// Returns the [Right] value if this is a [Right], otherwise `null`.
  R? rightOrNull();

  /// Returns the [Right] value if this is a [Right], otherwise computes a fallback.
  R getOrElse(R Function(L left) orElse) => fold(orElse, (right) => right);

  /// Returns `true` if this is a [Left].
  bool isLeft();

  /// Returns `true` if this is a [Right].
  bool isRight();

  /// Transforms the value contained in [Right] using the given function [f],
  /// returning a new [Either] with the transformed value.
  ///
  /// If this is a [Left], the same instance is returned unchanged.
  Either<L, R2> map<R2>(R2 Function(R right) f);

  /// Swaps the sides of this [Either], turning [Left] into [Right] and vice versa.
  Either<R, L> swap();
}
