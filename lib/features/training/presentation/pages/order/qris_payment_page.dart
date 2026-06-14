import 'package:flutter/material.dart';
import 'package:safenesia_1/features/training/presentation/pages/order/payment_success_page.dart';

// ==========================================
// 5. HALAMAN PEMBAYARAN QRIS (DUMMY)
// ==========================================
class QrisPaymentPage extends StatelessWidget {
  final int totalBayar;
  const QrisPaymentPage({super.key, required this.totalBayar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran QRIS')),
      body: Center(
        child: Padding(
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
              // Simulai Gambar QRIS
              Container(
                width: 250,
                height: 250,
                color: Theme.of(context).colorScheme.surface,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_2,
                          size: 140,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'GPN - QRIS DUMMY',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
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
              ),
              const SizedBox(height: 40),

              // Tombol Simulasi Pembayaran Sukses (Sebelum dihubungkan ke Webhook/Midtrans)
              ElevatedButton(

                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentSuccessPage(),
                    ),
                    (route) => route.isFirst,
                  );
                },
                child: const Text('Simulasi Bayar Berhasil (Webhook Dummy)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
