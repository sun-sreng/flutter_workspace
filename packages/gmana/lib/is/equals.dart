/// Checks if a nullable string is equal to a comparison string.
///
/// The comparison string is converted to a string via `toString()` to
/// ensure a valid comparison.
///
/// Returns `true` if the strings are equal, `false` otherwise.
bool equals(String? str, String comparison) {
  return str == comparison.toString();
}
