/// Validates if the given string [str] is a Fully Qualified Domain Name (FQDN).
///
/// The validation checks that:
/// - The domain is composed of valid parts separated by dots ('.').
/// - Optionally requires a valid top-level domain (TLD) if [requireTld] is true.
/// - Optionally allows underscores in domain parts if [allowUnderscores] is true.
///
/// Validation rules for each part:
/// - Must match the pattern of allowed characters (letters, numbers, hyphens, Unicode letters).
/// - Cannot start or end with a hyphen.
/// - Cannot contain consecutive underscores (`__`) if underscores are allowed.
/// - Cannot contain triple consecutive hyphens (`---`).
///
/// Examples:
/// ```dart
/// isFQDN('example.com'); // true
/// isFQDN('foo_bar.example.com', allowUnderscores: true); // true
/// isFQDN('example'); // false if requireTld is true
/// isFQDN('exa_mple.com'); // false if allowUnderscores is false
/// ```
///
/// Parameters:
/// - [requireTld]: If true, ensures the last part is a valid TLD (only letters, min length 2).
/// - [allowUnderscores]: If true, allows underscores in domain parts (but disallows consecutive `__`).
bool isFQDN(
  String str, {
  bool requireTld = true,
  bool allowUnderscores = false,
}) {
  final parts = str.split('.');

  if (requireTld) {
    final tld = parts.removeLast();
    // TLD must be at least 2 letters, lowercase a-z only
    if (parts.isEmpty || !RegExp(r'^[a-z]{2,}$').hasMatch(tld)) {
      return false;
    }
  }

  for (final part in parts) {
    if (allowUnderscores && part.contains('__')) {
      return false;
    }

    // Allowed characters: a-z, Unicode letters, digits 0-9, and hyphen
    if (!RegExp(
      r'^[a-z\u00a1-\uffff0-9-]+$',
      caseSensitive: false,
    ).hasMatch(part)) {
      return false;
    }

    if (part.startsWith('-') || part.endsWith('-') || part.contains('---')) {
      return false;
    }
  }

  return true;
}
