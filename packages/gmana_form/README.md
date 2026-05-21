# gmana_form

Production-ready Flutter form building blocks for the Gmana ecosystem.

```dart
import 'package:gmana_form/gmana_form.dart';
```

## What You Get

- One generic text-field surface: `GTextField` + `GTextFieldConfig`.
- Friendly presets for common inputs: text, email, number, password, and confirm password.
- Typed validation powered by `gmana_validation`.
- A loading submit button that accepts either plain text or any custom child.

## Quick Start

```dart
final formKey = GlobalKey<FormState>();
final email = TextEditingController();
final password = TextEditingController();

Form(
  key: formKey,
  autovalidateMode: AutovalidateMode.onUserInteraction,
  child: Column(
    children: [
      GTextField.email(controller: email),
      const SizedBox(height: 12),
      GTextField.password(
        controller: password,
        validationConfig: PasswordValidationConfig.strong(),
      ),
      const SizedBox(height: 20),
      GSubmitButton.text(
        label: 'Sign in',
        loading: isSubmitting,
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            submit();
          }
        },
      ),
    ],
  ),
)
```

## Fields

Use `GTextFieldConfig` for anything custom:

```dart
GTextField(
  config: GTextFieldConfig(
    controller: notesController,
    label: 'Notes',
    hint: 'Optional',
    minLines: 3,
    maxLines: 6,
    textCapitalization: TextCapitalization.sentences,
    prefixIcon: Icons.notes,
    validator: (value) =>
        value == null || value.trim().isEmpty ? 'Required' : null,
  ),
)
```

Use preset constructors when the intent is common:

```dart
GTextField.text(
  controller: name,
  label: 'Full name',
  validationConfig: const TextValidationConfig(minLength: 2),
)

GTextField.email(
  controller: email,
  validationConfig: EmailValidationConfig.strict(),
)

GTextField.number(
  controller: age,
  label: 'Age',
  validationConfig: NumberValidationConfig.positiveInteger(min: 13, max: 120),
)

GTextField.password(
  controller: password,
  textInputAction: TextInputAction.next,
)

GTextField.confirmPassword(
  controller: confirmation,
  passwordController: password,
)
```

The preset widgets `GEmailField`, `GNumberField`, `GPasswordField`, and
`GConfirmPasswordField` are still exported for discoverability. They delegate to
the same `GTextField` preset constructors.

## Advanced Customization

Every preset accepts a `configure` hook so teams can keep the built-in defaults
and still modify config that is not exposed as a top-level constructor argument:

```dart
GTextField.email(
  controller: email,
  configure: (config) => config.copyWith(
    suffixIcon: IconButton(
      icon: const Icon(Icons.clear),
      onPressed: email.clear,
    ),
  ),
)
```

For custom validation, pass `validator`. It runs after the package validator:

```dart
GTextField.email(
  controller: email,
  validator: (value) {
    final domainAllowed = value?.endsWith('@company.com') ?? false;
    return domainAllowed ? null : 'Use your company email';
  },
)
```

## Submit Button

```dart
GSubmitButton.text(
  label: 'Create account',
  loading: isSubmitting,
  onPressed: isSubmitting ? null : submit,
)
```

For richer button content:

```dart
GSubmitButton(
  loading: isUploading,
  onPressed: upload,
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.cloud_upload),
      SizedBox(width: 8),
      Text('Upload'),
    ],
  ),
)
```

`GElevatedButton` remains available as a compatibility wrapper.

## Validator Adapter

`asFormValidator` adapts any `gmana_validation` validator to Flutter's
`FormField.validator` signature:

```dart
final validator = asFormValidator(
  validate: const EmailValidator().validate,
  resolve: resolveEmailValidationIssue,
);

TextFormField(validator: validator)
```

## Breaking Changes In This Refactor

- `GFieldConfig` has been replaced by `GTextFieldConfig`.
- Field labels use `label` and hints use `hint`.
- `validatorOverride` has been renamed to `validator`.
- `GTextField.text`, `.email`, `.number`, `.password`, and `.confirmPassword`
  are now the preferred high-level API.
- `GSubmitButton` is the preferred submit button API.
