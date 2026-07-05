import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class InvoicePdfGenerator {
  static Future<Uint8List> generateInvoicePdf({
    required String invoiceNumber,
    required String namaPelatihan,
    required int jumlahPeserta,
    required int hargaSatuan,
    required int totalBayar,
    required String deadlineStr,
  }) async {
    final pdf = pw.Document();

    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'INVOICE',
                          style: pw.TextStyle(
                            fontSize: 32,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue900,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Safenesia',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text('Platform Pelatihan & Sertifikasi K3'),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('No. Invoice:', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
                        pw.Text(
                          invoiceNumber,
                          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text('Tanggal Tagihan:', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
                        pw.Text(
                          DateFormat('dd MMM yyyy').format(DateTime.now()),
                          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 40),
                
                pw.Divider(color: PdfColors.grey400),
                pw.SizedBox(height: 20),
                
                // Content
                pw.Text('Rincian Pembayaran', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 16),
                
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey300),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(3),
                    1: const pw.FlexColumnWidth(1),
                    2: const pw.FlexColumnWidth(2),
                    3: const pw.FlexColumnWidth(2),
                  },
                  children: [
                    // Table Header
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('Nama Pelatihan', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('Qty', textAlign: pw.TextAlign.center, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('Harga Satuan', textAlign: pw.TextAlign.right, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text('Total', textAlign: pw.TextAlign.right, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                      ],
                    ),
                    // Table Row
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(namaPelatihan),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(jumlahPeserta.toString(), textAlign: pw.TextAlign.center),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(currencyFormat.format(hargaSatuan), textAlign: pw.TextAlign.right),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(currencyFormat.format(totalBayar), textAlign: pw.TextAlign.right),
                        ),
                      ],
                    ),
                  ],
                ),
                
                pw.SizedBox(height: 20),
                
                // Totals
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Container(
                      width: 250,
                      child: pw.Column(
                        children: [
                          pw.Divider(color: PdfColors.grey400),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text('Total Tagihan', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                              pw.Text(currencyFormat.format(totalBayar), style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                pw.SizedBox(height: 40),
                pw.Text('Informasi Pembayaran', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8),
                pw.Text('Silakan lakukan pembayaran melalui QRIS yang telah disediakan di aplikasi.', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
                pw.SizedBox(height: 4),
                pw.Text('Batas Waktu Pembayaran: $deadlineStr', style: pw.TextStyle(fontSize: 12, color: PdfColors.red800, fontWeight: pw.FontWeight.bold)),
                
                pw.Spacer(),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 8),
                pw.Center(
                  child: pw.Text(
                    'Terima kasih telah mempercayakan pelatihan K3 Anda kepada Safenesia.',
                    style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
