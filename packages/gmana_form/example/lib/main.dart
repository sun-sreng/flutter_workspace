import 'package:flutter/material.dart';
import 'package:gmana_form/gmana_form.dart';

void main() {
  runApp(const GmanaFormExampleApp());
}

class GmanaFormExampleApp extends StatelessWidget {
  const GmanaFormExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gmana_form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      home: const ExampleFormPage(),
    );
  }
}

class ExampleFormPage extends StatefulWidget {
  const ExampleFormPage({super.key});

  @override
  State<ExampleFormPage> createState() => _ExampleFormPageState();
}

class _ExampleFormPageState extends State<ExampleFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    form.save();
    setState(() => _isSubmitting = true);

    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!mounted) {
      return;
    }

    setState(() => _isSubmitting = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Welcome, ${_nameController.text.trim()}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('gmana_form')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Create account', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  GTextField(
                    controller: _nameController,
                    labelText: 'Name',
                    hintText: 'Enter your full name',
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  GEmailField(controller: _emailController, labelText: 'Email', textInputAction: TextInputAction.next),
                  const SizedBox(height: 12),
                  GNumberField(
                    controller: _ageController,
                    labelText: 'Age',
                    hintText: 'Enter your age',
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  GPasswordField(controller: _passwordController, textInputAction: TextInputAction.next),
                  const SizedBox(height: 12),
                  GConfirmPasswordField(
                    controller: _confirmPasswordController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 48,
                    child: GElevatedButton(isLoading: _isSubmitting, onPressed: _submit, text: 'Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
