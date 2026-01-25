/// This file contains a regular expression to match ASCII characters.
RegExp base64Reg = RegExp(base64RegStr);

/// A regular expression that matches any string containing only ASCII characters.
String base64RegStr =
    r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$';
