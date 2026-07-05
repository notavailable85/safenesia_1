import 'package:flutter/material.dart';
import 'package:safenesia_1/features/training/presentation/pages/order/order_form_page.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';
import 'package:safenesia_1/core/utils/currency_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safenesia_1/core/widgets/custom_download_button.dart';

// ==========================================
// 2. HALAMAN DETAIL PELATHAN
// ==========================================
class TrainingDetailPage extends StatelessWidget {
  final TrainingSchedule scheduleData;

  const TrainingDetailPage({super.key, required this.scheduleData});

  @override
  Widget build(BuildContext context) {
    final trainingData = scheduleData.trainingData;
    if (trainingData == null) {
      return const Scaffold(body: Center(child: Text('Data error')));
    }

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
                final String rawUrl = scheduleData.gambar.isNotEmpty
                    ? scheduleData.gambar
                    : (trainingData.gambarPelatihan.isNotEmpty
                          ? trainingData.gambarPelatihan
                          : '');

                final String imageUrl = rawUrl.trim();

                if (imageUrl.isNotEmpty) {
                  final isNetwork =
                      imageUrl.startsWith('http') ||
                      imageUrl.startsWith('https');
                  final isFile =
                      imageUrl.startsWith('/') ||
                      imageUrl.startsWith('file://') ||
                      imageUrl.contains(':\\');

                  return GestureDetector(
                    onTap: () => _showImageDialog(
                      context,
                      imageUrl,
                      isNetwork,
                      isFile: isFile,
                    ),
                    child: isNetwork
                        ? Image.network(
                            imageUrl,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholderImage(context),
                          )
                        : isFile
                        ? Image.file(
                            File(imageUrl.replaceFirst('file://', '')),
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholderImage(context),
                          )
                        : Image.asset(
                            imageUrl,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.red.shade100,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Gagal memuat gambar:\n$imageUrl\nError: $error',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                  );
                } else {
                  return _buildPlaceholderImage(context);
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    trainingData.namaPelatihan.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    trainingData.metode,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'sertifikasi ',
                    style: GoogleFonts.lora(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  TextSpan(
                    text: trainingData.sertifikasi,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.8, // Adjust aspect ratio for info boxes
              children: [
                _buildInfoBox(
                  context,
                  Icons.calendar_month,
                  'Tanggal',
                  scheduleData.tanggalStr,
                ),
                _buildInfoBox(context, Icons.group, 'Kuota', '10 - 30 Pax'),
                _buildInfoBox(
                  context,
                  Icons.location_on,
                  'Lokasi',

                  scheduleData.namaLokasi ?? trainingData.metode,
                  url: scheduleData.linkPetaLokasi,
                ),
                _buildInfoBox(
                  context,
                  Icons.payments,
                  'Harga',
                  trainingData.hargaPromo.toRupiah(),
                ),
              ],
            ),
            const Divider(height: 32),

            _buildSection(
              context,
              'Deskripsi',
              trainingData.deskripsi,
              Icons.description,
            ),
            _buildSection(
              context,
              'Dasar Hukum',
              trainingData.dasarHukum,
              Icons.gavel,
            ),
            _buildSection(
              context,
              'Tujuan',
              trainingData.tujuan,
              Icons.track_changes,
            ),
            _buildSection(
              context,
              'Materi Pelatihan',
              trainingData.materi,
              Icons.menu_book,
            ),
            _buildSection(
              context,
              'Persyaratan',
              trainingData.syaratAdministrasi,
              Icons.assignment,
            ),
            _buildSection(
              context,
              'Fasilitas',
              trainingData.fasilitas,
              Icons.apartment,
            ),
            _buildSection(
              context,
              'Metode',
              '${trainingData.metode}\n${trainingData.detailMetode}',
              Icons.model_training,
            ),
            _buildSection(
              context,
              'Instruktur',
              trainingData.instruktur,
              Icons.person,
            ),
            _buildSection(
              context,
              'Syarat & Ketentuan',
              trainingData.syaratKetentuan,
              Icons.rule,
            ),
            _buildSection(
              context,
              'Info Pendaftaran',
              trainingData.keterangan,
              Icons.info,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70.0 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 8 + MediaQuery.of(context).padding.bottom,
        ),
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
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
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
          icon: const Icon(Icons.how_to_reg),
          label: const Text(
            'Daftar Sekarang',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    String? url,
  }) {
    final box = Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer.withAlpha(50),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  maxLines: 1,
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

  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
    IconData iconData,
  ) {
    if (content.trim().isEmpty) return const SizedBox();
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(iconData, color: Theme.of(context).colorScheme.primary),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
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
      child: Icon(
        Icons.image,
        size: 100,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  void _showImageDialog(
    BuildContext context,
    String imageUrl,
    bool isNetwork, {
    bool isFile = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.5,
                    maxScale: 4,
                    child: isNetwork
                        ? Image.network(imageUrl, fit: BoxFit.contain)
                        : isFile
                        ? Image.file(
                            File(imageUrl.replaceFirst('file://', '')),
                            fit: BoxFit.contain,
                          )
                        : Image.asset(imageUrl, fit: BoxFit.contain),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomDownloadButton(
              label: 'Unduh Flyer',
              onPressed: () =>
                  _downloadImage(context, imageUrl, isNetwork, isFile),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadImage(
    BuildContext context,
    String imageUrl,
    bool isNetwork,
    bool isFile,
  ) async {
    try {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Menyimpan gambar...')));

      String savePath = '';

      if (isFile) {
        savePath = imageUrl.replaceFirst('file://', '');
      } else {
        final tempDir = await getTemporaryDirectory();
        final file = File(
          '${tempDir.path}/temp_img_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );

        if (isNetwork) {
          final request = await HttpClient().getUrl(Uri.parse(imageUrl));
          final response = await request.close();
          final bytes = await consolidateHttpClientResponseBytes(response);
          await file.writeAsBytes(bytes);
        } else {
          final byteData = await rootBundle.load(imageUrl);
          await file.writeAsBytes(byteData.buffer.asUint8List());
        }
        savePath = file.path;
      }

      final hasAccess = await Gal.hasAccess(toAlbum: true);
      if (!hasAccess) {
        await Gal.requestAccess(toAlbum: true);
      }

      await Gal.putImage(savePath);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gambar berhasil disimpan ke galeri!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal menyimpan gambar: $e')));
      }
    }
  }
}
