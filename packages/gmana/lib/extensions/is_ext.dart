/// Extension on [String] providing validation utilities for common input types.
///
/// Includes methods to validate emails, names, passwords, and phone numbers.
extension IsExt on String {
  /// Checks if the string is a valid email address.
  ///
  /// Uses a basic regular expression to match common email patterns.
  ///
  /// Example:
  /// ```dart
  /// 'user@example.com'.isValidEmail; // true
  /// ```
  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(this);
  }

  /// Checks if the string is a valid personal name.
  ///
  /// Accepts letters, spaces, hyphens, periods, and apostrophes in typical name formats.
  ///
  /// Example:
  /// ```dart
  /// 'John D. O'Connor'.isValidName; // true
  /// ```
  bool get isValidName {
    final nameRegExp = RegExp(
      r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$",
    );
    return nameRegExp.hasMatch(this);
  }

  /// Checks if the string is a strong password.
  ///
  /// Password must:
  /// - Be at least 8 characters long
  /// - Contain at least one uppercase letter
  /// - Contain at least one lowercase letter
  /// - Contain at least one digit
  /// - Contain at least one special character (`!@#><*~`)
  ///
  /// Example:
  /// ```dart
  /// 'Str0ng!Pass'.isValidPassword; // true
  /// ```
  bool get isValidPassword {
    final passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#><*~]).{8,}$',
    );
    return passwordRegExp.hasMatch(this);
  }

  /// Checks if the string is a valid phone number in a specific format.
  ///
  /// Accepts numbers with optional `+` and requires exactly 11 digits starting with `0`.
  ///
  /// Example:
  /// ```dart
  /// '01234567890'.isValidPhone; // true
  /// ```
  bool get isValidPhone {
    final phoneRegExp = RegExp(r'^\+?0[0-9]{10}$');
    return phoneRegExp.hasMatch(this);
  }
}
