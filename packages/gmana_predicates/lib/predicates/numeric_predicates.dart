/// Returns `true` if the numeric value of [str] is divisible by [n].
///
/// Both [str] and [n] are parsed as numbers; returns `false` on parse failure.
bool isDivisibleBy(String str, String n) {
  try {
    return double.parse(str) % int.parse(n) == 0;
  } catch (_) {
    return false;
  }
}
