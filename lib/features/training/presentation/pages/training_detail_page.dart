import 'package:flutter/material.dart';
import 'package:safenesia_1/features/training/presentation/pages/order/order_form_page.dart';

// ==========================================
// 2. HALAMAN DETAIL PELATHAN
// ==========================================
class TrainingDetailPage extends StatelessWidget {
  final Map<String, dynamic> trainingData;

  const TrainingDetailPage({super.key, required this.trainingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(trainingData['judul'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dummy Foto Produk Pelatihan
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.blueGrey.shade100,
              child: const Icon(Icons.image, size: 100, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              trainingData['judul'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              trainingData['sertifikasi'],
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 32),

            _buildSection(
              'Deskripsi',
              'Pelatihan ini dirancang untuk membekali peserta dengan pengetahuan dan keterampilan praktis terkait keselamatan kerja sesuai regulasi undang-undang.',
            ),
            _buildSection(
              'Persyaratan',
              '1. Pendidikan minimal D3/S1 (Umum) atau SMA (Pengalaman kerja K3 2 tahun)\n2. Scan KTP & Ijazah\n3. Surat Rekomendasi Perusahaan (jika utusan)',
            ),
            _buildSection(
              'Materi Pelatihan',
              '• Peraturan Perundangan K3\n• Dasar-dasar K3\n• Manajemen Risiko & SMK3\n• Analisis Kecelakaan Kerja',
            ),
            _buildSection(
              'Fasilitas',
              '• Sertifikat Kemnaker RI\n• Modul & Training Kit\n• Makan Siang & Coffee Break\n• Kemeja Safety (Wearpack)',
            ),
            _buildSection(
              'Info Pendaftaran',
              'Pendaftaran ditutup H-7 sebelum pelaksanaan kelas dimulai. Kuota terbatas untuk efektivitas praktikum.',
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrderFormPage(trainingData: trainingData),
                    ),
                  );
                },
                child: const Text(
                  'Pesan Pelatihan Sekarang',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(content, style: const TextStyle(fontSize: 14, height: 1.4)),
        ],
      ),
    );
  }
}
