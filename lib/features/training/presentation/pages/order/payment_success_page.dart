import 'package:flutter/material.dart';

// ==========================================
// 6. HALAMAN SUKSES PEMBAYARAN
// ==========================================
class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.green),
              const SizedBox(height: 24),
              const Text(
                'Pembayaran Berhasil!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Terima kasih! Pembayaran Anda telah kami terima. E-tiket dan instruksi kelas pelatihan telah dikirim ke Email pemesan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Kembali ke Home (Daftar Pelatihan)
                },
                child: const Text('Kembali ke Halaman Utama'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
