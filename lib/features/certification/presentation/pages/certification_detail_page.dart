import 'package:flutter/material.dart';
import 'package:safenesia_1/features/certification/models/certification_model.dart';
import 'package:safenesia_1/features/certification/presentation/pages/order/order_form_page.dart';
import 'package:safenesia_1/core/utils/currency_formatter.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safenesia_1/core/widgets/custom_download_button.dart';

// ==========================================
// 2. HALAMAN DETAIL SERTIFIKASI
// ==========================================
class CertDetailPage extends StatefulWidget {
  final CertModel certData;
  const CertDetailPage({super.key, required this.certData});

  @override
  State<CertDetailPage> createState() => _CertDetailPageState();
}

class _CertDetailPageState extends State<CertDetailPage> {
  bool _withConsultation = false;
  final int _consultationFee = 5000000;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    int currentTotal =
        widget.certData.basePrice + (_withConsultation ? _consultationFee : 0);

    return Scaffold(
      appBar: AppBar(title: Text(widget.certData.title)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Foto Produk Sertifikasi
                  Builder(
                    builder: (context) {
                      final String rawUrl = widget.certData.bannerUrl ?? '';
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
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
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

                  // Header Title
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.certData.title.toUpperCase(),
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
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            widget.certData.category,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Sub Title Level
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'level ',
                          style: GoogleFonts.lora(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        TextSpan(
                          text: widget.certData.level,
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

                  // Grid View Info Boxes
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2.8,
                    children: [
                      _buildInfoBox(
                        context,
                        Icons.category,
                        'Kategori',
                        widget.certData.category,
                      ),
                      _buildInfoBox(
                        context,
                        Icons.leaderboard,
                        'Level',
                        widget.certData.level,
                      ),
                      _buildInfoBox(
                        context,
                        Icons.payments,
                        'Biaya Dasar',
                        widget.certData.basePrice.toRupiah(),
                      ),
                      _buildInfoBox(
                        context,
                        Icons.access_time,
                        'Estimasi',
                        '10 - 30 Hari',
                      ),
                    ],
                  ),
                  const Divider(height: 32),

                  // Sections
                  _buildSection(
                    context,
                    'Deskripsi',
                    'Layanan sertifikasi resmi untuk memastikan sistem manajemen perusahaan Anda memenuhi standar yang ditetapkan oleh badan regulasi atau internasional.',
                    Icons.description,
                  ),
                  _buildSection(
                    context,
                    'Persyaratan',
                    '1. Legalitas Perusahaan (Akta, NIB, NPWP)\n2. Struktur Organisasi\n3. Dokumen Manual Sistem Manajemen\n4. Laporan Internal Audit',
                    Icons.assignment,
                  ),
                  _buildSection(
                    context,
                    'Tahapan',
                    '1. Kick-off Meeting\n2. Audit Stage 1 (Tinjauan Dokumen)\n3. Audit Stage 2 (Tinjauan Lapangan)\n4. Penerbitan Sertifikat',
                    Icons.account_tree,
                  ),
                  _buildSection(
                    context,
                    'Fasilitas',
                    '• Sertifikat Resmi\n• Laporan Hasil Audit\n• Softcopy Logo Sertifikasi',
                    Icons.apartment,
                  ),
                  _buildSection(
                    context,
                    'Info Pendaftaran',
                    'Pendaftaran wajib dilakukan oleh perwakilan sah perusahaan. Jadwal audit akan disesuaikan setelah pembayaran DP atau Lunas.',
                    Icons.info,
                  ),

                  const SizedBox(height: 16),
                  Divider(color: colorScheme.outlineVariant),
                  const SizedBox(height: 16),

                  // Opsi Konsultasi
                  Text(
                    'Layanan Tambahan (Opsional)',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: CheckboxListTile(
                      title: Text(
                        'Konsultasi & Pendampingan',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: _withConsultation
                              ? colorScheme.primary
                              : colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Biaya tambahan: ${_consultationFee.toRupiah()}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _withConsultation
                              ? colorScheme.primary.withValues(alpha: 0.8)
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                      value: _withConsultation,
                      activeColor: colorScheme.primary,
                      checkColor: colorScheme.onPrimary,
                      onChanged: (bool? value) {
                        setState(() {
                          _withConsultation = value ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
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
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CertFormPage(
                    certData: widget.certData,
                    withConsultation: _withConsultation,
                    consultationFee: _consultationFee,
                    totalPrice: currentTotal,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.app_registration),
            label: const Text(
              'Daftar Sekarang',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Icon(
        Icons.verified,
        size: 80,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildInfoBox(
    BuildContext context,
    IconData icon,
    String label,
    String value) {
    return Container(
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
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
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
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
  ) {
    if (content.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(content, style: const TextStyle(fontSize: 14, height: 1.6)),
        ],
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
            if (!kIsWeb)
              CustomDownloadButton(
                label: 'Unduh Gambar',
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('Menyimpan gambar...'),
        ),
      );

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
          const SnackBar(
            duration: Duration(milliseconds: 1500),
            content: Text('Gambar berhasil disimpan ke galeri!'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text('Gagal menyimpan gambar: $e'),
          ),
        );
      }
    }
  }
}
