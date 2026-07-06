import 'package:flutter/material.dart';
import 'package:safenesia_1/features/certification/presentation/pages/order/payment_success_page.dart';

// ==========================================
// 5. HALAMAN PEMBAYARAN QRIS (DUMMY)
// ==========================================
class CertPaymentQrisPage extends StatelessWidget {
  final int totalBayar;
  const CertPaymentQrisPage({super.key, required this.totalBayar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran QRIS')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Tagihan: Rp $totalBayar',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              // Dummy Gambar QRIS
              Container(
                width: 280,
                height: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 10),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.qr_code_2,
                      size: 180,
                      color: Colors.black87,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'QRIS PAYMENT DUMMY',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Scan menggunakan e-Wallet / M-Banking',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Gambar QRIS berhasil diunduh ke galeri (Simulasi).',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Download QRIS untuk Scan Hp'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Bypass Simulasi Sukses
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CertSuccessPage(),
                    ),
                    (route) => route.isFirst,
                  );
                },
                child: const Text(
                  'Simulasi Bayar Berhasil',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
