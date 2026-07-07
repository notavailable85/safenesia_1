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
    required int primaryColorValue,
  }) async {
    final pdf = pw.Document();

    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    // Convert integer color to PdfColor
    final primaryColor = PdfColor(
      ((primaryColorValue >> 16) & 0xFF) / 255.0,
      ((primaryColorValue >> 8) & 0xFF) / 255.0,
      (primaryColorValue & 0xFF) / 255.0,
    );

    // Derived light color for UI backgrounds
    final lightColor = PdfColor(
      primaryColor.red + (1.0 - primaryColor.red) * 0.9,
      primaryColor.green + (1.0 - primaryColor.green) * 0.9,
      primaryColor.blue + (1.0 - primaryColor.blue) * 0.9,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(0),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              // ==========================================
              // HEADER BANNER
              // ==========================================
              pw.Container(
                color: primaryColor,
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 40,
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'INVOICE',
                          style: pw.TextStyle(
                            fontSize: 36,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'SAFENESIA',
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.white,
                            letterSpacing: 1,
                          ),
                        ),
                        pw.Text(
                          'Platform Pelatihan & Sertifikasi K3',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.white,
                          ),
                        ),
                      ],
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(12),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.white,
                        borderRadius: pw.BorderRadius.circular(8),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Total Tagihan',
                            style: pw.TextStyle(
                              color: PdfColors.grey700,
                              fontSize: 10,
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            currencyFormat.format(totalBayar),
                            style: pw.TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ==========================================
              // INVOICE DETAILS INFO
              // ==========================================
              pw.Padding(
                padding: const pw.EdgeInsets.all(40),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Left Column
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'DITAGIHKAN KEPADA:',
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.grey600,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Text(
                              'Peserta Pelatihan K3',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 2),
                            pw.Text(
                              'Melalui Sistem Safenesia',
                              style: const pw.TextStyle(
                                fontSize: 12,
                                color: PdfColors.grey800,
                              ),
                            ),
                          ],
                        ),
                        // Right Column
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [
                                pw.Text(
                                  'No. Invoice:',
                                  style: const pw.TextStyle(
                                    fontSize: 12,
                                    color: PdfColors.grey600,
                                  ),
                                ),
                                pw.SizedBox(width: 8),
                                pw.Text(
                                  invoiceNumber,
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [
                                pw.Text(
                                  'Tanggal Tagihan:',
                                  style: const pw.TextStyle(
                                    fontSize: 12,
                                    color: PdfColors.grey600,
                                  ),
                                ),
                                pw.SizedBox(width: 8),
                                pw.Text(
                                  DateFormat(
                                    'dd MMM yyyy',
                                  ).format(DateTime.now()),
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [
                                pw.Text(
                                  'Jatuh Tempo:',
                                  style: const pw.TextStyle(
                                    fontSize: 12,
                                    color: PdfColors.grey600,
                                  ),
                                ),
                                pw.SizedBox(width: 8),
                                pw.Text(
                                  deadlineStr,
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.red800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    pw.SizedBox(height: 40),

                    // ==========================================
                    // TABLE DETAILS
                    // ==========================================
                    pw.Text(
                      'RINCIAN PEMBAYARAN',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        letterSpacing: 1,
                        color: primaryColor,
                      ),
                    ),
                    pw.SizedBox(height: 12),

                    pw.Table(
                      columnWidths: {
                        0: const pw.FlexColumnWidth(4),
                        1: const pw.FlexColumnWidth(1),
                        2: const pw.FlexColumnWidth(2.5),
                        3: const pw.FlexColumnWidth(2.5),
                      },
                      children: [
                        // Table Header
                        pw.TableRow(
                          decoration: pw.BoxDecoration(
                            color: primaryColor,
                            borderRadius: const pw.BorderRadius.vertical(
                              top: pw.Radius.circular(6),
                            ),
                          ),
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              child: pw.Text(
                                'DESKRIPSI',
                                style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 8,
                              ),
                              child: pw.Text(
                                'QTY',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              child: pw.Text(
                                'HARGA SATUAN',
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              child: pw.Text(
                                'TOTAL',
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Table Row 1
                        pw.TableRow(
                          decoration: pw.BoxDecoration(
                            color: lightColor,
                            border: const pw.Border(
                              bottom: pw.BorderSide(
                                color: PdfColors.grey300,
                                width: 0.5,
                              ),
                              left: pw.BorderSide(
                                color: PdfColors.grey300,
                                width: 0.5,
                              ),
                              right: pw.BorderSide(
                                color: PdfColors.grey300,
                                width: 0.5,
                              ),
                            ),
                          ),
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              child: pw.Text(
                                namaPelatihan,
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 8,
                              ),
                              child: pw.Text(
                                jumlahPeserta.toString(),
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              child: pw.Text(
                                currencyFormat.format(hargaSatuan),
                                textAlign: pw.TextAlign.right,
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              child: pw.Text(
                                currencyFormat.format(totalBayar),
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    pw.SizedBox(height: 24),

                    // ==========================================
                    // TOTALS SUMMARY
                    // ==========================================
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Container(
                          width: 250,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: primaryColor,
                              width: 1.5,
                            ),
                            borderRadius: pw.BorderRadius.circular(8),
                          ),
                          child: pw.Column(
                            children: [
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(12),
                                child: pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Subtotal:',
                                      style: const pw.TextStyle(fontSize: 12),
                                    ),
                                    pw.Text(
                                      currencyFormat.format(totalBayar),
                                      style: const pw.TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              pw.Divider(
                                color: primaryColor,
                                thickness: 1.5,
                                height: 0,
                              ),
                              pw.Container(
                                color: lightColor,
                                padding: const pw.EdgeInsets.all(12),
                                child: pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'TOTAL TAGIHAN:',
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    pw.Text(
                                      currencyFormat.format(totalBayar),
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              pw.Spacer(),

              // ==========================================
              // FOOTER
              // ==========================================
              pw.Container(
                padding: const pw.EdgeInsets.all(40),
                decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Instruksi Pembayaran',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.grey800,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      'Harap selesaikan pembayaran melalui QRIS di dalam aplikasi sebelum batas waktu yang tertera. '
                      'Apabila Anda memiliki pertanyaan terkait tagihan ini, silakan hubungi tim support Safenesia.',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey700,
                        lineSpacing: 2,
                      ),
                    ),
                    pw.SizedBox(height: 24),
                    pw.Center(
                      child: pw.Text(
                        'Terima kasih telah berbisnis dengan kami!',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: primaryColor,
                          fontStyle: pw.FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
