import 'package:flutter/material.dart';
import 'package:safenesia_1/features/certification/presentation/pages/certification_model.dart';
import 'package:safenesia_1/features/certification/presentation/pages/order/order_summary_page.dart';

// ==========================================
// 3. HALAMAN FORM DATA PEMESAN & PERUSAHAAN
// ==========================================
class CertFormPage extends StatefulWidget {
  final CertModel certData;
  final bool withConsultation;
  final int consultationFee;
  final int totalPrice;

  const CertFormPage({
    super.key,
    required this.certData,
    required this.withConsultation,
    required this.consultationFee,
    required this.totalPrice,
  });

  @override
  State<CertFormPage> createState() => _CertFormPageState();
}

class _CertFormPageState extends State<CertFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Form 1: Detail Pemesan
  final _namaController = TextEditingController();
  final _ktpController = TextEditingController();
  final _waController = TextEditingController();
  final _emailController = TextEditingController();

  // Form 2: Detail Perusahaan
  final _namaPerusahaanController = TextEditingController();
  final _alamatPerusahaanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Pemesanan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // --- FORM 1: DETAIL PEMESAN ---
            const Text(
              'Form 1: Detail PIC / Pemesan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _namaController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Nama wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: _ktpController,
                      decoration: const InputDecoration(labelText: 'Nomor KTP'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'KTP wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: _waController,
                      decoration: const InputDecoration(
                        labelText: 'No. WhatsApp',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'WA wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) return 'Email wajib diisi';
                        if (!value.contains('@'))
                          return 'Format email tidak valid';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- FORM 2: DETAIL PERUSAHAAN ---
            const Text(
              'Form 2: Detail Perusahaan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _namaPerusahaanController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Perusahaan PT/CV',
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Nama Perusahaan wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: _alamatPerusahaanController,
                      decoration: const InputDecoration(
                        labelText: 'Alamat Lengkap Perusahaan',
                      ),
                      maxLines: 3,
                      validator: (value) =>
                          value!.isEmpty ? 'Alamat wajib diisi' : null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Kirim data ke halaman Ringkasan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CertSummaryPage(
                        certData: widget.certData,
                        withConsultation: widget.withConsultation,
                        consultationFee: widget.consultationFee,
                        totalPrice: widget.totalPrice,
                        namaPerusahaan: _namaPerusahaanController.text,
                        alamatPerusahaan: _alamatPerusahaanController.text,
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Lanjut Ke Ringkasan Pemesanan',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
