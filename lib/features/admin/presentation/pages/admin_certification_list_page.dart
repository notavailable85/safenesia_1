import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/certification/models/certification_model.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_certification_form_page.dart';

class AdminCertificationListPage extends StatefulWidget {
  const AdminCertificationListPage({super.key});

  @override
  State<AdminCertificationListPage> createState() =>
      _AdminCertificationListPageState();
}

class _AdminCertificationListPageState
    extends State<AdminCertificationListPage> {
  List<CertModel> certifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshCertifications();
  }

  Future refreshCertifications() async {
    setState(() => isLoading = true);
    certifications = await DatabaseHelper.instance.readAllCertifications();
    setState(() => isLoading = false);
  }

  Future deleteCertification(String id) async {
    await DatabaseHelper.instance.deleteCertification(id);
    refreshCertifications();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('Certification deleted'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Certifications'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : certifications.isEmpty
          ? const Center(child: Text('No Certifications found'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: certifications.length,
              itemBuilder: (context, index) {
                final cert = certifications[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.workspace_premium,
                      color: Colors.purple,
                    ),
                    title: Text(cert.title),
                    subtitle: Text('${cert.category} - ${cert.level}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminCertificationFormPage(
                                      certification: cert,
                                    ),
                              ),
                            );
                            refreshCertifications();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Certification'),
                                content: const Text(
                                  'Are you sure you want to delete this certification?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      deleteCertification(cert.id);
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
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
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminCertificationFormPage(),
            ),
          );
          refreshCertifications();
        },
      ),
    );
  }
}
