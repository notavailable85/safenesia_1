import 'package:flutter/material.dart';
import 'package:safenesia_1/features/auth/presentation/pages/splash/splash_screen.dart';

void main() {
  runApp(const SafenesiaApp());
}

class SafenesiaApp extends StatelessWidget {
  const SafenesiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safenesia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
