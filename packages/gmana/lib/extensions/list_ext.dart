/// Extension on [Iterable] of nullable values, allowing removal of nulls and optional transformation.
///
/// If a [transform] function is provided, it is applied to each element before filtering out nulls.
///
/// Example:
/// ```dart
/// final result = [1, 2, null, 3].compactMap();
/// print(result); // (1, 2, 3)
///
/// final transformed = [1, 2, null, 3].compactMap((e) => e == null ? null : e * 2);
/// print(transformed); // (2, 4, 6)
/// ```
extension CompactMap<T> on Iterable<T?> {
  /// Maps and filters out `null` values from the iterable.
  ///
  /// If [transform] is provided, each element is first transformed and then filtered.
  /// If not, the original values are used as-is.
  Iterable<T> compactMap<E>([E? Function(T?)? transform]) {
    return map(transform ?? (e) => e).where((e) => e != null).cast();
  }
}

/// Extension on a list of lists to provide a single-level flattened list.
///
/// Flattens a nested list structure like `List<List<E>>` into a single [List<E>].
///
/// Example:
/// ```dart
/// final flatList = [[1, 2, 3], [4, 5, 6]].flatten();
/// print(flatList); // [1, 2, 3, 4, 5, 6]
/// ```
extension ListFlattenExtension<E> on List<List<E>> {
  /// Flattens a `List<List<E>>` into a single `List<E>`.
  List<E> flatten() => [for (final list in this) ...list];
}
