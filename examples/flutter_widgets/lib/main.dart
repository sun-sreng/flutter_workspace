import 'package:flutter/material.dart';
import 'package:flutter_widgets/features/splash_screen_01/splash_screen_01.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen01(),
    );
  }
}
