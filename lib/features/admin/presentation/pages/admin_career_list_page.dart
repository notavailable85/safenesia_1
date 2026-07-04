import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/career/models/career_model.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_career_form_page.dart';

class AdminCareerListPage extends StatefulWidget {
  const AdminCareerListPage({super.key});

  @override
  State<AdminCareerListPage> createState() => _AdminCareerListPageState();
}

class _AdminCareerListPageState extends State<AdminCareerListPage> {
  List<CareerModel> careers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshCareers();
  }

  Future refreshCareers() async {
    setState(() => isLoading = true);
    careers = await DatabaseHelper.instance.readAllCareers();
    setState(() => isLoading = false);
  }

  Future deleteCareer(String id) async {
    await DatabaseHelper.instance.deleteCareer(id);
    refreshCareers();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lowongan berhasil dihapus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Karir K3'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : careers.isEmpty
              ? const Center(child: Text('Belum ada data karir'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: careers.length,
                  itemBuilder: (context, index) {
                    final career = careers[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          child: Icon(Icons.work, color: Theme.of(context).colorScheme.primary),
                        ),
                        title: Text(career.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${career.company} - ${career.location}'),
                            Text(
                              '${career.jobType} • ${career.experienceLevel}',
                              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminCareerFormPage(career: career),
                                  ),
                                );
                                refreshCareers();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Hapus Lowongan'),
                                    content: const Text('Apakah Anda yakin ingin menghapus lowongan ini?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          deleteCareer(career.id);
                                        },
                                        child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminCareerFormPage(),
            ),
          );
          refreshCareers();
        },
      ),
    );
  }
}

