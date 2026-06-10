import 'package:flutter/material.dart';
import 'package:safenesia_1/features/certification/presentation/pages/certification_model.dart';
import 'package:safenesia_1/features/certification/presentation/pages/order/qris_payment_page.dart';

// ==========================================
// 4. HALAMAN RINGKASAN PEMESANAN
// ==========================================
class CertSummaryPage extends StatelessWidget {
  final CertModel certData;
  final bool withConsultation;
  final int consultationFee;
  final int totalPrice;
  final String namaPerusahaan;
  final String alamatPerusahaan;

  const CertSummaryPage({
    super.key,
    required this.certData,
    required this.withConsultation,
    required this.consultationFee,
    required this.totalPrice,
    required this.namaPerusahaan,
    required this.alamatPerusahaan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pemesanan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Layanan Dipilih:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Card(
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            child: ListTile(
              leading: const Icon(Icons.description, color: Colors.indigo),
              title: Text(
                certData.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(certData.level),
            ),
          ),

          const Text(
            'Data Perusahaan:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Card(
            margin: const EdgeInsets.only(top: 8, bottom: 24),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaPerusahaan,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alamatPerusahaan,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          const Text(
            'Rincian Biaya:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Biaya Sertifikasi Dasar'),
              Text('Rp ${certData.basePrice}'),
            ],
          ),
          const SizedBox(height: 8),
          if (withConsultation)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Biaya Konsultasi'),
                Text('Rp $consultationFee'),
              ],
            ),
          const Divider(height: 32, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Tagihan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                'Rp $totalPrice',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CertPaymentQrisPage(totalBayar: totalPrice),
                ),
              );
            },
            child: const Text(
              'Lanjut Ke Pembayaran QRIS',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
