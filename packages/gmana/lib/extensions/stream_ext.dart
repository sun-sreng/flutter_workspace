/// Extension on [Stream] of [List]s to provide functional-style filtering.
///
/// This extension adds a `filter` method that allows you to apply a `where` clause
/// to each emitted list in the stream.
///
/// Example:
/// ```dart
/// final stream = Stream.value([1, 2, 3, 4, 5]);
///
/// stream.filter((n) => n.isEven).listen(print); // prints: [2, 4]
/// ```
extension Filter<T> on Stream<List<T>> {
  /// Filters each emitted list in the stream based on the provided [where] predicate.
  ///
  /// Returns a new [Stream] where each `List<T>` contains only the elements that satisfy [where].
  Stream<List<T>> filter(bool Function(T) where) {
    return map((items) => items.where(where).toList());
  }
}
