import 'package:flutter/material.dart';

// ==========================================
// 6. HALAMAN SUKSES PEMBAYARAN
// ==========================================
class CertSuccessPage extends StatelessWidget {
  const CertSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_rounded,
                size: 120,
                color: Colors.green,
              ),
              const SizedBox(height: 24),
              const Text(
                'Pendaftaran Berhasil!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Terima kasih! Pembayaran sertifikasi telah kami terima. Tim kami akan segera menghubungi PIC terdaftar untuk mengatur jadwal Kick-off Meeting.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke Root
                  },
                  child: const Text(
                    'Kembali ke Halaman Utama',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
