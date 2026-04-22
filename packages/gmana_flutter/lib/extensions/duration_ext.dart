extension HumanizedDuration on Duration {
  // ── Predicates ────────────────────────────────────────────────────────

  bool get isNegative => inMicroseconds < 0;

  // ── Clock format: 1:03:07 / 4:02 / 0:45 ─────────────────────────────

  bool get isZero => inMicroseconds == 0;

  // ── Natural language: "2 hours 3 minutes" ────────────────────────────

  // ── Internal helpers ──────────────────────────────────────────────────

  Duration get _abs => abs();

  // ── Relative: "in 5 minutes" / "3 hours ago" ─────────────────────────

  /// True when the duration exceeds the given threshold.
  bool isLongerThan(Duration other) => compareTo(other) > 0;

  // ── Compact: "2h 3m" ─────────────────────────────────────────────────

  bool isShorterThan(Duration other) => compareTo(other) < 0;

  // ── Granular: all units including ms ─────────────────────────────────

  /// Returns a stopwatch-style string.
  ///
  /// - Under 1 hour:  `m:ss`   → `4:02`, `0:45`
  /// - 1 hour+:       `h:mm:ss` → `1:03:07`
  /// - Negative:      prefixed with `-`
  String toClockString() {
    final d = _abs;
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;

    final mm = '$m'.padLeft(2, '0');
    final ss = '$s'.padLeft(2, '0');

    final body = h > 0 ? '$h:$mm:$ss' : '$m:$ss';
    return isNegative ? '-$body' : body;
  }

  /// Returns a short compact form for tight UI (badges, chips, tables).
  ///
  /// - `Duration(hours: 2, minutes: 3)` → `"2h 3m"`
  /// - `Duration(minutes: 0, seconds: 45)` → `"45s"`
  /// - `Duration.zero` → `"0s"`
  String toCompactString() {
    final d = _abs;
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;

    final parts = <String>[if (h > 0) '${h}h', if (m > 0) '${m}m', if (s > 0 || (h == 0 && m == 0)) '${s}s'];

    final body = parts.take(2).join(' ');
    return isNegative ? '-$body' : body;
  }

  /// Returns a natural-language description using the two largest non-zero units.
  ///
  /// Examples:
  /// - `Duration(hours: 2, minutes: 3)` → `"2 hours 3 minutes"`
  /// - `Duration(minutes: 1, seconds: 5)` → `"1 minute 5 seconds"`
  /// - `Duration(seconds: 45)`           → `"45 seconds"`
  /// - `Duration.zero`                   → `"0 seconds"`
  /// - Negative durations               → prefixed with `"in "` or `"ago"` via [toRelativeString].
  String toHumanizedString() {
    final d = _abs;
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;

    String unit(int n, String singular) => '$n ${n == 1 ? singular : '${singular}s'}';

    final parts = <String>[
      if (h > 0) unit(h, 'hour'),
      if (m > 0) unit(m, 'minute'),
      if (s > 0 || (h == 0 && m == 0)) unit(s, 'second'),
    ];

    // Max two most significant parts to avoid "1 hour 3 minutes 5 seconds".
    return parts.take(2).join(' ');
  }

  /// Returns a relative time string suitable for "posted X ago" UI.
  ///
  /// - Positive → `"in X"`   (future)
  /// - Negative → `"X ago"`  (past)
  /// - Near-zero → `"just now"`
  String toRelativeString() {
    if (_abs.inSeconds < 5) return 'just now';
    final base = _abs.toHumanizedString();
    return isNegative ? '$base ago' : 'in $base';
  }

  /// Full breakdown including milliseconds. Useful for dev/debug displays.
  ///
  /// Omits leading zero units except the last.
  /// `Duration(minutes: 1, milliseconds: 500)` → `"1m 0s 500ms"`
  String toVerboseString() {
    final d = _abs;
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    final ms = d.inMilliseconds % 1000;

    final parts = <String>[if (h > 0) '${h}h', if (h > 0 || m > 0) '${m}m', '${s}s', if (ms > 0) '${ms}ms'];

    final body = parts.join(' ');
    return isNegative ? '-$body' : body;
  }
}
