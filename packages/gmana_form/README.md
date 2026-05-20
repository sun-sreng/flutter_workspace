# gmana_form

Flutter form fields, validators, and submit controls for the Gmana ecosystem.

```dart
import 'package:gmana_form/gmana_form.dart';
```

`gmana_flutter` re-exports this package for compatibility — existing code needs no changes.

---

## Table of contents

- [Fields](#fields)
- [Button](#button)
- [Low-level config](#low-level-config)
- [Confirm-password validator](#confirm-password-validator)
- [Form validator adapter](#form-validator-adapter)
- [Full example](#full-example)

---

## Fields

All fields wrap `TextFormField` with consistent defaults, built-in validation from `gmana_validation`, and sensible keyboard/action defaults.

### `GEmailField`

```dart
GEmailField(
  controller: emailController,
  labelText: 'Email',
)
```

```dart
// All options
GEmailField(
  controller: emailController,
  labelText: 'Work Email',
  hintText: 'you@company.com',
  prefixIcon: Icons.business,
  textInputAction: TextInputAction.next,
  validationConfig: EmailValidationConfig(allowEmpty: false),
  onChanged: (value) => print(value),
  validatorOverride: (v) => v != null && v.endsWith('@company.com')
      ? null
      : 'Must be a company email',
)
```

### `GPasswordField`

```dart
GPasswordField(
  controller: passwordController,
)
```

```dart
// With strength config
GPasswordField(
  controller: passwordController,
  labelText: 'New Password',
  hintText: 'At least 8 characters',
  textInputAction: TextInputAction.next,
  validationConfig: PasswordValidationConfig.strong(),
  onChanged: (value) => updateStrengthIndicator(value),
)
```

### `GConfirmPasswordField`

Automatically validates that the confirmation matches the original password controller's current value.

```dart
GConfirmPasswordField(
  controller: confirmController,
  passwordController: passwordController,
)
```

```dart
// All options
GConfirmPasswordField(
  controller: confirmController,
  passwordController: passwordController,
  labelText: 'Re-enter Password',
  hintText: 'Must match above',
  textInputAction: TextInputAction.done,
  validationConfig: ConfirmPasswordValidationConfig(
    requireConfirmation: true,
    trimWhitespace: true,
  ),
)
```

### `GTextField`

General-purpose text field with optional text validation.

```dart
GTextField(
  controller: nameController,
  labelText: 'Display Name',
)
```

```dart
// With validation and formatting
GTextField(
  controller: bioController,
  labelText: 'Bio',
  hintText: 'Tell us about yourself',
  prefixIcon: Icons.info_outline,
  validationConfig: TextValidationConfig(minLength: 10, maxLength: 200),
  validatorOverride: (v) => v != null && v.contains('http')
      ? 'No URLs allowed'
      : null,
  onChanged: (value) => setState(() => charCount = value.length),
)
```

### `GNumberField`

Number-only field. Keyboard type is auto-configured from the validation config.

```dart
GNumberField(
  controller: ageController,
  labelText: 'Age',
)
```

```dart
// With range and decimal config
GNumberField(
  controller: priceController,
  labelText: 'Price',
  hintText: '0.00',
  textInputAction: TextInputAction.done,
  validationConfig: NumberValidationConfig(
    allowDecimal: true,
    allowNegative: false,
    min: 0,
    max: 9999,
  ),
  onChanged: (value) => updateTotal(value),
)
```

---

## Button

### `GElevatedButton`

Elevated button with a built-in loading spinner. Pass `isLoading: true` and `onPressed: null` while async work runs to disable the button and show the spinner.

```dart
GElevatedButton(
  text: 'Sign In',
  isLoading: false,
  onPressed: signIn,
)
```

```dart
// Full options
GElevatedButton(
  text: 'Upload',
  isLoading: isUploading,
  onPressed: isUploading ? null : upload,
  loadingColor: Colors.white,
  loadingSize: 20.0,
  textStyle: const TextStyle(fontSize: 16, letterSpacing: 0.5),
)
```

```dart
// Typical stateful usage
bool _saving = false;

Future<void> _save() async {
  setState(() => _saving = true);
  await repository.save(data);
  setState(() => _saving = false);
}

GElevatedButton(
  text: 'Save',
  isLoading: _saving,
  onPressed: _saving ? null : _save,
)
```

---

## Low-level config

Use `GFieldConfig` + `GConfiguredTextFormField` when you need a `TextFormField` that doesn't fit the named field widgets.

### `GFieldConfig`

```dart
GFieldConfig(
  controller: controller,
  labelText: 'Username',
  hintText: '@handle',
  prefixIcon: Icons.alternate_email,
  validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
)
```

```dart
// All options
GFieldConfig(
  controller: controller,
  labelText: 'Notes',
  hintText: 'Optional notes…',
  keyboardType: TextInputType.multiline,
  textInputAction: TextInputAction.newline,
  minLines: 3,
  maxLines: 6,
  maxLength: 500,
  textCapitalization: TextCapitalization.sentences,
  readOnly: false,
  enabled: true,
  focusNode: notesFocus,
  autovalidateMode: AutovalidateMode.onUserInteraction,
  prefixIcon: Icons.notes,
  style: const TextStyle(fontSize: 14),
  validator: (v) => null,
  onChanged: (v) {},
  onFieldSubmitted: (v) {},
  onSaved: (v) {},
)
```

### `GConfiguredTextFormField`

Renders a `GFieldConfig` as a `TextFormField`. Use directly for non-password fields, or pair with `GObscurableTextFormField` for password-style fields.

```dart
GConfiguredTextFormField(
  config: GFieldConfig(
    controller: controller,
    labelText: 'Display Name',
    prefixIcon: Icons.person,
    validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
  ),
)
```

```dart
// With a custom suffix widget
GConfiguredTextFormField(
  config: config,
  obscureText: false,
  suffixIcon: IconButton(
    icon: const Icon(Icons.clear),
    onPressed: controller.clear,
  ),
)
```

### `GObscurableTextFormField`

A `GConfiguredTextFormField` that includes a built-in visibility toggle for password-style fields.

```dart
GObscurableTextFormField(
  config: GFieldConfig(
    controller: secretController,
    labelText: 'API Key',
    prefixIcon: Icons.key,
  ),
)
```

### `VisibilityToggle`

A standalone eye-icon button for toggling text visibility. Provided for cases where you build a custom obscurable field.

```dart
VisibilityToggle(
  onVisibilityChanged: (isObscured) {
    setState(() => _obscure = isObscured);
  },
)
```

---

## Confirm-password validator

Use the validator directly when you need confirm-password logic outside a `GConfirmPasswordField`.

### `ConfirmPasswordValidationConfig`

```dart
const ConfirmPasswordValidationConfig()                    // default — requires confirmation, no trim
const ConfirmPasswordValidationConfig(trimWhitespace: true) // trims before comparing
const ConfirmPasswordValidationConfig(requireConfirmation: false) // allows empty confirmation
```

### `ConfirmPasswordValidator`

```dart
const validator = ConfirmPasswordValidator();

final result = validator.validate(
  password: 'MySecret1!',
  confirmation: 'MySecret1!',
);

result.fold(
  (issue) => switch (issue) {
    ConfirmPasswordEmptyIssue() => 'Please confirm your password',
    ConfirmPasswordMismatchIssue() => 'Passwords do not match',
  },
  (value) => print('Valid: $value'),
);
```

### `resolveConfirmPasswordValidationIssue`

Returns a default English error string for any `ConfirmPasswordValidationIssue`:

```dart
resolveConfirmPasswordValidationIssue(ConfirmPasswordEmptyIssue());    // 'Please confirm your password.'
resolveConfirmPasswordValidationIssue(ConfirmPasswordMismatchIssue()); // 'Passwords do not match.'
```

---

## Form validator adapter

`asFormValidator` bridges any `gmana_validation` validator into a Flutter `FormField.validator` function.

```dart
final emailValidator = asFormValidator(
  validate: (input) => EmailValidator().validate(input),
  resolve: resolveEmailValidationIssue,
);

TextFormField(validator: emailValidator)
```

```dart
// With an additional custom check on top of the canonical validator
final validator = asFormValidator(
  validate: (input) => EmailValidator().validate(input),
  resolve: resolveEmailValidationIssue,
  validatorOverride: (v) => v != null && v.endsWith('@blocked.com')
      ? 'This domain is not allowed'
      : null,
);
```

---

## Full example

```dart
import 'package:flutter/material.dart';
import 'package:gmana_form/gmana_form.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _age = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _age.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2)); // replace with real call
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          GTextField(
            controller: _name,
            labelText: 'Full Name',
            prefixIcon: Icons.person,
            validationConfig: TextValidationConfig(minLength: 2),
          ),
          const SizedBox(height: 16),
          GEmailField(
            controller: _email,
            labelText: 'Email',
          ),
          const SizedBox(height: 16),
          GPasswordField(
            controller: _password,
            validationConfig: PasswordValidationConfig.strong(),
          ),
          const SizedBox(height: 16),
          GConfirmPasswordField(
            controller: _confirm,
            passwordController: _password,
          ),
          const SizedBox(height: 16),
          GNumberField(
            controller: _age,
            labelText: 'Age',
            validationConfig: NumberValidationConfig(min: 13, max: 120),
          ),
          const SizedBox(height: 24),
          GElevatedButton(
            text: 'Create Account',
            isLoading: _loading,
            onPressed: _loading ? null : _submit,
          ),
        ],
      ),
    );
  }
}
```
