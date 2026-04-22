/// Interface for field validators, separating validation logic from UI.
abstract class FieldValidator {
  /// Returns an error message when [value] is invalid, otherwise `null`.
  String? validate(String? value);
}
