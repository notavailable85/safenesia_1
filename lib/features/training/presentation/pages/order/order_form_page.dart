import 'package:flutter/material.dart';
import 'package:safenesia_1/features/training/presentation/pages/order/order_summary_page.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// ==========================================
// 3. HALAMAN FORM DATA PEMESAN & PESERTA
// ==========================================
class OrderFormPage extends StatefulWidget {
  final TrainingSchedule scheduleData;
  const OrderFormPage({super.key, required this.scheduleData});

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();

  // Form 1
  String _jenisPeserta = 'Pribadi';
  int _jumlahPeserta = 1;

  // Form 2 (Data Pemesan Utama)
  final _namaPemesanController = TextEditingController();
  final _waPemesanController = TextEditingController();
  final _emailPemesanController = TextEditingController();

  // Form 3 (Data Peserta)
  final List<TextEditingController> _namaPesertaControllers = [];
  final List<TextEditingController> _waPesertaControllers = [];
  final List<TextEditingController> _emailPesertaControllers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updatePesertaControllers();
    _loadData();
  }

  static const String _prefKey = 'order_form_temp_data';
  static const String _prefTimestampKey = 'order_form_timestamp';

  void _saveData() {
    // Ambil semua data secara sinkron sebelum controller di-dispose
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final data = {
      'schedule_id': widget.scheduleData.idJadwal,
      'jenis_peserta': _jenisPeserta,
      'jumlah_peserta': _jumlahPeserta,
      'nama_pemesan': _namaPemesanController.text,
      'wa_pemesan': _waPemesanController.text,
      'email_pemesan': _emailPemesanController.text,
      'peserta': List.generate(_jumlahPeserta, (i) {
        if (i < _namaPesertaControllers.length) {
          return {
            'nama': _namaPesertaControllers[i].text,
            'wa': _waPesertaControllers[i].text,
            'email': _emailPesertaControllers[i].text,
          };
        }
        return {'nama': '', 'wa': '', 'email': ''};
      }),
    };
    final dataString = json.encode(data);

    // Lakukan penyimpanan secara asynchronous
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
        return; // Data kadaluarsa
      }
    }

    final dataString = prefs.getString(_prefKey);
    if (dataString != null) {
      try {
        final data = json.decode(dataString) as Map<String, dynamic>;
        if (data['schedule_id'] == widget.scheduleData.idJadwal) {
          setState(() {
            _jenisPeserta = data['jenis_peserta'] ?? 'Pribadi';
            _jumlahPeserta = data['jumlah_peserta'] ?? 1;

            _namaPemesanController.text = data['nama_pemesan'] ?? '';
            _waPemesanController.text = data['wa_pemesan'] ?? '';
            _emailPemesanController.text = data['email_pemesan'] ?? '';

            _updatePesertaControllers();

            final List<dynamic>? peserta = data['peserta'];
            if (peserta != null) {
              for (int i = 0; i < peserta.length && i < _jumlahPeserta; i++) {
                _namaPesertaControllers[i].text = peserta[i]['nama'] ?? '';
                _waPesertaControllers[i].text = peserta[i]['wa'] ?? '';
                _emailPesertaControllers[i].text = peserta[i]['email'] ?? '';
              }
            }
          });
        }
      } catch (e) {
        debugPrint('Error loading form data: $e');
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

  void _updatePesertaControllers() {
    while (_namaPesertaControllers.length < _jumlahPeserta) {
      _namaPesertaControllers.add(TextEditingController());
      _waPesertaControllers.add(TextEditingController());
      _emailPesertaControllers.add(TextEditingController());
    }
    while (_namaPesertaControllers.length > _jumlahPeserta) {
      _namaPesertaControllers.removeLast().dispose();
      _waPesertaControllers.removeLast().dispose();
      _emailPesertaControllers.removeLast().dispose();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _saveData();
    _namaPemesanController.dispose();
    _waPemesanController.dispose();
    _emailPemesanController.dispose();
    for (var c in _namaPesertaControllers) {
      c.dispose();
    }
    for (var c in _waPesertaControllers) {
      c.dispose();
    }
    for (var c in _emailPesertaControllers) {
      c.dispose();
    }
    super.dispose();
  }

  String? _validateEmail(String? v) {
    if (v == null || v.isEmpty) return 'Wajib diisi';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(v))
      return 'Format email tidak valid (contoh: budi@email.com)';
    return null;
  }

  String? _validatePhone(String? v) {
    if (v == null || v.isEmpty) return 'Wajib diisi';

    String cleanNumber = v.replaceAll(' ', '').replaceAll('-', '');

    if (!RegExp(r'^\+?[0-9]+$').hasMatch(cleanNumber))
      return 'Hanya boleh berisi angka';
    if (cleanNumber.length < 9 || cleanNumber.length > 15)
      return 'Nomor tidak valid (9-15 digit)';
    if (!cleanNumber.startsWith('08') &&
        !cleanNumber.startsWith('62') &&
        !cleanNumber.startsWith('+62')) {
      return 'Harus diawali 08, 62, atau +62';
    }

    return null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Pemesan & Peserta')),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // --- FORM 1: TIPE & JUMLAH PESERTA ---
            Text(
              'Tipe & Jumlah Peserta',
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
                    DropdownButtonFormField<String>(
                      initialValue: _jenisPeserta,
                      decoration: _buildInputDecoration(
                        'Jenis Peserta',
                        Icons.group,
                      ),
                      items: ['Pribadi', 'Perusahaan']
                          .map(
                            (t) => DropdownMenuItem(value: t, child: Text(t)),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _jenisPeserta = val!),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      initialValue: _jumlahPeserta,
                      decoration: _buildInputDecoration(
                        'Jumlah Peserta (Maksimal 10)',
                        Icons.numbers,
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
                    'Data Pemesan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _namaPemesanController,
                      decoration: _buildInputDecoration(
                        'Nama Lengkap',
                        Icons.person,
                      ),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _waPemesanController,
                      decoration: _buildInputDecoration(
                        'No. WhatsApp',
                        Icons.phone,
                      ),
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailPemesanController,
                      decoration: _buildInputDecoration('Email', Icons.email),
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // --- FORM 3: DETAIL PESERTA ---
            Text(
              'Data Peserta (Wajib Diisi)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.person, size: 16),
                    label: const Text(
                      'Isi Data Saya',
                      style: TextStyle(fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Colors.green,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        if (_jumlahPeserta > 0) {
                          _namaPesertaControllers[0].text =
                              _namaPemesanController.text;
                          _waPesertaControllers[0].text =
                              _waPemesanController.text;
                          _emailPesertaControllers[0].text =
                              _emailPemesanController.text;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        if (_jumlahPeserta > 0) {
                          _namaPesertaControllers[0].clear();
                          _waPesertaControllers[0].clear();
                          _emailPesertaControllers[0].clear();
                        }
                      });
                    },
                    icon: const Icon(Icons.delete, size: 16),
                    label: const Text(
                      'Kosongkan',
                      style: TextStyle(fontSize: 12),
                    ),
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
                final bool isComplete =
                    _namaPesertaControllers[index].text.isNotEmpty &&
                    _waPesertaControllers[index].text.isNotEmpty &&
                    _emailPesertaControllers[index].text.isNotEmpty;
                final String namaPeserta = _namaPesertaControllers[index].text;
                final String titleText = namaPeserta.isNotEmpty
                    ? namaPeserta
                    : 'Peserta ${index + 1}';

                return Card(
                  color: isComplete
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.person,
                      color: isComplete ? Colors.green : Colors.red,
                    ),
                    initiallyExpanded: index == 0,
                    title: Text(
                      titleText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      TextFormField(
                        controller: _namaPesertaControllers[index],
                        decoration: _buildInputDecoration(
                          'Nama Lengkap',
                          Icons.person,
                        ),
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                        onChanged: (val) => setState(() {}),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _waPesertaControllers[index],
                        decoration: _buildInputDecoration(
                          'No. WhatsApp',
                          Icons.phone,
                        ),
                        keyboardType: TextInputType.phone,
                        validator: _validatePhone,
                        onChanged: (val) => setState(() {}),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailPesertaControllers[index],
                        decoration: _buildInputDecoration('Email', Icons.email),
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                        onChanged: (val) => setState(() {}),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Build data list from controllers
              List<Map<String, String>> daftarPeserta = List.generate(
                _jumlahPeserta,
                (i) => {
                  'nama_lengkap': _namaPesertaControllers[i].text,
                  'wa': _waPesertaControllers[i].text,
                  'email': _emailPesertaControllers[i].text,
                },
              );

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
