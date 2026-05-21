## Unreleased

- Breaking: replaced `GFieldConfig` with `GTextFieldConfig`.
- Breaking: renamed field constructor labels from `labelText`/`hintText` to
  `label`/`hint`.
- Breaking: renamed field-level custom validation from `validatorOverride` to
  `validator`.
- Added `GTextField` preset constructors for text, email, number, password, and
  confirm-password fields.
- Added `GSubmitButton` with custom child support and a text convenience
  factory.
- Added `GFormController` and `GForm` for simpler form lifecycle, validation,
  save, reset, and named text-controller management.
- Added `GFormController.submit` with loading state and duplicate-submit
  protection.
- Added `GFormSubmitButton` for controller-aware async submit flows.
- Added named field binding through `GTextFieldConfig.name` and preset `name`
  parameters. Fields inside `GForm` can now resolve their controller
  automatically.
- Added `passwordName` to confirm-password fields so named forms can validate
  password confirmation without manually requesting the password controller.
- Added optional controller support via `initialValue` for simpler forms.
- Added autofill, obscure-text, autocorrect, suggestions, prefix, suffix, and
  suffix-icon configuration to `GTextFieldConfig`.
- Removed unused `InputFormatterProvider`.
- Simplified field widgets to use `StatelessWidget` directly instead of a package-specific base class.
- Added common `TextFormField` passthrough options to the named field widgets.

## 0.0.1

- Extracted form widgets, fields, and validators from `gmana_flutter`.
