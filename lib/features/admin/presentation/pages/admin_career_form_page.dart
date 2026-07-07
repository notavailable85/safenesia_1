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
  late String jobType;
  late String experienceLevel;
  late int salaryMin;
  late int salaryMax;
  late String description;
  late String requirements;
  late String benefits;
  late String companyLogoUrl;

  @override
  void initState() {
    super.initState();
    title = widget.career?.title ?? '';
    company = widget.career?.company ?? '';
    field = widget.career?.field ?? '';
    location = widget.career?.location ?? '';
    jobType = widget.career?.jobType ?? 'Full-time';
    experienceLevel = widget.career?.experienceLevel ?? 'Entry Level';
    salaryMin = widget.career?.salaryMin ?? 0;
    salaryMax = widget.career?.salaryMax ?? 0;
    description = widget.career?.description ?? '';
    requirements = widget.career?.requirements ?? '';
    benefits = widget.career?.benefits ?? '';
    companyLogoUrl = widget.career?.companyLogoUrl ?? '';
  }

  void saveCareer() async {
    if (_formKey.currentState!.validate()) {
      final career = CareerModel(
        id:
            widget.career?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        company: company,
        field: field,
        location: location,
        jobType: jobType,
        experienceLevel: experienceLevel,
        salaryMin: salaryMin,
        salaryMax: salaryMax,
        description: description,
        requirements: requirements,
        benefits: benefits,
        postedDate:
            widget.career?.postedDate ?? DateTime.now().toIso8601String(),
        companyLogoUrl: companyLogoUrl,
        isSaved: widget.career?.isSaved ?? 0,
        isApplied: widget.career?.isApplied ?? 0,
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
        title: Text(
          widget.career == null ? 'Tambah Karir K3' : 'Edit Karir K3',
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Informasi Dasar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(
                labelText: 'Posisi / Jabatan',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Wajib diisi' : null,
              onChanged: (value) => title = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: company,
              decoration: const InputDecoration(
                labelText: 'Nama Perusahaan',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Wajib diisi' : null,
              onChanged: (value) => company = value,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: field,
                    decoration: const InputDecoration(
                      labelText: 'Bidang',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Wajib diisi' : null,
                    onChanged: (value) => field = value,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: location,
                    decoration: const InputDecoration(
                      labelText: 'Lokasi (Kota)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Wajib diisi' : null,
                    onChanged: (value) => location = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: jobType,
                    decoration: const InputDecoration(
                      labelText: 'Tipe Pekerjaan',
                      border: OutlineInputBorder(),
                    ),
                    items:
                        [
                              'Full-time',
                              'Part-time',
                              'Contract',
                              'Internship',
                              'Freelance',
                            ]
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                    onChanged: (value) => setState(() => jobType = value!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: experienceLevel,
                    decoration: const InputDecoration(
                      labelText: 'Level Pengalaman',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Entry Level', 'Mid Level', 'Senior']
                        .map(
                          (level) => DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => experienceLevel = value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: salaryMin == 0 ? '' : salaryMin.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Gaji Min',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => salaryMin = int.tryParse(value) ?? 0,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: salaryMax == 0 ? '' : salaryMax.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Gaji Max',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => salaryMax = int.tryParse(value) ?? 0,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              'Detail Pekerjaan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: description,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Pekerjaan',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              onChanged: (value) => description = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: requirements,
              decoration: const InputDecoration(
                labelText: 'Persyaratan',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              onChanged: (value) => requirements = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: benefits,
              decoration: const InputDecoration(
                labelText: 'Keuntungan / Benefit',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) => benefits = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: companyLogoUrl,
              decoration: const InputDecoration(
                labelText: 'URL Logo Perusahaan (Opsional)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => companyLogoUrl = value,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: saveCareer,
              child: const Text(
                'Simpan Lowongan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
