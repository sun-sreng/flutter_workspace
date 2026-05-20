# gmana_utils

Pure Dart utilities for debouncing, throttling, and ID generation.

```dart
import 'package:gmana_utils/gmana_utils.dart';
```

---

## Table of contents

- [Debouncer](#debouncer)
- [Throttler](#throttler)
- [IdGenerator](#idgenerator)

---

## Debouncer

Delays execution until a quiet period has elapsed. Each call to `run()` resets the timer — only the **last** call fires.

Use this for search fields, resize handlers, or any input that fires faster than you want to react.

```dart
final debouncer = Debouncer();          // 150 ms default
final debouncer = Debouncer(300);       // custom window
```

### Quick start

```dart
final _search = Debouncer(400);

void onSearchChanged(String query) {
  _search.run(() => performSearch(query));
}

// Only one API call fires — 400 ms after the user stops typing.
```

### Lifecycle

```dart
class _SearchState extends State<SearchPage> {
  final _debouncer = Debouncer(400);

  @override
  void dispose() {
    _debouncer.dispose(); // cancels any pending timer
    super.dispose();
  }

  void _onChanged(String q) => _debouncer.run(() => _fetch(q));
}
```

### Parameters

| Parameter      | Type  | Default                      |
| -------------- | ----- | ---------------------------- |
| `milliseconds` | `int` | `kDefaultDebounceTime` (150) |

### API

| Method        | Description                                             |
| ------------- | ------------------------------------------------------- |
| `run(action)` | Resets the timer; `action` fires after the quiet period |
| `dispose()`   | Cancels any pending timer immediately                   |

> **Ownership**: you own the `Debouncer` — always call `dispose()` when done.

---

## Throttler

Executes immediately on the first call, then **suppresses** subsequent calls for the duration of the window. The opposite of debounce — **run-first** semantics.

Use this for scroll listeners, button guards, or rapid-fire events where you want the first action to go through but subsequent duplicates dropped.

```dart
final throttler = Throttler();          // 300 ms default
final throttler = Throttler(500);       // custom window
```

### Quick start

```dart
final _save = Throttler(1000);

void onSavePressed() {
  _save.run(() => saveDocument()); // fires immediately; next call within 1 s is ignored
}
```

### Scroll listener example

```dart
final _onScroll = Throttler(100);

NotificationListener<ScrollNotification>(
  onNotification: (notification) {
    _onScroll.run(() => _updateHeader(notification.metrics.pixels));
    return false;
  },
  child: ListView(...),
)
```

### Lifecycle

```dart
@override
void dispose() {
  _throttler.dispose(); // clears the active window timer
  super.dispose();
}
```

### Parameters

| Parameter      | Type  | Default                          |
| -------------- | ----- | -------------------------------- |
| `milliseconds` | `int` | `kDefaultThrottleDuration` (300) |

### API

| Method        | Description                                                          |
| ------------- | -------------------------------------------------------------------- |
| `run(action)` | Runs `action` immediately if idle; no-op if within the active window |
| `dispose()`   | Cancels the active window timer                                      |

### Debounce vs Throttle at a glance

| Behavior           | `Debouncer`                            | `Throttler`                       |
| ------------------ | -------------------------------------- | --------------------------------- |
| When does it fire? | After the **last** call + quiet period | On the **first** call immediately |
| Rapid calls        | Only the last survives                 | First fires; rest are dropped     |
| Good for           | Search fields, resize handlers         | Scroll events, button guards      |

---

## IdGenerator

All-static class for generating various ID formats. No instantiation needed.

```dart
import 'package:gmana_utils/gmana_utils.dart';

final id = IdGenerator.nanoid();
```

> **Security notice**: `IdGenerator` uses Dart's non-cryptographic `Random`. Do **not** use these IDs for security-sensitive purposes (tokens, secrets, session keys). Use `dart:math`'s `Random.secure()` or a dedicated crypto library instead.

---

### `nanoid`

Generates a URL-safe random string using the NanoID alphabet (`A–Za–z0–9_-`).

```dart
IdGenerator.nanoid()          // 21-character ID (default)
IdGenerator.nanoid(size: 10)  // shorter ID
IdGenerator.nanoid(size: 36)  // longer ID
```

```dart
// Example outputs
// 'V1StGXR8_Z5jdHi6B-myT'
// 'K9vF2xQm3p'
```

| Parameter | Type  | Default |
| --------- | ----- | ------- |
| `size`    | `int` | `21`    |

---

### `randomString`

Generates a random string from a configurable character set.

```dart
// Default — letters and numbers, length 16
IdGenerator.randomString()

// Numbers only, 6 digits (PIN-style)
IdGenerator.randomString(length: 6, useLetters: false, useNumbers: true, useSymbols: false)

// Letters only
IdGenerator.randomString(length: 12, useLetters: true, useNumbers: false)

// All character types
IdGenerator.randomString(length: 20, useLetters: true, useNumbers: true, useSymbols: true)
```

| Parameter    | Type   | Default |
| ------------ | ------ | ------- |
| `length`     | `int`  | `16`    |
| `useLetters` | `bool` | `true`  |
| `useNumbers` | `bool` | `true`  |
| `useSymbols` | `bool` | `false` |

---

### `timestampId`

Generates a time-ordered ID prefixed with `G`, combining the current epoch milliseconds with a random suffix. Lexicographically sortable by creation time.

```dart
final id = IdGenerator.timestampId();
// 'G1716220800000-k9vF2xQm'
```

Useful for document keys where insertion order matters (logs, events, audit trails).

---

### `uuidV4Like`

Generates a UUID v4-**shaped** string (`xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`). The format is correct but the randomness uses `Random`, **not** `Random.secure()` — do not rely on this for cryptographic uniqueness.

```dart
final id = IdGenerator.uuidV4Like();
// 'f47ac10b-58cc-4372-a567-0e02b2c3d479'
```

> **Deprecated**: `uuidV1()` has been removed — use `uuidV4Like()` instead.

---

### `encodeToBase64`

Encodes a `List<Object?>` to a Base64 string via JSON. Useful for embedding structured data in URLs or cookies. This is encoding, **not** encryption — the data is trivially reversible.

```dart
final token = IdGenerator.encodeToBase64(['user-123', 'admin', 1716220800]);
// 'WyJ1c2VyLTEyMyIsImFkbWluIiwxNzE2MjIwODAwXQ=='

// Decode: base64Decode → utf8.decode → jsonDecode
```

---

### ID format comparison

| Method           | Example output                         | Sortable | Use case                         |
| ---------------- | -------------------------------------- | -------- | -------------------------------- |
| `nanoid()`       | `V1StGXR8_Z5jdHi6B-myT`                | no       | Short unique keys, URLs          |
| `randomString()` | `aB3xK9mZ`                             | no       | PINs, codes, tokens              |
| `timestampId()`  | `G1716220800000-k9vF2xQm`              | yes      | Logs, events, ordered records    |
| `uuidV4Like()`   | `f47ac10b-58cc-4372-a567-0e02b2c3d479` | no       | Interop with UUID-expecting APIs |
| `encodeToBase64` | `WyJ1c2VyLTEyMyIsImFkbWluIl0=`         | no       | Structured data in URLs          |
