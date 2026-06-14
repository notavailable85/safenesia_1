import 'package:flutter/material.dart';
import 'package:safenesia_1/features/training/presentation/pages/order/order_summary_page.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';

// ==========================================
// 3. HALAMAN FORM DATA PEMESAN & PESERTA
// ==========================================
class OrderFormPage extends StatefulWidget {
  final TrainingSchedule scheduleData;
  const OrderFormPage({super.key, required this.scheduleData});

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

  // Form 3 (Data Peserta)
  final List<TextEditingController> _namaPesertaControllers = [];
  final List<TextEditingController> _ktpPesertaControllers = [];
  final List<TextEditingController> _waPesertaControllers = [];
  final List<TextEditingController> _emailPesertaControllers = [];

  @override
  void initState() {
    super.initState();
    _updatePesertaControllers();
  }

  void _updatePesertaControllers() {
    while (_namaPesertaControllers.length < _jumlahPeserta) {
      _namaPesertaControllers.add(TextEditingController());
      _ktpPesertaControllers.add(TextEditingController());
      _waPesertaControllers.add(TextEditingController());
      _emailPesertaControllers.add(TextEditingController());
    }
    while (_namaPesertaControllers.length > _jumlahPeserta) {
      _namaPesertaControllers.removeLast().dispose();
      _ktpPesertaControllers.removeLast().dispose();
      _waPesertaControllers.removeLast().dispose();
      _emailPesertaControllers.removeLast().dispose();
    }
  }

  @override
  void dispose() {
    _namaPemesanController.dispose();
    _ktpPemesanController.dispose();
    _waPemesanController.dispose();
    _emailPemesanController.dispose();
    for (var c in _namaPesertaControllers) { c.dispose(); }
    for (var c in _ktpPesertaControllers) { c.dispose(); }
    for (var c in _waPesertaControllers) { c.dispose(); }
    for (var c in _emailPesertaControllers) { c.dispose(); }
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Pemesan & Peserta')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // --- FORM 1: TIPE & JUMLAH PESERTA ---
            Text(
              'Tipe & Jumlah Peserta',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _jenisPeserta,
                      decoration: _buildInputDecoration('Jenis Peserta'),
                      items: ['Pribadi', 'Perusahaan']
                          .map(
                            (t) => DropdownMenuItem(value: t, child: Text(t)),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _jenisPeserta = val!),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<int>(
                      initialValue: _jumlahPeserta,
                      decoration: _buildInputDecoration('Jumlah Peserta (Maksimal 10)'),
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
                          _updatePesertaControllers();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // --- FORM 2: DATA PEMESAN ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Kontak Pemesan Utama',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _namaPemesanController,
                      decoration: _buildInputDecoration('Nama Lengkap'),
                      validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _ktpPemesanController,
                      decoration: _buildInputDecoration('Nomor KTP'),
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _waPemesanController,
                      decoration: _buildInputDecoration('No. WhatsApp'),
                      keyboardType: TextInputType.phone,
                      validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailPemesanController,
                      decoration: _buildInputDecoration('Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // --- FORM 3: DETAIL PESERTA ---
            Text(
              'Detail Setiap Peserta (Wajib Diisi)',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.person, size: 16),
                    label: const Text('Isi Data Saya (Peserta 1)', style: TextStyle(fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(color: Theme.of(context).colorScheme.primary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        if (_jumlahPeserta > 0) {
                          _namaPesertaControllers[0].text = _namaPemesanController.text;
                          _ktpPesertaControllers[0].text = _ktpPemesanController.text;
                          _waPesertaControllers[0].text = _waPemesanController.text;
                          _emailPesertaControllers[0].text = _emailPemesanController.text;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        if (_jumlahPeserta > 0) {
                          _namaPesertaControllers[0].clear();
                          _ktpPesertaControllers[0].clear();
                          _waPesertaControllers[0].clear();
                          _emailPesertaControllers[0].clear();
                        }
                      });
                    },
                    child: const Text('Kosongkan', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _jumlahPeserta,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ExpansionTile(
                    initiallyExpanded: index == 0,
                    title: Text(
                      'Peserta ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      TextFormField(
                        controller: _namaPesertaControllers[index],
                        decoration: _buildInputDecoration('Nama Lengkap Peserta'),
                        validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _ktpPesertaControllers[index],
                        decoration: _buildInputDecoration('Nomor KTP'),
                        keyboardType: TextInputType.number,
                        validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _waPesertaControllers[index],
                        decoration: _buildInputDecoration('No. WhatsApp'),
                        keyboardType: TextInputType.phone,
                        validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailPesertaControllers[index],
                        decoration: _buildInputDecoration('Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Build data list from controllers
                  List<Map<String, String>> daftarPeserta = List.generate(_jumlahPeserta, (i) => {
                    'nama': _namaPesertaControllers[i].text,
                    'ktp': _ktpPesertaControllers[i].text,
                    'wa': _waPesertaControllers[i].text,
                    'email': _emailPesertaControllers[i].text,
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderSummaryPage(
                        scheduleData: widget.scheduleData,
                        jumlahPeserta: _jumlahPeserta,
                        daftarPeserta: daftarPeserta,
                        jenisPeserta: _jenisPeserta,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Mohon lengkapi seluruh formulir dan detail data peserta!',
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Lanjut Ke Ringkasan Pemesanan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

