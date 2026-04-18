/// RFC 5321/5322 local-part characters before `@`.
/// Domain requires at least one `.` with a 2+ char TLD.
const String emailRegStr =
    r'^[a-zA-Z0-9.!#$%&'
    "'"
    r'*+/=?^_`{|}~-]+'
    r'@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?'
    r'(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*'
    r'\.[a-zA-Z]{2,}$';

/// A compiled [RegExp] object for validating email addresses using [emailRegStr].
final RegExp emailReg = RegExp(emailRegStr);
