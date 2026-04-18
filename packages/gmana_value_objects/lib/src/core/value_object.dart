import 'package:gmana/gmana.dart' show Either;
import 'validation_error.dart';

/// Base class for value objects.
/// T is the primitive type being wrapped.
abstract class ValueObject<T> {
  /// Creates a new [ValueObject].
  const ValueObject();

  /// The core evaluation of this value object, containing either
  /// the underlying value of type [T] or a [ValidationError].
  Either<ValidationError, T> get value;

  /// Returns `true` if this value object contains a valid value.
  bool get isValid => value.isRight();

  /// Returns `true` if this value object contains a validation error.
  bool get isInvalid => value.isLeft();

  /// The raw value if valid, or `null` if invalid.
  T? get valueOrNull => value.fold((_) => null, (r) => r);

  /// The [ValidationError] if invalid, or `null` if valid.
  ValidationError? get errorOrNull => value.fold((l) => l, (_) => null);

  /// Override this for sensitive data like passwords.
  /// If `true`, the value might be excluded from typical logging or to-string mechanisms.
  bool get isSensitive => false;
}
