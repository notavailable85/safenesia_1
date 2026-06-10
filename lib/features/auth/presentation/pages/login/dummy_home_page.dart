import 'package:flutter/material.dart';
import 'package:safenesia_1/features/auth/presentation/pages/login/login_page.dart';

// ==========================================
// 10. DUMMY HOME PAGE (Target setelah login)
// ==========================================
class DummyHomePage extends StatelessWidget {
  const DummyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda Safenesia')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              'Login Berhasil!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              ),
              child: const Text('Logout (Kembali ke Login)'),
            ),
          ],
        ),
      ),
    );
  }
}
