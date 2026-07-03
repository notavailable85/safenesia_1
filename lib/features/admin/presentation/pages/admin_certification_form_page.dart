import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/certification/models/certification_model.dart';

class AdminCertificationFormPage extends StatefulWidget {
  final CertModel? certification;

  const AdminCertificationFormPage({super.key, this.certification});

  @override
  State<AdminCertificationFormPage> createState() => _AdminCertificationFormPageState();
}

class _AdminCertificationFormPageState extends State<AdminCertificationFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String category;
  late String level;
  late int basePrice;

  @override
  void initState() {
    super.initState();
    title = widget.certification?.title ?? '';
    category = widget.certification?.category ?? '';
    level = widget.certification?.level ?? '';
    basePrice = widget.certification?.basePrice ?? 0;
  }

  void saveCertification() async {
    if (_formKey.currentState!.validate()) {
      final cert = CertModel(
        id: widget.certification?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        category: category,
        level: level,
        basePrice: basePrice,
      );

      if (widget.certification != null) {
        await DatabaseHelper.instance.updateCertification(cert);
      } else {
        await DatabaseHelper.instance.createCertification(cert);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.certification == null ? 'Add Certification' : 'Edit Certification'),
        backgroundColor: Colors.purple,
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
            const SizedBox(height: 16),
            TextFormField(
              initialValue: level,
              decoration: const InputDecoration(labelText: 'Level', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => level = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: basePrice.toString(),
              decoration: const InputDecoration(labelText: 'Base Price', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => basePrice = int.tryParse(value) ?? 0,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: saveCertification,
              child: const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
