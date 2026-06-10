import 'package:flutter/material.dart';
import 'package:safenesia_1/features/auth/presentation/pages/forgot_password/otp_verification_page.dart';

// ==========================================
// 7. FORGOT PASSWORD PAGE
// ==========================================
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lupa Password')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jangan khawatir!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Masukkan email yang terdaftar, kami akan mengirimkan kode OTP untuk mereset password Anda.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email Anda',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OTPVerificationPage(),
                  ),
                ),
                child: const Text('Kirim Kode OTP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
