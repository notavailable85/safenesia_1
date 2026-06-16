import 'package:flutter/material.dart';
import 'package:safenesia_1/features/training/presentation/pages/order/order_form_page.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';
import 'package:safenesia_1/core/utils/currency_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

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
            // Foto Produk Pelatihan
            Builder(
              builder: (context) {
                final String imageUrl = scheduleData.gambar.isNotEmpty 
                    ? scheduleData.gambar 
                    : trainingData.gambarPelatihan;
                
                if (imageUrl.isNotEmpty) {
                  return Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(context),
                  );
                } else {
                  return _buildPlaceholderImage(context);
                }
              },
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
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.2, // Adjust aspect ratio for info boxes
              children: [
                _buildInfoBox(context, Icons.calendar_month, 'Tanggal', scheduleData.tanggalStr),
                _buildInfoBox(context, Icons.group, 'Kuota', 'Maksimal 30 Peserta'),
                _buildInfoBox(context, Icons.location_on, 'Lokasi', scheduleData.namaLokasi ?? trainingData.metode, url: scheduleData.linkPetaLokasi),
                _buildInfoBox(context, Icons.payments, 'Harga', trainingData.hargaPromo.toRupiah()),
              ],
            ),
            const Divider(height: 32),

            _buildSection(context, 'Deskripsi', trainingData.deskripsi, Icons.description),
            _buildSection(context, 'Dasar Hukum', trainingData.dasarHukum, Icons.gavel),
            _buildSection(context, 'Tujuan', trainingData.tujuan, Icons.track_changes),
            _buildSection(context, 'Materi Pelatihan', trainingData.materi, Icons.menu_book),
            _buildSection(context, 'Persyaratan', trainingData.syaratAdministrasi, Icons.assignment),
            _buildSection(context, 'Fasilitas', trainingData.fasilitas, Icons.apartment),
            _buildSection(context, 'Metode', '${trainingData.metode}\n${trainingData.detailMetode}', Icons.model_training),
            _buildSection(context, 'Instruktur', trainingData.instruktur, Icons.person),
            _buildSection(context, 'Syarat & Ketentuan', trainingData.syaratKetentuan, Icons.rule),
            _buildSection(context, 'Info Pendaftaran', trainingData.keterangan, Icons.info),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000), // 5% black
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderFormPage(scheduleData: scheduleData),
                  ),
                );
              },
              child: const Text(
                'Pesan Pelatihan Sekarang',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(BuildContext context, IconData icon, String title, String subtitle, {String? url}) {
    final box = Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.primaryContainer),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (url != null && url.isNotEmpty) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: box,
        ),
      );
    }
    return box;
  }

  Widget _buildSection(BuildContext context, String title, String content, IconData iconData) {
    if (content.trim().isEmpty) return const SizedBox();
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withAlpha(128)),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(iconData, color: Theme.of(context).colorScheme.primary),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        expandedAlignment: Alignment.centerLeft,
        children: [
          Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Icon(Icons.image, size: 100, color: Theme.of(context).colorScheme.onSurfaceVariant),
    );
  }
}
