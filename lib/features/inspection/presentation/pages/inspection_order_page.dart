import 'package:flutter/material.dart';
import 'package:safenesia_1/features/inspection/models/inspection_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';

class InspectionOrderPage extends StatefulWidget {
  const InspectionOrderPage({super.key});

  @override
  State<InspectionOrderPage> createState() => _InspectionOrderPageState();
}

class _InspectionOrderPageState extends State<InspectionOrderPage> {
  final _formKey = GlobalKey<FormState>();

  String companyName = '';
  String equipmentType = 'Pesawat Angkat Angkut (Crane)';
  String location = '';
  String notes = '';
  DateTime? scheduledDate;

  final List<String> equipmentTypes = [
    'Pesawat Angkat Angkut (Crane)',
    'Bejana Tekan (Boiler)',
    'Pesawat Tenaga dan Produksi (Genset)',
    'Instalasi Listrik',
    'Lift / Escalator',
    'Penyalur Petir',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => scheduledDate = picked);
    }
  }

  void _submitOrder() async {
    if (_formKey.currentState!.validate()) {
      if (scheduledDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 1500),
            content: Text('Pilih tanggal inspeksi terlebih dahulu'),
          ),
        );
        return;
      }

      final inspection = InspectionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        companyName: companyName,
        equipmentType: equipmentType,
        location: location,
        scheduledDate: scheduledDate!.toIso8601String(),
        notes: notes,
        status: 'Pending',
      );

      await DatabaseHelper.instance.createInspection(inspection);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 1500),
            content: Text('Pesanan berhasil diajukan!'),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesan Riksa Uji')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16,
          top: 16,
          right: 16,
          bottom: 100,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lengkapi Data Pemeriksaan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nama Perusahaan',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Wajib diisi' : null,
                onChanged: (val) => companyName = val,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                initialValue: equipmentType,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Jenis Alat',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.engineering),
                ),
                items: equipmentTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: (val) => setState(() => equipmentType = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Lokasi Inspeksi',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Wajib diisi' : null,
                onChanged: (val) => location = val,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Inspeksi',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    scheduledDate == null
                        ? 'Pilih Tanggal'
                        : '${scheduledDate!.day}/${scheduledDate!.month}/${scheduledDate!.year}',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Catatan Tambahan (Opsional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
                onChanged: (val) => notes = val,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitOrder,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Ajukan Pesanan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
