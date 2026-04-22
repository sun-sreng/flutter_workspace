import 'validation_rule.dart';
import 'validators.dart';

/// Provides validation rules and utilities for validating usernames.
///
/// This class includes both a `getRules()` method to return a list of validation rules,
/// and a `validate()` method to run all validation checks on a given username string.
///
/// Common username constraints include:
/// - Required field
/// - Minimum and maximum length
/// - Forbidden characters (e.g., `@`)
/// - Optional pattern for allowed characters
class UsernameValidator {
  /// Returns a list of [ValidationRule]s used to validate a username.
  ///
  /// The returned rules include:
  /// - Required
  /// - Minimum and maximum length
  /// - Check for forbidden characters
  /// - Pattern matching if [allowedPattern] is provided
  ///
  /// ### Parameters:
  /// - [minLength] - Minimum allowed length of the username (default: 3)
  /// - [maxLength] - Maximum allowed length of the username (default: 20)
  /// - [forbiddenCharacters] - Set of characters not allowed in the username (default: `{'@'}`)
  /// - [allowedPattern] - Optional [RegExp] to match valid characters in the username
  static List<ValidationRule> getRules({
    int minLength = 3,
    int maxLength = 20,
    Set<String> forbiddenCharacters = const {'@'},
    RegExp? allowedPattern,
  }) {
    return [
      Validators.required(message: 'Username is required'),
      Validators.minLength(minLength, message: 'Username must be at least $minLength characters'),
      Validators.maxLength(maxLength, message: 'Username must not exceed $maxLength characters'),
      if (forbiddenCharacters.isNotEmpty)
        Validators.custom(
          (value) => _containsForbiddenChars(value, forbiddenCharacters) ? '' : null,
          message: 'Username cannot contain: ${forbiddenCharacters.join(', ')}',
        ),
      if (allowedPattern != null)
        Validators.pattern(allowedPattern.pattern, message: 'Username contains invalid characters'),
    ];
  }

  /// Validates a given [value] (username) using the defined rules.
  ///
  /// Returns an error message if any rule fails, or `null` if validation passes.
  ///
  /// ### Parameters:
  /// - [value] - The username to validate.
  /// - [minLength] - Minimum allowed length (default: 3).
  /// - [maxLength] - Maximum allowed length (default: 20).
  /// - [forbiddenCharacters] - Characters that are not allowed (default: `{'@'}`).
  /// - [allowedPattern] - Optional pattern to restrict allowed characters.
  static String? validate(
    String? value, {
    int minLength = 3,
    int maxLength = 20,
    Set<String> forbiddenCharacters = const {'@'},
    RegExp? allowedPattern,
  }) {
    return Validators.validate(
      value,
      getRules(
        minLength: minLength,
        maxLength: maxLength,
        forbiddenCharacters: forbiddenCharacters,
        allowedPattern: allowedPattern,
      ),
    );
  }

  /// Checks if the given [value] contains any character from [forbiddenChars].
  ///
  /// Returns `true` if any forbidden character is found, otherwise `false`.
  static bool _containsForbiddenChars(String? value, Set<String> forbiddenChars) {
    return value != null && forbiddenChars.any((char) => value.contains(char));
  }
}
