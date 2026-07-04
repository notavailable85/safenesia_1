import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/training/models/training_model.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';

class AdminScheduleFormPage extends StatefulWidget {
  final TrainingSchedule? schedule;

  const AdminScheduleFormPage({super.key, this.schedule});

  @override
  State<AdminScheduleFormPage> createState() => _AdminScheduleFormPageState();
}

class _AdminScheduleFormPageState extends State<AdminScheduleFormPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedTrainingId;
  String tanggalStart = DateTime.now().toIso8601String().split('T').first;
  String tanggalEnd = DateTime.now().add(const Duration(days: 3)).toIso8601String().split('T').first;
  String gambar = '';
  String namaLokasi = '';
  String linkPetaLokasi = '';

  List<Training> trainings = [];

  @override
  void initState() {
    super.initState();
    if (widget.schedule != null) {
      selectedTrainingId = widget.schedule!.idPelatihan;
      tanggalStart = widget.schedule!.tanggalStart;
      tanggalEnd = widget.schedule!.tanggalEnd;
      gambar = widget.schedule!.gambar;
      namaLokasi = widget.schedule!.namaLokasi ?? '';
      linkPetaLokasi = widget.schedule!.linkPetaLokasi ?? '';
    }
    _loadTrainings();
  }

  void _loadTrainings() async {
    final t = await DatabaseHelper.instance.readAllTrainings();
    setState(() {
      trainings = t;
    });
  }

  void saveSchedule() async {
    if (_formKey.currentState!.validate() && selectedTrainingId != null) {
      final s = TrainingSchedule(
        idJadwal: widget.schedule?.idJadwal ?? DateTime.now().millisecondsSinceEpoch.toString(),
        idPelatihan: selectedTrainingId!,
        tanggalStart: tanggalStart,
        tanggalEnd: tanggalEnd,
        gambar: gambar,
        namaLokasi: namaLokasi,
        linkPetaLokasi: linkPetaLokasi,
      );

      if (widget.schedule != null) {
        await DatabaseHelper.instance.updateSchedule(s);
      } else {
        await DatabaseHelper.instance.createSchedule(s);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.schedule == null ? 'Add Schedule' : 'Edit Schedule'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              value: trainings.any((t) => t.idPelatihan == selectedTrainingId) ? selectedTrainingId : null,
              decoration: const InputDecoration(labelText: 'Training', border: OutlineInputBorder()),
              items: trainings.map((t) {
                return DropdownMenuItem(
                  value: t.idPelatihan,
                  child: Text(t.namaPelatihan),
                );
              }).toList(),
              onChanged: (val) {
                setState(() => selectedTrainingId = val);
              },
              validator: (val) => val == null ? 'Please select a training' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: tanggalStart,
              decoration: const InputDecoration(labelText: 'Start Date (YYYY-MM-DD)', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (val) => tanggalStart = val,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: tanggalEnd,
              decoration: const InputDecoration(labelText: 'End Date (YYYY-MM-DD)', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (val) => tanggalEnd = val,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: gambar,
              decoration: const InputDecoration(labelText: 'Image URL', border: OutlineInputBorder()),
              onChanged: (val) => gambar = val,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: namaLokasi,
              decoration: const InputDecoration(labelText: 'Location Name (Optional)', border: OutlineInputBorder()),
              onChanged: (val) => namaLokasi = val,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: linkPetaLokasi,
              decoration: const InputDecoration(labelText: 'Map URL (Optional)', border: OutlineInputBorder()),
              onChanged: (val) => linkPetaLokasi = val,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: saveSchedule,
              child: const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
