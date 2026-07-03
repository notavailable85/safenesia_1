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

  @override
  void initState() {
    super.initState();
    title = widget.regulation?.title ?? '';
    category = widget.regulation?.category ?? '';
  }

  void saveRegulation() async {
    if (_formKey.currentState!.validate()) {
      final regulation = RegulationModel(
        id: widget.regulation?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        category: category,
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
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
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
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
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
