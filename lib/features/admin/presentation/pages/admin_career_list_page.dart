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
        const SnackBar(content: Text('Career deleted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Careers'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : careers.isEmpty
              ? const Center(child: Text('No Careers found'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: careers.length,
                  itemBuilder: (context, index) {
                    final career = careers[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.work, color: Colors.brown),
                        title: Text(career.title),
                        subtitle: Text('${career.company} - ${career.location}'),
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
                                    title: const Text('Delete Career'),
                                    content: const Text('Are you sure you want to delete this career?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          deleteCareer(career.id);
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
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add, color: Colors.white),
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
