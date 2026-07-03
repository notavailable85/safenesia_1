import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/career/models/career_model.dart';

class AdminCareerFormPage extends StatefulWidget {
  final CareerModel? career;

  const AdminCareerFormPage({super.key, this.career});

  @override
  State<AdminCareerFormPage> createState() => _AdminCareerFormPageState();
}

class _AdminCareerFormPageState extends State<AdminCareerFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String company;
  late String field;
  late String location;
  late int salaryMin;
  late int salaryMax;
  late int isSaved;

  @override
  void initState() {
    super.initState();
    title = widget.career?.title ?? '';
    company = widget.career?.company ?? '';
    field = widget.career?.field ?? '';
    location = widget.career?.location ?? '';
    salaryMin = widget.career?.salaryMin ?? 0;
    salaryMax = widget.career?.salaryMax ?? 0;
    isSaved = widget.career?.isSaved ?? 0;
  }

  void saveCareer() async {
    if (_formKey.currentState!.validate()) {
      final career = CareerModel(
        id: widget.career?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        company: company,
        field: field,
        location: location,
        salaryMin: salaryMin,
        salaryMax: salaryMax,
        isSaved: isSaved,
      );

      if (widget.career != null) {
        await DatabaseHelper.instance.updateCareer(career);
      } else {
        await DatabaseHelper.instance.createCareer(career);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.career == null ? 'Add Career' : 'Edit Career'),
        backgroundColor: Colors.brown,
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
              initialValue: company,
              decoration: const InputDecoration(labelText: 'Company', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => company = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: field,
              decoration: const InputDecoration(labelText: 'Field', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => field = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: location,
              decoration: const InputDecoration(labelText: 'Location', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => location = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: salaryMin.toString(),
              decoration: const InputDecoration(labelText: 'Minimum Salary', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => salaryMin = int.tryParse(value) ?? 0,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: salaryMax.toString(),
              decoration: const InputDecoration(labelText: 'Maximum Salary', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => salaryMax = int.tryParse(value) ?? 0,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: saveCareer,
              child: const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
