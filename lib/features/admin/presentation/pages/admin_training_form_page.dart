import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/training/models/training_model.dart';

class AdminTrainingFormPage extends StatefulWidget {
  final Training?
  training; // Jika null berarti tambah, jika tidak berarti update

  const AdminTrainingFormPage({super.key, this.training});

  @override
  State<AdminTrainingFormPage> createState() => _AdminTrainingFormPageState();
}

class _AdminTrainingFormPageState extends State<AdminTrainingFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  late TextEditingController _kodeBidangController;
  late TextEditingController _namaPelatihanController;
  late TextEditingController _namaPelatihanKapitalController;
  late TextEditingController _kodePelatihanController;
  late TextEditingController _durasiController;
  late TextEditingController _hargaPromoController;
  late TextEditingController _hargaNormalController;
  late TextEditingController _deskripsiController;
  late TextEditingController _dasarHukumController;
  late TextEditingController _tujuanController;
  late TextEditingController _materiController;
  late TextEditingController _syaratAdministrasiController;
  late TextEditingController _fasilitasController;
  late TextEditingController _metodeController;
  late TextEditingController _detailMetodeController;
  late TextEditingController _syaratKetentuanController;
  late TextEditingController _instrukturController;
  late TextEditingController _keteranganController;
  late TextEditingController _gambarPelatihanController;

  // Dropdown states
  String _selectedBidang = 'Keahlian K3 Umum';
  String _selectedSertifikasi = 'Sertifikasi Kemnaker RI';
  String _selectedStatus = 'Aktif';

  final List<String> _bidangList = [
    'Keahlian K3 Umum',
    'Sistem Manajemen K3',
    'Listrik',
    'Konstruksi dan Bangunan',
    'Penanggulangan Kebakaran',
    'Elevator dan Eskalator',
    'Lingkungan Kerja dan Bahan Berbahaya',
    'Bekerja Pada Ketinggian',
    'Kesehatan Kerja',
    'Pesawat Angkat dan Pesawat Angkut',
    'Pesawat Tenaga dan Produksi',
    'Pesawat Uap, Bejana Tekanan dan Tangki Timbun',
    'Pengelasan',
  ];

  final List<String> _sertifikasiList = [
    'Sertifikasi Kemnaker RI',
    'Sertifikasi BNSP',
    'Sertifikasi Safenesia',
  ];

  final List<String> _statusList = ['Aktif', 'Tidak Aktif'];

  @override
  void initState() {
    super.initState();
    final t = widget.training;

    _kodeBidangController = TextEditingController(text: t?.kodeBidang ?? '');
    _namaPelatihanController = TextEditingController(
      text: t?.namaPelatihan ?? '',
    );
    _namaPelatihanKapitalController = TextEditingController(
      text: t?.namaPelatihanKapital ?? '',
    );
    _kodePelatihanController = TextEditingController(
      text: t?.kodePelatihan ?? '',
    );
    _durasiController = TextEditingController(text: t?.durasi ?? '');
    _hargaPromoController = TextEditingController(
      text: t?.hargaPromo.toString() ?? '',
    );
    _hargaNormalController = TextEditingController(
      text: t?.hargaNormal.toString() ?? '',
    );
    _deskripsiController = TextEditingController(text: t?.deskripsi ?? '');
    _dasarHukumController = TextEditingController(text: t?.dasarHukum ?? '');
    _tujuanController = TextEditingController(text: t?.tujuan ?? '');
    _materiController = TextEditingController(text: t?.materi ?? '');
    _syaratAdministrasiController = TextEditingController(
      text: t?.syaratAdministrasi ?? '',
    );
    _fasilitasController = TextEditingController(text: t?.fasilitas ?? '');
    _metodeController = TextEditingController(text: t?.metode ?? '');
    _detailMetodeController = TextEditingController(
      text: t?.detailMetode ?? '',
    );
    _syaratKetentuanController = TextEditingController(
      text: t?.syaratKetentuan ?? '',
    );
    _instrukturController = TextEditingController(text: t?.instruktur ?? '');
    _keteranganController = TextEditingController(text: t?.keterangan ?? '');
    _gambarPelatihanController = TextEditingController(
      text: t?.gambarPelatihan ?? '',
    );

    if (t != null) {
      if (_bidangList.contains(t.bidang)) _selectedBidang = t.bidang;
      if (_sertifikasiList.contains(t.sertifikasi))
        _selectedSertifikasi = t.sertifikasi;
      if (_statusList.contains(t.status)) _selectedStatus = t.status;
    }
  }

  @override
  void dispose() {
    _kodeBidangController.dispose();
    _namaPelatihanController.dispose();
    _namaPelatihanKapitalController.dispose();
    _kodePelatihanController.dispose();
    _durasiController.dispose();
    _hargaPromoController.dispose();
    _hargaNormalController.dispose();
    _deskripsiController.dispose();
    _dasarHukumController.dispose();
    _tujuanController.dispose();
    _materiController.dispose();
    _syaratAdministrasiController.dispose();
    _fasilitasController.dispose();
    _metodeController.dispose();
    _detailMetodeController.dispose();
    _syaratKetentuanController.dispose();
    _instrukturController.dispose();
    _keteranganController.dispose();
    _gambarPelatihanController.dispose();
    super.dispose();
  }

  Future<void> _saveTraining() async {
    if (_formKey.currentState!.validate()) {
      final isUpdating = widget.training != null;
      final training = Training(
        idPelatihan: isUpdating
            ? widget.training!.idPelatihan
            : DateTime.now().millisecondsSinceEpoch.toString(),
        kodeBidang: _kodeBidangController.text,
        bidang: _selectedBidang,
        namaPelatihan: _namaPelatihanController.text,
        namaPelatihanKapital: _namaPelatihanKapitalController.text,
        kodePelatihan: _kodePelatihanController.text,
        durasi: _durasiController.text,
        hargaPromo: int.tryParse(_hargaPromoController.text) ?? 0,
        hargaNormal: int.tryParse(_hargaNormalController.text) ?? 0,
        sertifikasi: _selectedSertifikasi,
        status: _selectedStatus,
        deskripsi: _deskripsiController.text,
        dasarHukum: _dasarHukumController.text,
        tujuan: _tujuanController.text,
        materi: _materiController.text,
        syaratAdministrasi: _syaratAdministrasiController.text,
        fasilitas: _fasilitasController.text,
        metode: _metodeController.text,
        detailMetode: _detailMetodeController.text,
        syaratKetentuan: _syaratKetentuanController.text,
        instruktur: _instrukturController.text,
        keterangan: _keteranganController.text,
        gambarPelatihan: _gambarPelatihanController.text,
      );

      if (isUpdating) {
        await DatabaseHelper.instance.updateTraining(training);
      } else {
        await DatabaseHelper.instance.createTraining(training);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text(
              isUpdating
                  ? 'Master Pelatihan diperbarui'
                  : 'Master Pelatihan ditambahkan',
            ),
          ),
        );
      }
    }
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap isi $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.training == null
              ? 'Tambah Master Pelatihan'
              : 'Edit Master Pelatihan',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_namaPelatihanController, 'Nama Pelatihan'),
              _buildTextField(
                _namaPelatihanKapitalController,
                'Nama Pelatihan (Kapital)',
              ),
              _buildTextField(_kodePelatihanController, 'Kode Pelatihan'),
              _buildTextField(_kodeBidangController, 'Kode Bidang'),

              DropdownButtonFormField(
                initialValue: _selectedBidang,
                decoration: const InputDecoration(
                  labelText: 'Bidang / Kategori',
                  border: OutlineInputBorder(),
                ),
                items: _bidangList
                    .map(
                      (String b) => DropdownMenuItem(value: b, child: Text(b)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedBidang = val!),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField(
                initialValue: _selectedSertifikasi,
                decoration: const InputDecoration(
                  labelText: 'Sertifikasi',
                  border: OutlineInputBorder(),
                ),
                items: _sertifikasiList
                    .map(
                      (String s) => DropdownMenuItem(value: s, child: Text(s)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedSertifikasi = val!),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField(
                initialValue: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: _statusList
                    .map(
                      (String s) => DropdownMenuItem(value: s, child: Text(s)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedStatus = val!),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      _hargaNormalController,
                      'Harga Normal (Rp)',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      _hargaPromoController,
                      'Harga Promo (Rp)',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              _buildTextField(_durasiController, 'Durasi (misal: 3 Hari)'),
              const SizedBox(height: 16),

              _buildTextField(_deskripsiController, 'Deskripsi', maxLines: 3),
              _buildTextField(
                _dasarHukumController,
                'Dasar Hukum',
                maxLines: 2,
              ),
              _buildTextField(_tujuanController, 'Tujuan', maxLines: 2),
              _buildTextField(_materiController, 'Materi', maxLines: 3),
              _buildTextField(
                _syaratAdministrasiController,
                'Syarat Administrasi',
                maxLines: 2,
              ),
              _buildTextField(_fasilitasController, 'Fasilitas', maxLines: 2),
              _buildTextField(_metodeController, 'Metode (e.g. Offline)'),
              _buildTextField(
                _detailMetodeController,
                'Detail Metode',
                maxLines: 2,
              ),
              _buildTextField(
                _syaratKetentuanController,
                'Syarat Ketentuan',
                maxLines: 2,
              ),
              _buildTextField(_instrukturController, 'Instruktur'),
              _buildTextField(_keteranganController, 'Keterangan'),
              _buildTextField(
                _gambarPelatihanController,
                'URL Gambar Pelatihan (Opsional)',
                maxLines: 1,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _saveTraining,
                child: const Text(
                  'Simpan Master Pelatihan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
