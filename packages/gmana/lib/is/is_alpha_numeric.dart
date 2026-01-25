import 'package:gmana/regex/alpha_numeric_reg.dart';

/// check if the string [str] contains only letters and numbers
bool isAlphaNumeric(String str) {
  return alphaNumericReg.hasMatch(str);
}
