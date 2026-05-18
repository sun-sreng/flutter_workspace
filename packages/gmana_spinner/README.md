# gmana_spinner

Flutter loading spinner widgets for the Gmana ecosystem.

## Installation

```bash
flutter pub add gmana_spinner
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:gmana_spinner/gmana_spinner.dart';

const GCircularSpinner();
const GLinearSpinner();
const GDotSpinner(color: Colors.blue);
const GWaveDotSpinner(size: 24, color: Colors.blue);
const GBarWaveSpinner(color: Colors.blue);
const SizedBox(
  width: 48,
  height: 48,
  child: GWaveSpinner(color: Colors.blue),
);
```

## API

| Widget | Use it for |
| --- | --- |
| `GCircularSpinner` | Centered Material circular loading indicator. |
| `GLinearSpinner` | Material linear loading indicator. |
| `GDotSpinner` | Pulsing dot loader with custom dot builders. |
| `GWaveDotSpinner` | Wave-like dot loader. |
| `GBarWaveSpinner` | Bar-style wave loader. |
| `GWaveSpinner` | Circular arc loader with optional wave fill and centered child. |

`gmana_flutter` re-exports these widgets for compatibility, but new code can
import `gmana_spinner` directly.
