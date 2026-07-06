import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/regulation/models/regulation_model.dart';

class AdminRegulationFormPage extends StatefulWidget {
  final RegulationModel? regulation;

  const AdminRegulationFormPage({super.key, this.regulation});

  @override
  State<AdminRegulationFormPage> createState() => _AdminRegulationFormPageState();
}

class _AdminRegulationFormPageState extends State<AdminRegulationFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String category;
  late String nomor;
  late String tahun;
  late String deskripsi;
  late String fileUrl;

  @override
  void initState() {
    super.initState();
    title = widget.regulation?.title ?? '';
    category = widget.regulation?.category ?? '';
    nomor = widget.regulation?.nomor ?? '';
    tahun = widget.regulation?.tahun ?? '';
    deskripsi = widget.regulation?.deskripsi ?? '';
    fileUrl = widget.regulation?.fileUrl ?? '';
  }

  void saveRegulation() async {
    if (_formKey.currentState!.validate()) {
      final regulation = RegulationModel(
        id: widget.regulation?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        category: category,
        nomor: nomor,
        tahun: tahun,
        deskripsi: deskripsi,
        fileUrl: fileUrl,
      );

      if (widget.regulation != null) {
        await DatabaseHelper.instance.updateRegulation(regulation);
      } else {
        await DatabaseHelper.instance.createRegulation(regulation);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.regulation == null ? 'Add Regulation' : 'Edit Regulation'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => title = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: category,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => category = value,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: nomor,
                    decoration: const InputDecoration(labelText: 'Nomor (e.g. UU No 1)', border: OutlineInputBorder()),
                    onChanged: (value) => nomor = value,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: tahun,
                    decoration: const InputDecoration(labelText: 'Tahun', border: OutlineInputBorder()),
                    onChanged: (value) => tahun = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: deskripsi,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
              onChanged: (value) => deskripsi = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: fileUrl,
              decoration: const InputDecoration(labelText: 'URL File PDF', border: OutlineInputBorder()),
              onChanged: (value) => fileUrl = value,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: saveRegulation,
              child: const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
