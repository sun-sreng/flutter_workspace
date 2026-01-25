/// Defines the signature for a validation function.
///
/// A [ValidationFunction] accepts a nullable [String] input and returns:
/// - `null` if the value is valid
/// - A [String] error message if the value is invalid
typedef ValidationFunction = String? Function(String?);

/// Represents a single validation rule for validating a [String] value.
///
/// This class encapsulates a validation function and an associated error message.
/// When the validation fails, the predefined [errorMessage] is returned.
class ValidationRule {
  /// The validation function to execute.
  final ValidationFunction validate;

  /// The error message to return if validation fails.
  final String errorMessage;

  /// Creates a [ValidationRule] with a [validate] function and [errorMessage].
  ///
  /// Example:
  /// ```dart
  /// ValidationRule rule = ValidationRule(
  ///   (value) => value == null || value.isEmpty ? 'Required' : null,
  ///   'Field is required',
  /// );
  /// ```
  const ValidationRule(this.validate, this.errorMessage);

  /// Executes the validation logic against the given [value].
  ///
  /// Returns:
  /// - `null` if the [value] is valid
  /// - [errorMessage] if validation fails
  String? call(String? value) {
    final result = validate(value);
    return result == null ? null : errorMessage;
  }
}
