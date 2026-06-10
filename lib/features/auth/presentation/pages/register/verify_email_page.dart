import 'package:flutter/material.dart';
import 'package:safenesia_1/features/auth/presentation/pages/login/login_page.dart';

// ==========================================
// 6. VERIFY EMAIL PAGE (Setelah Register)
// ==========================================
class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mark_email_read, size: 100, color: Colors.blue),
              const SizedBox(height: 24),
              const Text(
                'Verifikasi Email Anda',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Kami telah mengirimkan tautan verifikasi ke email Anda. Silakan cek kotak masuk atau folder spam Anda.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  ),
                  child: const Text('Saya Sudah Verifikasi, Lanjut Login'),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Kirim Ulang Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
