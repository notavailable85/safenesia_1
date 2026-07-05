import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:safenesia_1/features/training/presentation/pages/order/payment_success_page.dart';
import 'package:safenesia_1/core/utils/currency_formatter.dart';
import 'package:safenesia_1/features/training/utils/invoice_pdf_generator.dart';

// ==========================================
// 5. HALAMAN PEMBAYARAN QRIS
// ==========================================
class QrisPaymentPage extends StatelessWidget {
  final int totalBayar;
  final String namaPelatihan;
  final int jumlahPeserta;
  final int hargaSatuan;

  const QrisPaymentPage({
    super.key,
    required this.totalBayar,
    required this.namaPelatihan,
    required this.jumlahPeserta,
    required this.hargaSatuan,
  });

  @override
  Widget build(BuildContext context) {
    final String invoiceNumber = 'INV-${DateTime.now().millisecondsSinceEpoch}';
    final DateTime deadline = DateTime.now().add(const Duration(days: 1));
    final String deadlineStr = DateFormat('dd MMM yyyy, HH:mm').format(deadline);

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran QRIS')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Bagian 1: Invoice & Info Batas Waktu
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Nomor Invoice',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    invoiceNumber,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Kami telah mengirimkan tagihan ke Email/WhatsApp kamu. Lakukan pembayaran sebelum:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deadlineStr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Bagian 2: Jumlah yang Harus Dibayar
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Jumlah yang harus dibayar',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        totalBayar.toRupiah(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.copy, color: Theme.of(context).colorScheme.primary),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: totalBayar.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Nominal berhasil disalin!')),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Bagian 3: QRIS & Tombol Download
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                  const SizedBox(height: 24),
                  const Text(
                    'Download',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('QRIS berhasil diunduh!')),
                            );
                          },
                          icon: const Icon(Icons.qr_code, size: 16),
                          label: const Text('QRIS', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                          ),
                          onPressed: () async {
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Menyiapkan Invoice...')),
                              );
                              
                              final pdfBytes = await InvoicePdfGenerator.generateInvoicePdf(
                                invoiceNumber: invoiceNumber,
                                namaPelatihan: namaPelatihan,
                                jumlahPeserta: jumlahPeserta,
                                hargaSatuan: hargaSatuan,
                                totalBayar: totalBayar,
                                deadlineStr: deadlineStr,
                              );
                              
                              final directory = await getTemporaryDirectory();
                              final file = File('${directory.path}/Invoice_$invoiceNumber.pdf');
                              await file.writeAsBytes(pdfBytes);
                              
                              await Share.shareXFiles(
                                [XFile(file.path)],
                                text: 'Invoice Pembayaran $namaPelatihan',
                              );
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Gagal membuat invoice: $e')),
                              );
                            }
                          },
                          icon: const Icon(Icons.receipt, size: 16),
                          label: const Text('Invoice', textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Bagian 4: Rincian Harga
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rincian Harga',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              namaPelatihan,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$jumlahPeserta x ${hargaSatuan.toRupiah()}',
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        totalBayar.toRupiah(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Simulasi Pembayaran Sukses (Sebagai dummy developer)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
               backgroundColor: Colors.green,
               foregroundColor: Colors.white,
            ),
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
          const SizedBox(height: 32),
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
        child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text(
                'Kembali ke Beranda',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
      ),
    );
  }
}

