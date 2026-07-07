import 'package:flutter/material.dart';

// ==========================================
// SUB-HALAMAN KONTAINER 2
// ==========================================

// 2.A. EDIT PASSWORD (DENGAN SIMULASI OTP)
class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});
  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  bool isCodeSent = false;
  final _emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isCodeSent ? _buildOTPForm() : _buildRequestForm(),
      ),
    );
  }

  Widget _buildRequestForm() {
    return Column(
      children: [
        const TextField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password Lama'),
        ),
        const SizedBox(height: 12),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password Baru'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _emailCtrl,
          decoration: const InputDecoration(
            labelText: 'Email Anda (Untuk Kode Konfirmasi)',
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_emailCtrl.text.isNotEmpty) setState(() => isCodeSent = true);
            },
            child: const Text('Kirim Kode Konfirmasi'),
          ),
        ),
      ],
    );
  }

  Widget _buildOTPForm() {
    return Column(
      children: [
        Text(
          'Kami telah mengirimkan kode OTP ke email ${_emailCtrl.text}. Silakan masukkan kode di bawah ini:',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Kode OTP (Contoh: 123456)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: const Duration(milliseconds: 1500),
                  content: Text('Password berhasil diubah!'),
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Simpan Password Baru'),
          ),
        ),
      ],
    );
  }
}
