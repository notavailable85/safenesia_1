import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/profile/models/document_model.dart';

// ==========================================
// 1.C. DOKUMEN SAYA
// ==========================================
class MyDocumentsPage extends StatefulWidget {
  const MyDocumentsPage({super.key});
  @override
  State<MyDocumentsPage> createState() => _MyDocumentsPageState();
}

class _MyDocumentsPageState extends State<MyDocumentsPage> {
  List<DocumentModel> uploadedDocs = [];
  bool isLoading = true;

  final List<String> docTypes = [
    'KTP',
    'Ijazah',
    'Pasfoto',
    'CV',
    'Surat Keterangan Sehat',
    'Surat Keterangan Kerja',
    'Pakta Integritas',
  ];

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  Future<void> _loadDocuments() async {
    final docs = await DatabaseHelper.instance.readAllDocuments();
    if (mounted) {
      setState(() {
        uploadedDocs = docs;
        isLoading = false;
      });
    }
  }

  Future<void> _openDocument(String path) async {
    final result = await OpenFile.open(path);
    if (result.type != ResultType.done && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tidak dapat membuka file: ${result.message}')),
      );
    }
  }

  Future<void> _deleteDocument(String id, String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
      await DatabaseHelper.instance.deleteDocument(id);
      _loadDocuments();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dokumen berhasil dihapus')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus dokumen: $e')),
        );
      }
    }
  }

  void _showUploadDialog() {
    String? selectedType = docTypes.first;
    File? selectedFile;
    bool isUploading = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setStateDialog) {

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('Upload Dokumen Baru'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Jenis Dokumen',
                    border: OutlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedType,
                      items: docTypes
                          .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                          .toList(),
                      onChanged: (val) => setStateDialog(() => selectedType = val),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: isUploading
                      ? null
                      : () async {
                          try {
                            final result = await FilePicker.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
                            );
                            if (result != null && result.files.single.path != null) {
                              setStateDialog(() {
                                selectedFile = File(result.files.single.path!);
                              });
                            }
                          } catch (e) {
                            if (dialogContext.mounted) {
                              ScaffoldMessenger.of(dialogContext).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Gagal membuka file picker: $e\n(Jika ini MissingPluginException, mohon STOP dan RUN ulang aplikasi dari awal)',
                                  ),
                                  duration: const Duration(seconds: 5),
                                ),
                              );
                            }
                          }
                        },
                  icon: const Icon(Icons.folder_open),
                  label: const Text('Pilih File dari Perangkat'),
                ),
                if (selectedFile != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Terpilih: ${p.basename(selectedFile!.path)}',
                      style: const TextStyle(fontSize: 12, color: Colors.green),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: isUploading ? null : () => Navigator.pop(dialogContext),
                child: const Text('Batal', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                onPressed: (isUploading || selectedFile == null || selectedType == null)
                    ? null
                    : () async {
                        setStateDialog(() => isUploading = true);
                        try {
                          final appDir = await getApplicationDocumentsDirectory();
                          final fileName = p.basename(selectedFile!.path);
                          final savedFile = await selectedFile!.copy('${appDir.path}/$fileName');

                          final newDoc = DocumentModel(
                            id: 'doc_${DateTime.now().millisecondsSinceEpoch}',
                            jenis: selectedType!,
                            namaFile: fileName,
                            pathFile: savedFile.path,
                            tanggalUpload: DateFormat('dd MMM yyyy').format(DateTime.now()),
                          );

                          await DatabaseHelper.instance.createDocument(newDoc);
                          
                          if (dialogContext.mounted) {
                            Navigator.pop(dialogContext);
                          }
                          if (mounted) {
                            _loadDocuments();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Dokumen berhasil disimpan'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        } catch (e) {
                          setStateDialog(() => isUploading = false);
                          if (dialogContext.mounted) {
                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              SnackBar(content: Text('Terjadi kesalahan: $e')),
                            );
                          }
                        }
                      },
                child: isUploading
                    ? const SizedBox(
                        width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Simpan'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Dokumen Saya')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : uploadedDocs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder_off_outlined, size: 80, color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                      const SizedBox(height: 16),
                      Text('Belum ada dokumen yang diupload.', style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: uploadedDocs.length,
                  itemBuilder: (context, i) {
                    final doc = uploadedDocs[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        onTap: () => _openDocument(doc.pathFile),
                        leading: CircleAvatar(
                          backgroundColor: theme.colorScheme.primaryContainer,
                          child: Icon(Icons.file_present, color: theme.colorScheme.onPrimaryContainer),
                        ),
                        title: Text(doc.jenis, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(doc.namaFile, maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text('Diunggah: ${doc.tanggalUpload}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Hapus Dokumen'),
                                content: Text('Apakah Anda yakin ingin menghapus ${doc.jenis}?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _deleteDocument(doc.id, doc.pathFile);
                                    },
                                    child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showUploadDialog,
        icon: const Icon(Icons.add),
        label: const Text('Upload Dokumen'),
      ),
    );
  }
}
