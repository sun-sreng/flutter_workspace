/// A [RegExp] object used to validate phone numbers using [phoneRegStr].
///
/// Use this to check whether a given string matches common international phone number formats.
RegExp phoneReg = RegExp(phoneRegStr);

/// A regular expression pattern used to validate international phone numbers.
///
/// This pattern supports optional leading `+`, optional parentheses around the
/// country/area code, and allows separators such as dashes, spaces, dots, or slashes.
///
/// Examples of valid formats:
/// - +1 234-567-8900
/// - (123) 456-7890
/// - 1234567890
/// - +44 20 7946 0958
String phoneRegStr = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
