/// Extension on [Iterable] for numeric types to compute the sum of elements.
///
/// Works with both `int` and `double` collections. This method will throw a
/// [StateError] if the iterable is empty, as it relies on [reduce].
///
/// Example:
/// ```dart
/// final sumInt = [1, 2, 3].sum();
/// print(sumInt); // 6
///
/// final sumDouble = [1.0, 2.0, 3.0].sum();
/// print(sumDouble); // 6.0
/// ```
extension IterableX<T extends num> on Iterable<T> {
  /// Returns the sum of all elements in the iterable.
  ///
  /// Throws a [StateError] if the iterable is empty.
  T sum() => reduce((value, element) => (value + element) as T);
}
