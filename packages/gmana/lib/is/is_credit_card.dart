import 'package:gmana/regex/credit_card_reg.dart';

/// Validates whether the given string is a valid credit card number using the Luhn algorithm.
///
/// This function first sanitizes the input string by removing any non-numeric characters.
/// It then checks if the sanitized string matches the credit card format using a regular expression.
/// Finally, it employs the Luhn algorithm to verify the validity of the credit card number.
///
/// The Luhn algorithm involves doubling every second digit from right to left, and if this results
/// in a number greater than 9, subtracting 9 from it. The sum of all digits, after this transformation,
/// should be divisible by 10 for the number to be valid.
///
/// Returns `true` if the input string is a valid credit card number, otherwise returns `false`.

bool isCreditCard(String str) {
  final sanitized = str.replaceAll(RegExp('[^0-9]+'), '');
  if (!creditCardReg.hasMatch(sanitized)) {
    return false;
  }

  var sum = 0;
  String digit;
  var shouldDouble = false;

  for (var i = sanitized.length - 1; i >= 0; i--) {
    digit = sanitized.substring(i, i + 1);
    var tmpNum = int.parse(digit);

    if (shouldDouble == true) {
      tmpNum *= 2;
      if (tmpNum >= 10) {
        sum += (tmpNum % 10) + 1;
      } else {
        sum += tmpNum;
      }
    } else {
      sum += tmpNum;
    }
    shouldDouble = !shouldDouble;
  }

  return sum % 10 == 0;
}
