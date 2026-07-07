import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safenesia_1/features/certification/models/certification_model.dart';
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

class _CertFormPageState extends State<CertFormPage>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();

  // Form 1: Detail Pemesan
  final _namaController = TextEditingController();
  final _waController = TextEditingController();
  final _emailController = TextEditingController();

  // Form 2: Detail Perusahaan
  final _namaPerusahaanController = TextEditingController();
  final _alamatPerusahaanController = TextEditingController();

  static const String _prefKey = 'cert_order_form_temp_data';
  static const String _prefTimestampKey = 'cert_order_form_timestamp';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadData();
  }

  void _saveData() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final data = {
      'cert_id': widget.certData.id,
      'with_consultation': widget.withConsultation,
      'nama': _namaController.text,
      'wa': _waController.text,
      'email': _emailController.text,
      'nama_perusahaan': _namaPerusahaanController.text,
      'alamat_perusahaan': _alamatPerusahaanController.text,
    };
    final dataString = json.encode(data);

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_prefTimestampKey, timestamp);
      prefs.setString(_prefKey, dataString);
    });
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final timestamp = prefs.getInt(_prefTimestampKey);
    if (timestamp != null) {
      final savedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final difference = DateTime.now().difference(savedTime);
      if (difference.inMinutes >= 10) {
        await prefs.remove(_prefKey);
        await prefs.remove(_prefTimestampKey);
        return;
      }
    }

    final dataString = prefs.getString(_prefKey);
    if (dataString != null) {
      try {
        final data = json.decode(dataString) as Map<String, dynamic>;
        if (data['cert_id'] == widget.certData.id &&
            data['with_consultation'] == widget.withConsultation) {
          setState(() {
            _namaController.text = data['nama'] ?? '';
            _waController.text = data['wa'] ?? '';
            _emailController.text = data['email'] ?? '';
            _namaPerusahaanController.text = data['nama_perusahaan'] ?? '';
            _alamatPerusahaanController.text = data['alamat_perusahaan'] ?? '';
          });
        }
      } catch (e) {
        debugPrint('Error loading cert form data: $e');
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _saveData();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _saveData();
    _namaController.dispose();
    _waController.dispose();
    _emailController.dispose();
    _namaPerusahaanController.dispose();
    _alamatPerusahaanController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 14),
      floatingLabelStyle: const TextStyle(fontSize: 12),
      isDense: true,
      prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2.0,
        ),
      ),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: _buildInputDecoration(label, icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir Pemesanan')),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // --- FORM 1: DETAIL PEMESAN ---
            Text(
              'Detail PIC / Pemesan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _namaController,
                      label: 'Nama Lengkap',
                      icon: Icons.person,
                      validator: (value) =>
                          value!.isEmpty ? 'Nama wajib diisi' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _waController,
                      label: 'No. WhatsApp',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'WA wajib diisi' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) return 'Email wajib diisi';
                        if (!value.contains('@')) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- FORM 2: DETAIL PERUSAHAAN ---
            Text(
              'Detail Perusahaan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _namaPerusahaanController,
                      label: 'Nama Perusahaan (PT/CV)',
                      icon: Icons.business,
                      validator: (value) =>
                          value!.isEmpty ? 'Nama Perusahaan wajib diisi' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _alamatPerusahaanController,
                      label: 'Alamat Lengkap Perusahaan',
                      icon: Icons.location_on,
                      validator: (value) =>
                          value!.isEmpty ? 'Alamat wajib diisi' : null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
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
            if (_formKey.currentState!.validate()) {
              // Bersihkan cache jika submit
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove(_prefKey);
              await prefs.remove(_prefTimestampKey);

              if (context.mounted) {
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
            }
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selanjutnya',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}
