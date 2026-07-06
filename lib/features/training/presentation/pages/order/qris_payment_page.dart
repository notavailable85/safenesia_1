import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:gal/gal.dart';

import 'package:safenesia_1/features/training/presentation/pages/order/payment_success_page.dart';
import 'package:safenesia_1/core/utils/currency_formatter.dart';
import 'package:safenesia_1/features/training/utils/invoice_pdf_generator.dart';

// ==========================================
// 5. HALAMAN PEMBAYARAN QRIS
// ==========================================
class QrisPaymentPage extends StatefulWidget {
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
  State<QrisPaymentPage> createState() => _QrisPaymentPageState();
}

class _QrisPaymentPageState extends State<QrisPaymentPage> {
  final GlobalKey _qrisKey = GlobalKey();
  
  late String invoiceNumber;
  late DateTime deadline;
  
  bool _isLoading = true;
  String _qrisPayload = '';
  
  Timer? _countdownTimer;
  Duration _remainingTime = const Duration(minutes: 15);

  @override
  void initState() {
    super.initState();
    invoiceNumber = 'INV-${DateTime.now().millisecondsSinceEpoch}';
    deadline = DateTime.now().add(const Duration(minutes: 15));
    
    _fetchMidtransQris();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  // TODO: Call backend API to create Midtrans transaction
  Future<void> _fetchMidtransQris() async {
    setState(() => _isLoading = true);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _qrisPayload = '00020101021126570011ID.CO.QRIS.WWW011893600915300000000002141530000000000303UMI51440014ID.CO.QRIS.WWW0215ID10190000000000303UMI5204599953033605406${widget.totalBayar}.005802ID5913Safenesia K36006Jakarta61051234562070703A016304C63E'; 
        _isLoading = false;
      });
      _startTimer();
    }
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          final now = DateTime.now();
          if (deadline.isAfter(now)) {
            _remainingTime = deadline.difference(now);
          } else {
            _remainingTime = Duration.zero;
            timer.cancel();
            // TODO: Handle expired payment
          }
        });
      }
    });
  }

  // TODO: Call backend API to check Midtrans status
  Future<void> _checkPaymentStatus() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop(); // Close dialog

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Status: Menunggu Pembayaran')),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final String deadlineStr = DateFormat('dd MMM yyyy, HH:mm').format(deadline);

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran QRIS')),
      body: _isLoading 
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Menyiapkan kode pembayaran...'),
              ],
            ),
          )
        : ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          // Bagian 1: Invoice & Info Batas Waktu
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
                  const SizedBox(height: 8),
                  Text(
                    'Selesaikan pembayaran dalam waktu:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatDuration(_remainingTime),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: _remainingTime.inSeconds < 60 
                          ? Theme.of(context).colorScheme.error 
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Jatuh tempo: $deadlineStr',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Bagian 2: Jumlah yang Harus Dibayar
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
                        widget.totalBayar.toRupiah(),
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
                          Clipboard.setData(ClipboardData(text: widget.totalBayar.toString()));
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
          const SizedBox(height: 8),

          // Bagian 3: QRIS & Tombol Download
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  RepaintBoundary(
                    key: _qrisKey,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          QrImageView(
                            data: _qrisPayload,
                            version: QrVersions.auto,
                            size: 160.0,
                            padding: const EdgeInsets.all(10.0),
                            eyeStyle: const QrEyeStyle(
                              eyeShape: QrEyeShape.square,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                          onPressed: () async {
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Mengunduh QRIS...')),
                              );
                              final boundary = _qrisKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
                              if (boundary == null) return;
                              final image = await boundary.toImage(pixelRatio: 3.0);
                              final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
                              final bytes = byteData?.buffer.asUint8List();
                              if (bytes == null) return;

                              final directory = await getTemporaryDirectory();
                              final imagePath = '${directory.path}/qris_dummy.png';
                              final file = File(imagePath);
                              await file.writeAsBytes(bytes);

                              if (!await Gal.hasAccess()) {
                                await Gal.requestAccess();
                              }
                              await Gal.putImage(imagePath);

                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('QRIS berhasil disimpan ke Galeri')),
                              );
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Gagal menyimpan QRIS: $e')),
                              );
                            }
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
                                namaPelatihan: widget.namaPelatihan,
                                jumlahPeserta: widget.jumlahPeserta,
                                hargaSatuan: widget.hargaSatuan,
                                totalBayar: widget.totalBayar,
                                deadlineStr: deadlineStr,
                                primaryColorValue: Theme.of(context).colorScheme.primary.toARGB32(),
                              );
                              
                              if (Platform.isAndroid) {
                                Directory? directory = Directory('/storage/emulated/0/Download');
                                if (!await directory.exists()) {
                                  directory = await getExternalStorageDirectory();
                                }
                                final file = File('${directory!.path}/Invoice_$invoiceNumber.pdf');
                                await file.writeAsBytes(pdfBytes);
                              } else {
                                final directory = await getApplicationDocumentsDirectory();
                                final file = File('${directory.path}/Invoice_$invoiceNumber.pdf');
                                await file.writeAsBytes(pdfBytes);
                              }
                              
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invoice berhasil disimpan ke Perangkat'),
                                ),
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
          const SizedBox(height: 8),

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
                              widget.namaPelatihan,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.jumlahPeserta} x ${widget.hargaSatuan.toRupiah()}',
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.totalBayar.toRupiah(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tombol Cek Status Pembayaran
          SizedBox(
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _checkPaymentStatus,
              child: const Text(
                'Cek Status Pembayaran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Simulasi Pembayaran Sukses (Sebagai dummy developer - Akan dihapus di production)
          GestureDetector(
            onLongPress: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentSuccessPage(),
                ),
                (route) => route.isFirst,
              );
            },
            child: Opacity(
              opacity: 0.3,
              child: const Text(
                'Tahan untuk Simulasi Bayar Berhasil (Admin Only)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ),
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
