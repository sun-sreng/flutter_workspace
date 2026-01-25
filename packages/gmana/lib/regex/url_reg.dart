/// A [RegExp] object used to validate basic URL strings using [urlStr].
///
/// This pattern covers common use cases but does not strictly enforce all URL
/// standards (e.g. query parameters, ports, or stricter TLD validation).
RegExp urlReg = RegExp(urlStr);

/// A regular expression pattern that matches basic URL formats.
///
/// This pattern matches optional `http://` or `https://` protocols, followed by
/// a domain name, optional subdomains, and optional path segments.
///
/// Examples of valid formats:
/// - https://example.com
/// - http://sub.example.co.uk/path/to/page
/// - www.example.com
/// - example.com
String urlStr =
    r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$';
