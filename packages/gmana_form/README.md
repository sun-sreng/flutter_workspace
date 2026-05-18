# gmana_form

Flutter form fields, validators, and submit controls for the Gmana ecosystem.

## Installation

```bash
flutter pub add gmana_form
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:gmana_form/gmana_form.dart';

final emailController = TextEditingController();

GEmailField(
  controller: emailController,
  labelText: 'Email',
);
```

`gmana_flutter` re-exports this package for compatibility, but new code can
import `gmana_form` directly.
