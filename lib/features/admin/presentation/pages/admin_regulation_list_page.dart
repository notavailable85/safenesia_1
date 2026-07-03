import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/regulation/models/regulation_model.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_regulation_form_page.dart';

class AdminRegulationListPage extends StatefulWidget {
  const AdminRegulationListPage({super.key});

  @override
  State<AdminRegulationListPage> createState() => _AdminRegulationListPageState();
}

class _AdminRegulationListPageState extends State<AdminRegulationListPage> {
  List<RegulationModel> regulations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshRegulations();
  }

  Future refreshRegulations() async {
    setState(() => isLoading = true);
    regulations = await DatabaseHelper.instance.readAllRegulations();
    setState(() => isLoading = false);
  }

  Future deleteRegulation(String id) async {
    await DatabaseHelper.instance.deleteRegulation(id);
    refreshRegulations();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Regulation deleted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Regulations'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : regulations.isEmpty
              ? const Center(child: Text('No Regulations found'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: regulations.length,
                  itemBuilder: (context, index) {
                    final regulation = regulations[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.gavel, color: Colors.teal),
                        title: Text(regulation.title),
                        subtitle: Text(regulation.category),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminRegulationFormPage(regulation: regulation),
                                  ),
                                );
                                refreshRegulations();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Regulation'),
                                    content: const Text('Are you sure you want to delete this regulation?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          deleteRegulation(regulation.id);
                                        },
                                        child: const Text('Delete', style: TextStyle(color: Colors.red)),
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
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminRegulationFormPage(),
            ),
          );
          refreshRegulations();
        },
      ),
    );
  }
}
