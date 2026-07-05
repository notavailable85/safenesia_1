import 'package:flutter/material.dart';

// ==========================================
// SUB-HALAMAN KONTAINER 1
// ==========================================

// 1.C. DOKUMEN SAYA
class MyDocumentsPage extends StatefulWidget {
  const MyDocumentsPage({super.key});
  @override
  State<MyDocumentsPage> createState() => _MyDocumentsPageState();
}

class _MyDocumentsPageState extends State<MyDocumentsPage> {
  List<Map<String, String>> uploadedDocs = [];
  final List<String> docTypes = [
    'KTP',
    'Ijazah',
    'Pasfoto',
    'CV',
    'Surat Keterangan Sehat',
    'Surat Keterangan Kerja',
    'Pakta Intgritas',
  ];
  String? selectedType;

  void _showUploadDialog() {
    selectedType = docTypes.first;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: const Text('Upload Dokumen Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(initialValue: selectedType,
                items: docTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setStateDialog(() => selectedType = val),
                decoration: const InputDecoration(labelText: 'Jenis Dokumen'),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.file_upload),
                label: const Text('Pilih File dari HP'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(
                  () => uploadedDocs.add({
                    'jenis': selectedType!,
                    'nama_file': 'file_terupload.pdf',
                  }),
                );
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dokumen Saya')),
      body: uploadedDocs.isEmpty
          ? const Center(child: Text('Belum ada dokumen yang diupload.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: uploadedDocs.length,
              itemBuilder: (context, i) => Card(
                child: ListTile(
                  leading: const Icon(Icons.file_present, color: Colors.blue),
                  title: Text(uploadedDocs[i]['jenis']!),
                  subtitle: Text(uploadedDocs[i]['nama_file']!),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showUploadDialog,
        icon: const Icon(Icons.add),
        label: const Text('Upload Dokumen'),
      ),
    );
  }
}
