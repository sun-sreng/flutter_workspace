import 'five_digit.dart';
import 'four_digit.dart';
import 'six_digit.dart';
import 'three_digit.dart';

/// A map of ISO 3166-1 alpha-2 country codes to their postal code regular expression patterns.
///
/// This map is useful for validating postal/ZIP codes based on country-specific formats.
/// Common patterns are imported from helper files (`three_digit.dart`, `four_digit.dart`, etc.)
Map<String, RegExp> postalCodePatterns = {
  /// Andorra: Starts with "AD" followed by 3 digits (e.g., AD100)
  'AD': RegExp(r'^AD\d{3}$'),

  /// Austria, Australia, Belgium, Bulgaria, Denmark, Hungary, Luxembourg, Norway,
  /// Slovenia, Tunisia, South Africa: 4-digit postal codes
  'AT': fourDigit,
  'AU': fourDigit,
  'BE': fourDigit,
  'BG': fourDigit,
  'DK': fourDigit,
  'HU': fourDigit,
  'LU': fourDigit,
  'NO': fourDigit,
  'SI': fourDigit,
  'TN': fourDigit,
  'ZA': fourDigit,

  /// Canada: Alphanumeric format (e.g., K1A 0B1), optional space or hyphen
  'CA': RegExp(
    r'^[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][\s\-]?\d[ABCEGHJ-NPRSTV-Z]\d$',
    caseSensitive: false,
  ),

  /// Czech Republic, Greece, Slovakia, Sweden: 3 digits + optional space + 2 digits (e.g., 123 45)
  'CZ': RegExp(r'^\d{3}\s?\d{2}$'),
  'GR': RegExp(r'^\d{3}\s?\d{2}$'),
  'SK': RegExp(r'^\d{3}\s?\d{2}$'),
  'SE': RegExp(r'^\d{3}\s?\d{2}$'),

  /// Germany, Algeria, Estonia, Spain, Finland, Italy, Indonesia, Israel, India, Mexico, Poland,
  /// Romania, Russia, Saudi Arabia, Ukraine, Zambia: 5- or 6-digit numeric postal codes
  'DE': fiveDigit,
  'DZ': fiveDigit,
  'EE': fiveDigit,
  'ES': fiveDigit,
  'FI': fiveDigit,
  'IT': fiveDigit,
  'ID': fiveDigit,
  'IL': fiveDigit,
  'IN': sixDigit,
  'MX': fiveDigit,
  'PL': RegExp(r'^\d{2}\-\d{3}$'),
  'RO': sixDigit,
  'RU': sixDigit,
  'SA': fiveDigit,
  'UA': fiveDigit,
  'ZM': fiveDigit,

  /// France: 2 digits + optional space + 3 digits (e.g., 75 008)
  'FR': RegExp(r'^\d{2}\s?\d{3}$'),

  /// United Kingdom: Complex alphanumeric format, includes special case for "GIR 0AA"
  'GB': RegExp(
    r'^(gir\s?0aa|[a-z]{1,2}\d[\da-z]?\s?(\d[a-z]{2})?)$',
    caseSensitive: false,
  ),

  /// Croatia: 5-digit codes starting from 1 to 5 (e.g., 10000–59999)
  'HR': RegExp(r'^([1-5]\d{4}$)'),

  /// Iceland: 3-digit codes (e.g., 101)
  'IS': threeDigit,

  /// Japan: 3 digits + hyphen + 4 digits (e.g., 123-4567)
  'JP': RegExp(r'^\d{3}\-\d{4}$'),

  /// Kenya, Comoros: 5-digit numeric codes
  'KE': fiveDigit,
  'KM': fiveDigit,

  /// Liechtenstein: Only codes from 9485 to 9497
  'LI': RegExp(r'^(948[5-9]|949[0-7])$'),

  /// Lithuania, Latvia: Prefix with country code + dash (e.g., LT-12345)
  'LT': RegExp(r'^LT\-\d{5}$'),
  'LV': RegExp(r'^LV\-\d{4}$'),

  /// Netherlands: 4 digits + optional space + 2 letters (e.g., 1234 AB)
  'NL': RegExp(r'^\d{4}\s?[a-z]{2}$', caseSensitive: false),

  /// Portugal: 4 digits + dash + 3 digits (e.g., 1234-567)
  'PT': RegExp(r'^\d{4}\-\d{3}?$'),

  /// Taiwan: 3 digits optionally followed by 2 more digits (e.g., 100 or 10045)
  'TW': RegExp(r'^\d{3}(\d{2})?$'),

  /// United States: 5-digit ZIP or ZIP+4 format (e.g., 12345 or 12345-6789)
  'US': RegExp(r'^\d{5}(-\d{4})?$'),
};
