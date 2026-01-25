# gmana

GMana project for flutter widgets and other utilities for convenient develop and consistency.

## Installation

```bash
flutter pub add gmana
```

## Usage

```dart
import 'package:gmana/gmana.dart';

void main() {
  print('Grapheme clusters have varying length in the underlying representation'.toSentenceCase());
  print('Grapheme clusters have varying length in the underlying representation'.toTitleCase());
  print('12.9'.toDouble);
  print('1'.toInt);
  print(
    [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ].flatten().toString(),
  );
  print([1, 2, 3].sum().toString());
}
```
