import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_schedule_form_page.dart';

class AdminScheduleListPage extends StatefulWidget {
  const AdminScheduleListPage({super.key});

  @override
  State<AdminScheduleListPage> createState() => _AdminScheduleListPageState();
}

class _AdminScheduleListPageState extends State<AdminScheduleListPage> {
  List<TrainingSchedule> schedules = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshSchedules();
  }

  Future refreshSchedules() async {
    setState(() => isLoading = true);
    schedules = await DatabaseHelper.instance.readAllSchedulesWithTraining();
    setState(() => isLoading = false);
  }

  Future deleteSchedule(String id) async {
    await DatabaseHelper.instance.deleteSchedule(id);
    refreshSchedules();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Schedule deleted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Schedules'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : schedules.isEmpty
              ? const Center(child: Text('No Schedules found'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    final schedule = schedules[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.schedule, color: Colors.orange),
                        title: Text(schedule.trainingData?.namaPelatihan ?? 'Unknown Training'),
                        subtitle: Text(schedule.tanggalStr),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminScheduleFormPage(schedule: schedule),
                                  ),
                                );
                                refreshSchedules();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Schedule'),
                                    content: const Text('Are you sure you want to delete this schedule?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          deleteSchedule(schedule.idJadwal);
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminScheduleFormPage(),
            ),
          );
          refreshSchedules();
        },
      ),
    );
  }
}
