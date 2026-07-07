import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safenesia_1/features/certification/presentation/pages/order/payment_success_page.dart';
import 'package:safenesia_1/core/utils/currency_formatter.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/profile/models/transaction_model.dart';
import 'package:intl/intl.dart';

// ==========================================
// 5. HALAMAN PEMBAYARAN QRIS (DUMMY)
// ==========================================
class CertPaymentQrisPage extends StatefulWidget {
  final int totalBayar;
  final String title;

  const CertPaymentQrisPage({
    super.key,
    required this.totalBayar,
    this.title = 'Sertifikasi K3',
  });

  @override
  State<CertPaymentQrisPage> createState() => _CertPaymentQrisPageState();
}

class _CertPaymentQrisPageState extends State<CertPaymentQrisPage> {
  final GlobalKey _qrisKey = GlobalKey();

  Future<void> _saveTransaction() async {
    final now = DateTime.now();
    final formatter = DateFormat('dd MMM yyyy');
    final String formattedDate = formatter.format(now);

    final transaction = TransactionModel(
      id: 'trx_${now.millisecondsSinceEpoch}',
      layanan: 'Sertifikasi',
      judul: widget.title,
      status: 'Selesai',
      tanggal: formattedDate,
      totalBayar: widget.totalBayar,
    );
    await DatabaseHelper.instance.createTransaction(transaction);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        title: const Text(
          'Pembayaran QRIS',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Tagihan',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.totalBayar.toRupiah(),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              // Dummy Gambar QRIS
              RepaintBoundary(
                key: _qrisKey,
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white, // Keep white for QR contrast
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.qr_code_2,
                          size: 160,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'QRIS PAYMENT DUMMY',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Scan menggunakan e-Wallet / M-Banking',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              OutlinedButton.icon(
                onPressed: () async {
                  try {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 1500),
                        content: Text('Mengunduh QRIS...'),
                      ),
                    );
                    final boundary =
                        _qrisKey.currentContext?.findRenderObject()
                            as RenderRepaintBoundary?;
                    if (boundary == null) return;
                    final image = await boundary.toImage(pixelRatio: 3.0);
                    final byteData = await image.toByteData(
                      format: ui.ImageByteFormat.png,
                    );
                    final bytes = byteData?.buffer.asUint8List();
                    if (bytes == null) return;

                    final directory = await getTemporaryDirectory();
                    final imagePath = '${directory.path}/qris_dummy_cert.png';
                    final file = File(imagePath);
                    await file.writeAsBytes(bytes);

                    if (!await Gal.hasAccess()) {
                      await Gal.requestAccess();
                    }
                    await Gal.putImage(imagePath);

                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 1500),
                        content: Text('QRIS berhasil disimpan ke Galeri'),
                      ),
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 1500),
                        content: Text('Gagal menyimpan QRIS: $e'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.download),
                label: const Text('Download QRIS'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
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
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            await _saveTransaction();
            if (!context.mounted) return;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const CertSuccessPage()),
              (route) => route.isFirst,
            );
          },
          child: const Text(
            'Simulasi Bayar Berhasil',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
