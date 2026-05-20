import '../regex/identifier_patterns.dart';
import '../regex/network_patterns.dart';

/// Returns `true` if [str] is a valid IPv4 address.
bool isIpv4(String str) {
  if (!ipv4Maybe.hasMatch(str)) return false;
  final parts = str.split('.');
  for (final part in parts) {
    final n = int.tryParse(part);
    if (n == null || n < 0 || n > 255) return false;
  }
  return true;
}

/// Returns `true` if [str] is a valid IPv6 address.
bool isIpv6(String str) => ipv6.hasMatch(str);

/// Returns `true` if [str] is a valid postal code for [locale].
///
/// Throws [FormatException] if [locale] is not supported and no [orElse] is provided.
bool isPostalCode(String? text, String locale, {bool Function()? orElse}) {
  final pattern = postalCodePatterns[locale];
  return pattern != null
      ? pattern.hasMatch(text!)
      : orElse != null
      ? orElse()
      : throw FormatException('No postal code pattern for locale: $locale');
}
