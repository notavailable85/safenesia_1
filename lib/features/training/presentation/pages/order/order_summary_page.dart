import 'package:flutter/material.dart';
import 'package:safenesia_1/features/training/presentation/pages/order/qris_payment_page.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';

// ==========================================
// 4. HALAMAN RINGKASAN PEMESANAN (CHECKOUT)
// ==========================================
class OrderSummaryPage extends StatelessWidget {
  final TrainingSchedule scheduleData;
  final int jumlahPeserta;
  final String jenisPeserta;
  final List<Map<String, String>> daftarPeserta;

  const OrderSummaryPage({
    super.key,
    required this.scheduleData,
    required this.jumlahPeserta,
    required this.jenisPeserta,
    required this.daftarPeserta,
  });

  @override
  Widget build(BuildContext context) {
    int hargaSatuan = scheduleData.trainingData!.hargaPromo;
    int totalHarga = hargaSatuan * jumlahPeserta;

    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pemesanan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Info Pelatihan
          Card(
            child: ListTile(
              title: Text(
                scheduleData.trainingData!.namaPelatihan,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${scheduleData.trainingData!.sertifikasi}\nTipe: $jenisPeserta\nJadwal: ${scheduleData.tanggalStr}',
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Daftar Peserta
          const Text(
            'Daftar Peserta:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ...daftarPeserta.map(
            (p) => ListTile(
              leading: const Icon(Icons.person),
              title: Text(p['nama']!),
              subtitle: Text('KTP: ${p['ktp']} | WA: ${p['wa']}'),
            ),
          ),
          const Divider(height: 32),

          // Rincian Harga
          const Text(
            'Rincian Pembayaran:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Harga Satuan ($jumlahPeserta x)'),
              Text('Rp $hargaSatuan'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'Rp $totalHarga',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

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
                  builder: (context) => QrisPaymentPage(totalBayar: totalHarga),
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
