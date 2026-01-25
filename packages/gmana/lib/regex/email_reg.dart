/// A [RegExp] object used to validate email addresses using [emailRegStr].
///
/// This object can be used to check whether a given string is a valid
/// email address by matching it against [emailRegStr].
RegExp emailReg = RegExp(emailRegStr);

/// A regular expression pattern used to validate email addresses.
///
/// This pattern matches most common valid email formats, including addresses
/// with alphanumeric characters, dots, underscores, and special characters
/// before the `@`, followed by a valid domain structure.
String emailRegStr =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
    r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
    r"(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
