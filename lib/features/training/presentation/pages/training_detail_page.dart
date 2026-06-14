import 'package:flutter/material.dart';
import 'package:safenesia_1/features/training/presentation/pages/order/order_form_page.dart';

import 'package:safenesia_1/features/training/models/training_model.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';

// ==========================================
// 2. HALAMAN DETAIL PELATHAN
// ==========================================
class TrainingDetailPage extends StatelessWidget {
  final TrainingSchedule scheduleData;

  const TrainingDetailPage({super.key, required this.scheduleData});

  @override
  Widget build(BuildContext context) {
    final trainingData = scheduleData.trainingData;
    if (trainingData == null) return const Scaffold(body: Center(child: Text('Data error')));

    return Scaffold(
      appBar: AppBar(title: Text(trainingData.namaPelatihan)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dummy Foto Produk Pelatihan
            Container(
              width: double.infinity,
              height: 200,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Icon(Icons.image, size: 100, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            Text(
              trainingData.namaPelatihan,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              trainingData.sertifikasi,
              style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const Divider(height: 32),

            _buildSection(context, 'Deskripsi', trainingData.deskripsi),
            _buildSection(context, 'Dasar Hukum', trainingData.dasarHukum),
            _buildSection(context, 'Tujuan', trainingData.tujuan),
            _buildSection(context, 'Materi Pelatihan', trainingData.materi),
            _buildSection(context, 'Persyaratan', trainingData.syaratAdministrasi),
            _buildSection(context, 'Fasilitas', trainingData.fasilitas),
            _buildSection(context, 'Metode', '${trainingData.metode}\n${trainingData.detailMetode}'),
            _buildSection(context, 'Instruktur', trainingData.instruktur),
            _buildSection(context, 'Syarat & Ketentuan', trainingData.syaratKetentuan),
            _buildSection(context, 'Info Pendaftaran', trainingData.keterangan),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrderFormPage(scheduleData: scheduleData),
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

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(content, style: const TextStyle(fontSize: 14, height: 1.4)),
        ],
      ),
    );
  }
}
