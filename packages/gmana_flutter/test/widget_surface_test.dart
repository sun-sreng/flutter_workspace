import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmana/validation.dart' hide isNull;
import 'package:gmana_flutter/gmana_flutter.dart';

void main() {
  group('public entrypoint', () {
    test('exports design tokens, extensions, services, and helpers', () {
      expect(GColors.primary, const Color(0xFFF57224));
      expect(GFontWeight.bold, FontWeight.w700);
      expect(Breakpoints.tablet, 730);
      expect(ThemeMode.dark.toLabel(), 'Dark Mode');
      expect('system'.toThemeMode(), ThemeMode.system);
      expect('#F57224'.toColor(), GColors.primary);
      expect(GColors.primary.toHexRGB(), '#F57224');
      expect(GColors.primary.contrastText, Colors.black);
      expect(ColorService.tryParseHex('#F57224'), GColors.primary);
      expect(fromLocale(const Locale('en', 'US')), 'en_US');
      expect(toLocale('km_KH'), const Locale('km', 'KH'));
      expect(const TimeOfDay(hour: 13, minute: 5).toCustomString(), '01:05 PM');

      final json = Icons.home.toJsonString();
      expect(IconDataExt.tryParse(json)?.codePoint, Icons.home.codePoint);
    });

    testWidgets('BuildContext helpers work together from the main import', (
      tester,
    ) async {
      late Size screenSize;
      late int columns;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              screenSize = context.screenSize;
              columns = context.responsive(mobile: 1, tablet: 2, desktop: 3);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(
        screenSize,
        tester.view.physicalSize / tester.view.devicePixelRatio,
      );
      expect(columns, 2);
    });
  });

  group('form widgets', () {
    testWidgets('GConfiguredTextFormField wires config into TextFormField', (
      tester,
    ) async {
      final controller = TextEditingController();
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GConfiguredTextFormField(
              config: GFieldConfig(
                controller: controller,
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icons.email,
                onChanged: (value) => changedValue = value,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'user@example.com');

      final field = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(field.controller, same(controller));
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).obscureText,
        isFalse,
      );
      expect(changedValue, 'user@example.com');
    });

    testWidgets('GEmailField uses the default email validator', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: GEmailField(
                controller: controller,
                labelText: 'Email Address',
              ),
            ),
          ),
        ),
      );

      final field = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(field.validator?.call(null), 'Please enter an email address');
      expect(
        field.validator?.call('invalid-email'),
        'Please enter a valid email address',
      );
      expect(field.validator?.call('user@example.com'), isNull);
    });

    testWidgets('GPasswordField composes the obscurable field behavior', (
      tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: GPasswordField(controller: controller)),
        ),
      );

      expect(
        tester.widget<EditableText>(find.byType(EditableText)).obscureText,
        isTrue,
      );

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(
        tester.widget<EditableText>(find.byType(EditableText)).obscureText,
        isFalse,
      );
    });

    testWidgets('GPasswordField uses the strong validator by default', (
      tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(child: GPasswordField(controller: controller)),
          ),
        ),
      );

      final field = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(field.validator?.call('weak'), 'Minimum 8 characters');
      expect(field.validator?.call('NoDigitsHere!'), 'At least one number');
      expect(field.validator?.call('StrongP@ssw0rd'), isNull);
    });

    testWidgets('GPasswordField accepts custom password configs', (
      tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: GPasswordField(
                controller: controller,
                validationConfig: PasswordValidationConfig.lenient(),
              ),
            ),
          ),
        ),
      );

      final field = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(field.validator?.call('abcd'), isNull);
    });

    testWidgets('GNumberField uses canonical number validation', (
      tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: GNumberField(controller: controller, labelText: 'Age'),
            ),
          ),
        ),
      );

      final field = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(field.validator?.call(''), 'Please enter a number');
      expect(field.validator?.call('12.5'), 'Please enter a whole number');
      expect(field.validator?.call('12'), isNull);
    });

    testWidgets('GTextField uses text validator configs', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: GTextField(
                controller: controller,
                labelText: 'Username',
                validationConfig: TextValidationConfig.required(
                  trimWhitespace: true,
                  minLength: 3,
                ),
              ),
            ),
          ),
        ),
      );

      final field = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(field.validator?.call('  '), 'This field is required');
      expect(field.validator?.call('ab'), 'Please enter at least 3 characters');
      expect(field.validator?.call('abc'), isNull);
    });

    testWidgets('GConfirmPasswordField enforces required and match rules', (
      tester,
    ) async {
      final passwordController = TextEditingController(text: 'StrongP@ssw0rd');
      final confirmController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: GConfirmPasswordField(
                controller: confirmController,
                passwordController: passwordController,
              ),
            ),
          ),
        ),
      );

      final field = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(field.validator?.call(''), 'Please confirm your password');
      expect(field.validator?.call('wrong'), 'Passwords do not match');
      expect(field.validator?.call('StrongP@ssw0rd'), isNull);
    });

    testWidgets(
      'GConfirmPasswordField applies validator overrides after match',
      (tester) async {
        final passwordController = TextEditingController(text: 'secret');
        final confirmController = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
                child: GConfirmPasswordField(
                  controller: confirmController,
                  passwordController: passwordController,
                  validationConfig: const ConfirmPasswordValidationConfig(
                    requireConfirmation: false,
                  ),
                  validatorOverride:
                      (value) =>
                          value == 'secret' ? 'Password already used' : null,
                ),
              ),
            ),
          ),
        );

        final field = tester.widget<TextFormField>(find.byType(TextFormField));
        expect(field.validator?.call('secret'), 'Password already used');
        expect(field.validator?.call('else'), 'Passwords do not match');
      },
    );
  });

  group('spinner widgets', () {
    testWidgets('canonical spinner widgets render', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                GCircularSpinner(),
                GLinearSpinner(),
                GSpinnerDot(color: Colors.red),
                GSpinnerWaveDot(size: 24, color: Colors.blue),
                SizedBox(
                  width: 48,
                  height: 48,
                  child: GWaveSpinner(color: Colors.green),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(GCircularSpinner), findsOneWidget);
      expect(find.byType(GLinearSpinner), findsOneWidget);
      expect(find.byType(GSpinnerDot), findsOneWidget);
      expect(find.byType(GSpinnerWaveDot), findsOneWidget);
      expect(find.byType(GWaveSpinner), findsOneWidget);
    });

    testWidgets('GElevatedButton uses GSpinnerWaveDot while loading', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GElevatedButton(
              isLoading: true,
              onPressed: () {},
              text: 'Submit',
            ),
          ),
        ),
      );

      expect(find.byType(GSpinnerWaveDot), findsOneWidget);
      expect(find.text('Submit'), findsNothing);
    });
  });
}
