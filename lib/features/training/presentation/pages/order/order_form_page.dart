import 'package:flutter/material.dart';
import 'package:safenesia_1/features/training/presentation/pages/order/order_summary_page.dart';

import 'package:safenesia_1/features/training/presentation/pages/order/trainee_form_page.dart';

// ==========================================
// 3. HALAMAN FORM DATA PEMESAN & PESERTA
// ==========================================
class OrderFormPage extends StatefulWidget {
  final Map<String, dynamic> trainingData;
  const OrderFormPage({super.key, required this.trainingData});

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Form 1
  String _jenisPeserta = 'Pribadi';
  int _jumlahPeserta = 1;

  // Form 2 (Data Pemesan Utama)
  final _namaPemesanController = TextEditingController();
  final _ktpPemesanController = TextEditingController();
  final _waPemesanController = TextEditingController();
  final _emailPemesanController = TextEditingController();

  // Form 3 (Daftar Peserta detail)
  List<Map<String, String>> _daftarPeserta = [];

  @override
  void initState() {
    super.initState();
    _updatePesertaList();
  }

  void _updatePesertaList() {
    _daftarPeserta = List.generate(_jumlahPeserta, (index) {
      if (index < _daftarPeserta.length) return _daftarPeserta[index];
      return {'nama': '', 'ktp': '', 'wa': '', 'email': ''};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Pemesan & Peserta')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // --- FORM 1: TIPE & JUMLAH PESERTA ---
            const Text(
              'Form 1: Tipe & Jumlah Peserta',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _jenisPeserta,
                      decoration: const InputDecoration(
                        labelText: 'Jenis Peserta',
                      ),
                      items: ['Pribadi', 'Perusahaan']
                          .map(
                            (t) => DropdownMenuItem(value: t, child: Text(t)),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _jenisPeserta = val!),
                    ),
                    DropdownButtonFormField<int>(
                      value: _jumlahPeserta,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah Peserta (Maksimal 10)',
                      ),
                      items: List.generate(
                        10,
                        (i) => DropdownMenuItem(
                          value: i + 1,
                          child: Text('${i + 1} Orang'),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _jumlahPeserta = val!;
                          _updatePesertaList();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- FORM 2: DATA PEMESAN ---
            const Text(
              'Form 2: Kontak Pemesan Utama',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _namaPemesanController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                      ),
                      validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: _ktpPemesanController,
                      decoration: const InputDecoration(labelText: 'Nomor KTP'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _waPemesanController,
                      decoration: const InputDecoration(
                        labelText: 'No. WhatsApp',
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    TextFormField(
                      controller: _emailPemesanController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- FORM 3: DETAIL PESERTA ---
            const Text(
              'Form 3: Detail Setiap Peserta (Wajib Diisi)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _jumlahPeserta,
              itemBuilder: (context, index) {
                final p = _daftarPeserta[index];
                bool isDataFilled = p['nama']!.isNotEmpty;

                return Card(
                  color: isDataFilled
                      ? Colors.green.shade50
                      : Colors.orange.shade50,
                  child: ListTile(
                    title: Text(
                      'Peserta ${index + 1}: ${isDataFilled ? p['nama'] : "Belum diisi"}',
                    ),
                    subtitle: Text(
                      isDataFilled
                          ? 'KTP: ${p['ktp']}'
                          : 'Klik tombol edit di samping untuk mengisi data',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        // Arahkan ke halaman baru untuk input detail peserta
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPesertaInputPage(
                              index: index,
                              initialData: p,
                            ),
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            _daftarPeserta[index] = result;
                          });
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: () {
                // Validasi data peserta harus terisi semua
                bool allFilled = _daftarPeserta.every(
                  (p) => p['nama']!.isNotEmpty,
                );
                if (_formKey.currentState!.validate() && allFilled) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderSummaryPage(
                        trainingData: widget.trainingData,
                        jumlahPeserta: _jumlahPeserta,
                        daftarPeserta: _daftarPeserta,
                        jenisPeserta: _jenisPeserta,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Mohon lengkapi seluruh formulir dan detail data peserta!',
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
