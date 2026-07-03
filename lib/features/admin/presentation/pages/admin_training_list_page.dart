import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/training/models/training_model.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_training_form_page.dart';

class AdminTrainingListPage extends StatefulWidget {
  const AdminTrainingListPage({super.key});

  @override
  State<AdminTrainingListPage> createState() => _AdminTrainingListPageState();
}

class _AdminTrainingListPageState extends State<AdminTrainingListPage> {
  List<Training> trainings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshTrainings();
  }

  Future refreshTrainings() async {
    setState(() => isLoading = true);
    trainings = await DatabaseHelper.instance.readAllTrainings();
    setState(() => isLoading = false);
  }

  Future deleteTraining(String id) async {
    await DatabaseHelper.instance.deleteTraining(id);
    refreshTrainings();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Training deleted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Trainings'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : trainings.isEmpty
              ? const Center(child: Text('No Trainings found'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: trainings.length,
                  itemBuilder: (context, index) {
                    final training = trainings[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.school, color: Colors.green),
                        title: Text(training.namaPelatihan),
                        subtitle: Text(training.bidang),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminTrainingFormPage(training: training),
                                  ),
                                );
                                refreshTrainings();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Training'),
                                    content: const Text('Are you sure you want to delete this training? This will also delete related schedules.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          deleteTraining(training.idPelatihan);
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
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminTrainingFormPage(),
            ),
          );
          refreshTrainings();
        },
      ),
    );
  }
}
