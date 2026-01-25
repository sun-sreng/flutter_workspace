/// Interface for field validators, separating validation logic from UI.
abstract class FieldValidator {
  String? validate(String? value);
}
