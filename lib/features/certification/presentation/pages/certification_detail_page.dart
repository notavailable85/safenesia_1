import 'package:flutter/material.dart';
import 'package:safenesia_1/features/certification/presentation/pages/certification_model.dart';
import 'package:safenesia_1/features/certification/presentation/pages/order/order_form_page.dart';

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
    int currentTotal =
        widget.certData.basePrice + (_withConsultation ? _consultationFee : 0);

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Sertifikasi')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Foto Produk
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withAlpha(50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.verified,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.certData.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kategori: ${widget.certData.category} | ${widget.certData.level}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const Divider(height: 32),

                  _buildDetailSection(
                    'Deskripsi',
                    'Layanan sertifikasi resmi untuk memastikan sistem manajemen perusahaan Anda memenuhi standar yang ditetapkan oleh badan regulasi atau internasional.',
                  ),
                  _buildDetailSection(
                    'Persyaratan',
                    '1. Legalitas Perusahaan (Akta, NIB, NPWP)\n2. Struktur Organisasi\n3. Dokumen Manual Sistem Manajemen\n4. Laporan Internal Audit',
                  ),
                  _buildDetailSection(
                    'Tahapan',
                    '1. Kick-off Meeting\n2. Audit Stage 1 (Tinjauan Dokumen)\n3. Audit Stage 2 (Tinjauan Lapangan)\n4. Penerbitan Sertifikat',
                  ),
                  _buildDetailSection(
                    'Fasilitas',
                    '• Sertifikat Resmi\n• Laporan Hasil Audit\n• Softcopy Logo Sertifikasi',
                  ),
                  _buildDetailSection(
                    'Info Pendaftaran',
                    'Pendaftaran wajib dilakukan oleh perwakilan sah perusahaan. Jadwal audit akan disesuaikan setelah pembayaran DP atau Lunas.',
                  ),

                  const Divider(height: 32),
                  // Opsi Konsultasi
                  const Text(
                    'Opsi Tambahan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Card(
                    color: _withConsultation
                        ? Theme.of(context).colorScheme.primaryContainer.withAlpha(50)
                        : Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: CheckboxListTile(
                      title: const Text(
                        'Tambah Sesi Konsultasi & Pendampingan',
                      ),
                      subtitle: Text('Biaya tambahan: Rp $_consultationFee'),
                      value: _withConsultation,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (bool? value) {
                        setState(() {
                          _withConsultation = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Booking Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Biaya:',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      'Rp $currentTotal',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
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
                  child: const Text(
                    'Pesan Sekarang',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
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
          Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }
}
