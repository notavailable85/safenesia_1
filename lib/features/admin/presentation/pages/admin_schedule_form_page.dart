import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/training/models/training_model.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';
import 'package:safenesia_1/features/training/models/training_location_model.dart';

class AdminScheduleFormPage extends StatefulWidget {
  final TrainingSchedule? schedule;

  const AdminScheduleFormPage({super.key, this.schedule});

  @override
  State<AdminScheduleFormPage> createState() => _AdminScheduleFormPageState();
}

class _AdminScheduleFormPageState extends State<AdminScheduleFormPage> {
  final _formKey = GlobalKey<FormState>();

  List<Training> _masterTrainings = [];
  String? _selectedIdPelatihan;
  String? _selectedLokasi;
  String? _linkPetaLokasi;

  late TextEditingController _gambarController;

  DateTime _tanggalStart = DateTime.now();
  DateTime _tanggalEnd = DateTime.now().add(const Duration(days: 3));

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _gambarController = TextEditingController(text: widget.schedule?.gambar ?? '');

    if (widget.schedule != null) {
      _tanggalStart = DateTime.tryParse(widget.schedule!.tanggalStart) ?? DateTime.now();
      _tanggalEnd = DateTime.tryParse(widget.schedule!.tanggalEnd) ?? DateTime.now().add(const Duration(days: 3));
      _selectedLokasi = widget.schedule!.namaLokasi;
      _linkPetaLokasi = widget.schedule!.linkPetaLokasi;
    }
    
    _loadMasterTrainings();
  }

  Future<void> _loadMasterTrainings() async {
    try {
      final trainings = await DatabaseHelper.instance.readAllTrainings();
      setState(() {
        _masterTrainings = trainings;
        if (trainings.isNotEmpty) {
          // If editing, try to select existing training ID. Otherwise, pick first.
          if (widget.schedule != null && trainings.any((t) => t.idPelatihan == widget.schedule!.idPelatihan)) {
            _selectedIdPelatihan = widget.schedule!.idPelatihan;
          } else {
            _selectedIdPelatihan = trainings.first.idPelatihan;
          }
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime initialDate = isStart ? _tanggalStart : _tanggalEnd;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _tanggalStart = picked;
          // auto adjust end date if it's before start date
          if (_tanggalEnd.isBefore(_tanggalStart)) {
            _tanggalEnd = _tanggalStart.add(const Duration(days: 3));
          }
        } else {
          _tanggalEnd = picked;
        }
      });
    }
  }

  @override
  void dispose() {
    _gambarController.dispose();
    super.dispose();
  }

  Future<void> _saveSchedule() async {
    if (_formKey.currentState!.validate() && _selectedIdPelatihan != null) {
      final isUpdating = widget.schedule != null;
      final schedule = TrainingSchedule(
        idJadwal: isUpdating ? widget.schedule!.idJadwal : DateTime.now().millisecondsSinceEpoch.toString(),
        idPelatihan: _selectedIdPelatihan!,
        tanggalStart: _tanggalStart.toIso8601String(),
        tanggalEnd: _tanggalEnd.toIso8601String(),
        gambar: _gambarController.text,
        namaLokasi: _selectedLokasi,
        linkPetaLokasi: _linkPetaLokasi,
      );

      if (isUpdating) {
        await DatabaseHelper.instance.updateSchedule(schedule);
      } else {
        await DatabaseHelper.instance.createSchedule(schedule);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isUpdating ? 'Jadwal diperbarui' : 'Jadwal ditambahkan')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_masterTrainings.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Buat Jadwal Baru')),
        body: const Center(
          child: Text('Data Master Pelatihan masih kosong. Harap isi data pelatihan terlebih dahulu.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.schedule == null ? 'Tambah Jadwal Pelatihan' : 'Edit Jadwal Pelatihan'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedIdPelatihan,
                decoration: const InputDecoration(labelText: 'Pilih Pelatihan', border: OutlineInputBorder()),
                items: _masterTrainings.map((t) {
                  return DropdownMenuItem(value: t.idPelatihan, child: Text(t.namaPelatihan));
                }).toList(),
                onChanged: (val) => setState(() => _selectedIdPelatihan = val),
                validator: (val) => val == null ? 'Pilih pelatihan terlebih dahulu' : null,
              ),
              const SizedBox(height: 16),

              // Tanggal Mulai
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.outline), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal Mulai', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                          Text('${_tanggalStart.day}/${_tanggalStart.month}/${_tanggalStart.year}', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, true),
                      child: const Text('Ubah'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Tanggal Selesai
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.outline), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal Selesai', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                          Text('${_tanggalEnd.day}/${_tanggalEnd.month}/${_tanggalEnd.year}', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, false),
                      child: const Text('Ubah'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedLokasi,
                decoration: const InputDecoration(labelText: 'Pilih Lokasi', border: OutlineInputBorder()),
                items: [
                  const DropdownMenuItem<String>(value: null, child: Text('Sesuai Metode Pelatihan')),
                  ...TrainingLocation.dummyLocations.map((loc) {
                    return DropdownMenuItem(value: loc.namaLokasi, child: Text(loc.namaLokasi));
                  }),
                ],
                onChanged: (val) {
                  setState(() {
                    _selectedLokasi = val;
                    if (val != null) {
                      final loc = TrainingLocation.dummyLocations.firstWhere((l) => l.namaLokasi == val);
                      _linkPetaLokasi = loc.petaLokasi;
                    } else {
                      _linkPetaLokasi = null;
                    }
                  });
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _gambarController,
                decoration: const InputDecoration(
                  labelText: 'URL Gambar Banner Pelatihan (Opsional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(

                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _saveSchedule,
                child: const Text('Publikasikan Jadwal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
