import 'package:flutter/material.dart';

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
      home: const Scaffold(
        body: Center(
          child: Text(
            'Halo! main.dart berhasil dibuat ulang.\nSilakan hubungkan dengan UI Anda.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
