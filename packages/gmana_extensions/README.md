# gmana_extensions

Pure Dart extension methods for core Dart types.

## Extensions

- **Duration** — arithmetic, formatting (`HumanizedDuration`, `DurationNaturalLanguageX`)
- **num / int / double / bool** — nullability helpers, math utilities (`NumX`, `IntX`, `NumDurationExtension`, etc.)
- **String** — conversion, formatting, validation helpers (`StringX`, `StringNullableX`)
- **Iterable** — grouping, chunking, statistics (`IterableX`, `IterableNumX`, etc.)
- **Stream** — debounce, throttle, scan, operators (`StreamX`, `StreamListX`)

## Usage

```dart
import 'package:gmana_extensions/gmana_extensions.dart';

// Duration
final d = 5.seconds + 30.minutes;
print(d.toHuman()); // '30m 5s'

// String
print('hello world'.toTitleCase); // 'Hello World'

// Iterable
print([1, 2, 3].sum()); // 6
```
