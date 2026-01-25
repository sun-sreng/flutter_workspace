/// A [RegExp] object used to check if a string contains only special characters.
///
/// Uses the [specialCharReg] pattern to perform the match.
RegExp specialCharReg = RegExp(specialCharStr);

/// A regular expression pattern that matches strings containing only special characters.
///
/// This pattern allows one or more of the following characters:
/// `! @ # $ % ^ & * ( ) , . ? " : { } | < >`
///
/// Note: It will **not** match strings that contain letters, digits, or whitespace.
String specialCharStr = r'^[!@#$%^&*(),.?":{}|<>]+$';
