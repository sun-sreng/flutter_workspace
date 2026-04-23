// ignore_for_file: public_member_api_docs

import '../either/left.dart';
import '../either/right.dart';
import 'validation_issue.dart';

/// Configuration for number validation.
final class NumberValidationConfig {
  /// Minimum allowed value.
  final num? min;

  /// Maximum allowed value.
  final num? max;

  /// Whether negative values are allowed.
  final bool allowNegative;

  /// Whether only whole numbers are allowed.
  final bool integerOnly;

  /// Maximum allowed decimal places.
  final int? maxDecimalPlaces;

  /// Creates a number validation config.
  const NumberValidationConfig({
    this.min,
    this.max,
    this.allowNegative = true,
    this.integerOnly = false,
    this.maxDecimalPlaces,
  });

  /// Preset for positive integers.
  factory NumberValidationConfig.positiveInteger({num? min, num? max}) {
    return NumberValidationConfig(
      min: min,
      max: max,
      allowNegative: false,
      integerOnly: true,
    );
  }
}

/// Base type for number validation failures.
sealed class NumberValidationIssue extends ValidationIssue {
  const NumberValidationIssue();
}

/// Number input is empty.
final class NumberEmptyIssue extends NumberValidationIssue {
  const NumberEmptyIssue();

  @override
  String get code => 'number.empty';
}

/// Number input is malformed.
final class NumberInvalidFormatIssue extends NumberValidationIssue {
  const NumberInvalidFormatIssue();

  @override
  String get code => 'number.invalidFormat';
}

/// Negative values are not allowed.
final class NumberNegativeNotAllowedIssue extends NumberValidationIssue {
  final num currentValue;

  const NumberNegativeNotAllowedIssue(this.currentValue);

  @override
  String get code => 'number.negativeNotAllowed';
}

/// A whole number is required.
final class NumberNotIntegerIssue extends NumberValidationIssue {
  final num currentValue;

  const NumberNotIntegerIssue(this.currentValue);

  @override
  String get code => 'number.notInteger';
}

/// Number is smaller than the allowed minimum.
final class NumberTooSmallIssue extends NumberValidationIssue {
  final num currentValue;
  final num minValue;

  const NumberTooSmallIssue({
    required this.currentValue,
    required this.minValue,
  });

  @override
  String get code => 'number.tooSmall';
}

/// Number is larger than the allowed maximum.
final class NumberTooLargeIssue extends NumberValidationIssue {
  final num currentValue;
  final num maxValue;

  const NumberTooLargeIssue({
    required this.currentValue,
    required this.maxValue,
  });

  @override
  String get code => 'number.tooLarge';
}

/// Number has too many decimal places.
final class NumberDecimalPlacesExceededIssue extends NumberValidationIssue {
  final int currentPlaces;
  final int maxPlaces;

  const NumberDecimalPlacesExceededIssue({
    required this.currentPlaces,
    required this.maxPlaces,
  });

  @override
  String get code => 'number.decimalPlacesExceeded';
}

/// Default English messages for number validation issues.
String resolveNumberValidationIssue(NumberValidationIssue issue) {
  return switch (issue) {
    NumberEmptyIssue() => 'Please enter a number',
    NumberInvalidFormatIssue() => 'Please enter a valid number',
    NumberNegativeNotAllowedIssue() => 'Negative numbers are not allowed',
    NumberNotIntegerIssue() => 'Please enter a whole number',
    NumberTooSmallIssue(:final minValue) => 'Number must be at least $minValue',
    NumberTooLargeIssue(:final maxValue) => 'Number must be at most $maxValue',
    NumberDecimalPlacesExceededIssue(:final maxPlaces) =>
      'Number must have at most $maxPlaces decimal places',
  };
}

/// Canonical validator for number inputs.
final class NumberValidator {
  /// Rules used during validation.
  final NumberValidationConfig config;

  /// Creates a number validator.
  const NumberValidator([this.config = const NumberValidationConfig()]);

  /// Validates and parses a number.
  ValidationResult<NumberValidationIssue, num> validate(String input) {
    final trimmed = input.trim();

    if (trimmed.isEmpty) {
      return const Left(NumberEmptyIssue());
    }

    final parsed = num.tryParse(trimmed);
    if (parsed == null) {
      return const Left(NumberInvalidFormatIssue());
    }

    if (!config.allowNegative && parsed < 0) {
      return Left(NumberNegativeNotAllowedIssue(parsed));
    }

    if (config.integerOnly && parsed != parsed.toInt()) {
      return Left(NumberNotIntegerIssue(parsed));
    }

    if (config.min != null && parsed < config.min!) {
      return Left(
        NumberTooSmallIssue(currentValue: parsed, minValue: config.min!),
      );
    }

    if (config.max != null && parsed > config.max!) {
      return Left(
        NumberTooLargeIssue(currentValue: parsed, maxValue: config.max!),
      );
    }

    if (config.maxDecimalPlaces != null) {
      final decimalPlaces = _countDecimalPlaces(trimmed);
      if (decimalPlaces > config.maxDecimalPlaces!) {
        return Left(
          NumberDecimalPlacesExceededIssue(
            currentPlaces: decimalPlaces,
            maxPlaces: config.maxDecimalPlaces!,
          ),
        );
      }
    }

    return Right(parsed);
  }

  int _countDecimalPlaces(String value) {
    final decimalIndex = value.indexOf('.');
    if (decimalIndex == -1) {
      return 0;
    }
    return value.length - decimalIndex - 1;
  }
}
