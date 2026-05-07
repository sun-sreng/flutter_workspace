/// Disposable domain list - extend this or inject your own.
/// Consider loading from a remote source in production.
const Set<String> kDefaultDisposableDomains = {
  '10minutemail.com',
  'guerrillamail.com',
  'mailinator.com',
  'temp-mail.org',
  'tempmail.com',
  'throwaway.email',
  'yopmail.com',
  'sharklasers.com',
  'trashmail.com',
};

/// Configuration rules for email validation.
final class EmailValidationConfig {
  /// Maximum allowed length for the entire normalized email address.
  final int maxLength;

  /// Maximum allowed length for the local part before `@`.
  final int maxLocalPartLength;

  /// Maximum allowed length for the domain part after `@`.
  final int maxDomainLength;

  /// Domains treated as disposable when [rejectDisposable] is enabled.
  final Set<String> disposableDomains;

  /// Domains that should always be rejected.
  final Set<String> blockedDomains;

  /// When true, emails from [disposableDomains] are rejected.
  final bool rejectDisposable;

  /// When true, configured domains also match their subdomains.
  ///
  /// For example, `example.com` also matches `mail.example.com`.
  final bool matchSubdomains;

  /// Creates email validation configuration.
  const EmailValidationConfig({
    this.maxLength = 254,
    this.maxLocalPartLength = 64,
    this.maxDomainLength = 253,
    this.disposableDomains = kDefaultDisposableDomains,
    this.blockedDomains = const {},
    this.rejectDisposable = false,
    this.matchSubdomains = true,
  }) : assert(maxLength > 0, 'maxLength must be greater than zero'),
       assert(
         maxLocalPartLength > 0,
         'maxLocalPartLength must be greater than zero',
       ),
       assert(maxDomainLength > 0, 'maxDomainLength must be greater than zero');

  /// Rejects disposable domains using the default list.
  factory EmailValidationConfig.strict() {
    return const EmailValidationConfig(rejectDisposable: true);
  }

  /// Normalizes a domain for policy matching.
  String normalizeDomain(String domain) {
    return domain.trim().toLowerCase();
  }

  /// Returns true when [domain] is blocked by [blockedDomains].
  bool isBlockedDomain(String domain) {
    return _matchesConfiguredDomain(domain, blockedDomains);
  }

  /// Returns true when [domain] is disposable and [rejectDisposable] is enabled.
  bool isDisposableDomain(String domain) {
    return rejectDisposable &&
        _matchesConfiguredDomain(domain, disposableDomains);
  }

  bool _matchesConfiguredDomain(String domain, Set<String> configuredDomains) {
    final normalizedDomain = normalizeDomain(domain);

    for (final configuredDomain in configuredDomains) {
      final normalizedConfiguredDomain = normalizeDomain(configuredDomain);
      if (normalizedConfiguredDomain.isEmpty) continue;
      if (normalizedDomain == normalizedConfiguredDomain) return true;
      if (matchSubdomains &&
          normalizedDomain.endsWith('.$normalizedConfiguredDomain')) {
        return true;
      }
    }

    return false;
  }
}
