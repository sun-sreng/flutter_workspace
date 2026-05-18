import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmana_form/gmana_form.dart';

void main() {
  group('form widgets', () {
    testWidgets('canonical form widgets render', (tester) async {
      final emailController = TextEditingController();
      final textController = TextEditingController();
      final numberController = TextEditingController();
      final passwordController = TextEditingController(text: 'password123');
      final confirmPasswordController = TextEditingController();

      addTearDown(emailController.dispose);
      addTearDown(textController.dispose);
      addTearDown(numberController.dispose);
      addTearDown(passwordController.dispose);
      addTearDown(confirmPasswordController.dispose);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: Column(
                children: [
                  GEmailField(controller: emailController, labelText: 'Email'),
                  GTextField(controller: textController, labelText: 'Name'),
                  GNumberField(controller: numberController, labelText: 'Age'),
                  GPasswordField(controller: passwordController),
                  GConfirmPasswordField(
                    controller: confirmPasswordController,
                    passwordController: passwordController,
                  ),
                  GElevatedButton(
                    isLoading: false,
                    onPressed: () {},
                    text: 'Submit',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(GEmailField), findsOneWidget);
      expect(find.byType(GTextField), findsOneWidget);
      expect(find.byType(GNumberField), findsOneWidget);
      expect(find.byType(GPasswordField), findsOneWidget);
      expect(find.byType(GConfirmPasswordField), findsOneWidget);
      expect(find.byType(GElevatedButton), findsOneWidget);
    });

    test('confirm password validator reports mismatches', () {
      final message = const ConfirmPasswordValidator()
          .validate(password: 'secret', confirmation: 'different')
          .fold(resolveConfirmPasswordValidationIssue, (_) => null);

      expect(message, 'Passwords do not match');
    });
  });
}
