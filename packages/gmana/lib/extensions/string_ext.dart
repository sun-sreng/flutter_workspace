/// Extension on [String] to add conversion, formatting, and utility methods.
extension StringExt on String {
  /// Parses the string to a `double`. Returns `0.0` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// '42.5'.toDouble // 42.5
  /// 'abc'.toDouble // 0.0
  /// ```
  double get toDouble => double.tryParse(this) ?? 0.0;

  /// Parses the string to an `int`. Returns `0` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// '42'.toInt // 42
  /// 'abc'.toInt // 0
  /// ```
  int get toInt => int.tryParse(this) ?? 0;

  /// Estimates the reading time of the text in **minutes**.
  ///
  /// Assumes an average reading speed of 225 words per minute.
  ///
  /// Example:
  /// ```dart
  /// 'This is a sample paragraph...'.calculateReadingTime(); // 1
  /// ```
  int calculateReadingTime() {
    final int wordCount = split(RegExp(r'\s+')).length;
    final double readingTime = wordCount / 225;
    return readingTime.ceil();
  }

  /// Parses a time string (e.g. `"MM:SS"` or `"HH:MM:SS"`) into a [Duration].
  ///
  /// Throws an [Exception] if the format is invalid.
  ///
  /// Example:
  /// ```dart
  /// '01:30'.toDuration(); // Duration(minutes: 1, seconds: 30)
  /// '01:15:20'.toDuration(); // Duration(hours: 1, minutes: 15, seconds: 20)
  /// ```
  Duration toDuration() {
    final chunks = split(':');
    if (chunks.length == 1) {
      throw Exception('Invalid duration string: $this');
    } else if (chunks.length == 2) {
      return Duration(
        minutes: int.parse(chunks[0].trim()),
        seconds: int.parse(chunks[1].trim()),
      );
    } else if (chunks.length == 3) {
      return Duration(
        hours: int.parse(chunks[0].trim()),
        minutes: int.parse(chunks[1].trim()),
        seconds: int.parse(chunks[2].trim()),
      );
    } else {
      throw Exception('Invalid duration string: $this');
    }
  }

  /// Capitalizes the first character of the string, leaving the rest as-is.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.toSentenceCase(); // 'Hello'
  /// ```
  String toSentenceCase() {
    switch (length) {
      case 0:
        return this;
      case 1:
        return toUpperCase();
      default:
        return substring(0, 1).toUpperCase() + substring(1);
    }
  }

  /// Capitalizes the first letter of each word in the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.toTitleCase(); // 'Hello World'
  /// ```
  String toTitleCase() => replaceAll(
    RegExp(' +'),
    ' ',
  ).split(' ').map((str) => str.toSentenceCase()).join(' ');
}

/// Extension on nullable [String] to safely fallback to an empty string.
extension StringNullableExt on String? {
  /// Returns the string or an empty string if `null`.
  ///
  /// Example:
  /// ```dart
  /// String? name = null;
  /// print(name.orEmpty()); // ''
  /// ```
  String orEmpty() {
    return this ?? "";
  }
}
