# gmana

`gmana` is a core Dart utility package that provides a rich collection of extensions, validation utilities, and functional programming constructs (like `Either` and `UseCase` patterns) designed for consistency and accelerated development.

> **Note:** This package is pure Dart and can be used in any Dart or Flutter project. For Flutter-specific widgets and utilities, please see `gmana_flutter`.

## Installation

Add `gmana` to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  gmana: ^0.1.2 # Please check pub.dev for the latest version
```

Or install it via CLI:

```bash
dart pub add gmana
# or
flutter pub add gmana
```

## Features

- **Functional Programming**
  - Robust `Either` implementation (`Left` / `Right`) for safe error handling.
  - `UseCase` abstractions for clean architecture boundaries.
- **Extensions**
  - Powerful `String` extensions (e.g., `.toSentenceCase()`, `.toTitleCase()`, `.toInt()`, `.toDouble()`).
  - `Iterable` and `List` extensions (e.g., `.flatten()`, `.sum()`).
  - `num` and `Duration` extensions for convenient time processing.
  - `Stream` and type-checking utilities.
- **Validation Utilities**
  - String extensions for built-in validation (e.g., `.isValidEmail`, `.isValidPhone`, `.isValidName`, `.isValidPassword`).
  - Comprehensive regex patterns for advanced matching (UUIDs, IP addresses, credit cards, Base64, Hex colors).
- **Other Utilities**
  - General utility classes including generators (e.g., `id_generator`).

## Usage Examples

```dart
import 'package:gmana/gmana.dart';

void main() {
  // String Extensions
  print('hello world'.toTitleCase()); // "Hello World"
  print('hello world'.toSentenceCase()); // "Hello world"
  
  // Parsing
  print('12.9'.toDouble); // 12.9
  print('42'.toInt); // 42
  
  // Iterable/List utilities
  final nested = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ];
  print(nested.flatten().toList()); // [1, 2, 3, 4, 5, 6, 7, 8, 9]
  print([1, 2, 3].sum()); // 6
  
  // Validators via String Extensions
  print('test@example.com'.isValidEmail); // true
  print('password123'.isValidPassword); // false (needs symbol and uppercase)
  
  // Functional Error Handling (Either)
  final Either<String, int> result = Right(42);
  result.fold(
    (left) => print('Error: $left'),
    (right) => print('Success: $right'),
  );
}
```
