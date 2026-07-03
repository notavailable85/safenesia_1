import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/training/models/training_model.dart';

class AdminTrainingFormPage extends StatefulWidget {
  final Training? training;

  const AdminTrainingFormPage({super.key, this.training});

  @override
  State<AdminTrainingFormPage> createState() => _AdminTrainingFormPageState();
}

class _AdminTrainingFormPageState extends State<AdminTrainingFormPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {};

  final List<String> fields = [
    'kodeBidang', 'bidang', 'namaPelatihan', 'namaPelatihanKapital', 'kodePelatihan',
    'durasi', 'hargaPromo', 'hargaNormal', 'sertifikasi', 'status', 'deskripsi',
    'dasarHukum', 'tujuan', 'materi', 'syaratAdministrasi', 'fasilitas', 'metode',
    'detailMetode', 'syaratKetentuan', 'instruktur', 'keterangan', 'gambarPelatihan',
    'namaLokasi', 'linkPetaLokasi'
  ];

  @override
  void initState() {
    super.initState();
    for (var field in fields) {
      _controllers[field] = TextEditingController();
    }
    if (widget.training != null) {
      final t = widget.training!;
      _controllers['kodeBidang']?.text = t.kodeBidang;
      _controllers['bidang']?.text = t.bidang;
      _controllers['namaPelatihan']?.text = t.namaPelatihan;
      _controllers['namaPelatihanKapital']?.text = t.namaPelatihanKapital;
      _controllers['kodePelatihan']?.text = t.kodePelatihan;
      _controllers['durasi']?.text = t.durasi;
      _controllers['hargaPromo']?.text = t.hargaPromo.toString();
      _controllers['hargaNormal']?.text = t.hargaNormal.toString();
      _controllers['sertifikasi']?.text = t.sertifikasi;
      _controllers['status']?.text = t.status;
      _controllers['deskripsi']?.text = t.deskripsi;
      _controllers['dasarHukum']?.text = t.dasarHukum;
      _controllers['tujuan']?.text = t.tujuan;
      _controllers['materi']?.text = t.materi;
      _controllers['syaratAdministrasi']?.text = t.syaratAdministrasi;
      _controllers['fasilitas']?.text = t.fasilitas;
      _controllers['metode']?.text = t.metode;
      _controllers['detailMetode']?.text = t.detailMetode;
      _controllers['syaratKetentuan']?.text = t.syaratKetentuan;
      _controllers['instruktur']?.text = t.instruktur;
      _controllers['keterangan']?.text = t.keterangan;
      _controllers['gambarPelatihan']?.text = t.gambarPelatihan;
      _controllers['namaLokasi']?.text = t.namaLokasi ?? '';
      _controllers['linkPetaLokasi']?.text = t.linkPetaLokasi ?? '';
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void saveTraining() async {
    if (_formKey.currentState!.validate()) {
      final t = Training(
        idPelatihan: widget.training?.idPelatihan ?? DateTime.now().millisecondsSinceEpoch.toString(),
        kodeBidang: _controllers['kodeBidang']!.text,
        bidang: _controllers['bidang']!.text,
        namaPelatihan: _controllers['namaPelatihan']!.text,
        namaPelatihanKapital: _controllers['namaPelatihanKapital']!.text,
        kodePelatihan: _controllers['kodePelatihan']!.text,
        durasi: _controllers['durasi']!.text,
        hargaPromo: int.tryParse(_controllers['hargaPromo']!.text) ?? 0,
        hargaNormal: int.tryParse(_controllers['hargaNormal']!.text) ?? 0,
        sertifikasi: _controllers['sertifikasi']!.text,
        status: _controllers['status']!.text,
        deskripsi: _controllers['deskripsi']!.text,
        dasarHukum: _controllers['dasarHukum']!.text,
        tujuan: _controllers['tujuan']!.text,
        materi: _controllers['materi']!.text,
        syaratAdministrasi: _controllers['syaratAdministrasi']!.text,
        fasilitas: _controllers['fasilitas']!.text,
        metode: _controllers['metode']!.text,
        detailMetode: _controllers['detailMetode']!.text,
        syaratKetentuan: _controllers['syaratKetentuan']!.text,
        instruktur: _controllers['instruktur']!.text,
        keterangan: _controllers['keterangan']!.text,
        gambarPelatihan: _controllers['gambarPelatihan']!.text,
        namaLokasi: _controllers['namaLokasi']!.text,
        linkPetaLokasi: _controllers['linkPetaLokasi']!.text,
      );

      if (widget.training != null) {
        await DatabaseHelper.instance.updateTraining(t);
      } else {
        await DatabaseHelper.instance.createTraining(t);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.training == null ? 'Add Training' : 'Edit Training'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ...fields.map((field) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextFormField(
                  controller: _controllers[field],
                  decoration: InputDecoration(
                    labelText: field.toUpperCase(),
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: ['deskripsi', 'dasarHukum', 'tujuan', 'materi', 'syaratAdministrasi', 'fasilitas', 'syaratKetentuan'].contains(field) ? 3 : 1,
                  keyboardType: ['hargaPromo', 'hargaNormal'].contains(field) ? TextInputType.number : TextInputType.text,
                  validator: (value) {
                    if (['namaLokasi', 'linkPetaLokasi'].contains(field)) return null; // Optional fields
                    return value == null || value.isEmpty ? 'Required' : null;
                  },
                ),
              );
            }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: saveTraining,
              child: const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
