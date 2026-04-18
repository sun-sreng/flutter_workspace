/// Extension on [String] to add conversion, formatting, and utility methods.
extension StringExt on String {
  // ---------------------------------------------------------------------------
  // Parsing
  // ---------------------------------------------------------------------------

  /// Parses to `double`, returns `null` on failure.
  /// Prefer this over [toDoubleOrZero] when you need to distinguish "0" from invalid.
  double? get toDoubleOrNull => double.tryParse(this);

  /// Parses to `double`, returns `0.0` on failure.
  double get toDoubleOrZero => double.tryParse(this) ?? 0.0;

  /// Parses to `int`, returns `null` on failure.
  int? get toIntOrNull => int.tryParse(this);

  /// Parses to `int`, returns `0` on failure.
  int get toIntOrZero => int.tryParse(this) ?? 0;

  // ---------------------------------------------------------------------------
  // Duration
  // ---------------------------------------------------------------------------

  /// Parses `"SS"`, `"MM:SS"`, or `"HH:MM:SS"` into a [Duration].
  ///
  /// Throws [FormatException] on invalid format or out-of-range values.
  Duration toDuration() {
    final parts = split(':');

    int parse(String s, String label, {int max = 59}) {
      final v = int.tryParse(s.trim());
      if (v == null) throw FormatException('Invalid $label in duration: "$this"');
      if (v < 0 || v > max) {
        throw FormatException('$label out of range (0–$max) in duration: "$this"');
      }
      return v;
    }

    return switch (parts.length) {
      1 => Duration(seconds: parse(parts[0], 'seconds')),
      2 => Duration(minutes: parse(parts[0], 'minutes'), seconds: parse(parts[1], 'seconds')),
      3 => Duration(
        hours: parse(parts[0], 'hours', max: 23),
        minutes: parse(parts[1], 'minutes'),
        seconds: parse(parts[2], 'seconds'),
      ),
      _ => throw FormatException('Invalid duration format: "$this"'),
    };
  }

  // ---------------------------------------------------------------------------
  // Reading time
  // ---------------------------------------------------------------------------

  /// Estimates reading time in minutes (225 wpm average).
  /// Returns `0` for blank/empty strings.
  int get readingTimeMinutes {
    final trimmed = trim();
    if (trimmed.isEmpty) return 0;
    final wordCount = trimmed.split(RegExp(r'\s+')).length;
    return (wordCount / 225).ceil();
  }

  // ---------------------------------------------------------------------------
  // Case formatting
  // ---------------------------------------------------------------------------

  /// Capitalizes only the first character; preserves the rest.
  ///
  /// `'hello world'` → `'Hello world'`
  String get toSentenceCase {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Capitalizes the first letter of each whitespace-delimited word.
  ///
  /// Collapses internal whitespace; strips leading/trailing whitespace.
  ///
  /// `'  hello   world  '` → `'Hello World'`
  String get toTitleCase {
    return trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).map((w) => w.toSentenceCase).join(' ');
  }
}

// ---------------------------------------------------------------------------

/// Extension on nullable [String].
extension StringNullableExt on String? {
  /// Returns the string or `''` if `null`.
  String get orEmpty => this ?? '';

  /// Returns `true` if `null` or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns `true` if `null`, empty, or only whitespace.
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
}
