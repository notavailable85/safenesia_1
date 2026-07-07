import 'package:flutter/material.dart';
import 'package:safenesia_1/features/auth/presentation/pages/login/login_page.dart';
import 'package:safenesia_1/features/auth/presentation/pages/login/registered_accounts_page.dart';

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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 45),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisteredAccountsPage(),
                ),
              ),
              child: const Text('Akun Terdaftar'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(200, 45)),
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
