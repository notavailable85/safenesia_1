import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/training/models/training_model.dart';
import 'package:safenesia_1/features/training/presentation/pages/admin/admin_training_form_page.dart';
import 'package:safenesia_1/features/training/presentation/pages/admin/admin_schedule_list_page.dart';

class AdminTrainingListPage extends StatefulWidget {
  const AdminTrainingListPage({super.key});

  @override
  State<AdminTrainingListPage> createState() => _AdminTrainingListPageState();
}

class _AdminTrainingListPageState extends State<AdminTrainingListPage> {
  List<Training> _trainings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshTrainings();
  }

  Future<void> _refreshTrainings() async {
    setState(() => _isLoading = true);
    try {
      final data = await DatabaseHelper.instance.readAllTrainings();
      setState(() {
        _trainings = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
      }
    }
  }

  Future<void> _deleteTraining(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Pelatihan'),
        content: const Text('Apakah Anda yakin ingin menghapus jadwal pelatihan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Hapus', style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseHelper.instance.deleteTraining(id);
      _refreshTrainings();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jadwal pelatihan berhasil dihapus')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Data Pelatihan'),

        actions: [
          IconButton(
            icon: const Icon(Icons.event_note),
            tooltip: 'Kelola Jadwal Pelatihan',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminScheduleListPage(),
                ),
              );
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _trainings.isEmpty
              ? const Center(child: Text('Belum ada jadwal pelatihan.'))
              : ListView.builder(
                  itemCount: _trainings.length,
                  itemBuilder: (context, index) {
                    final training = _trainings[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(
                          training.namaPelatihan,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${training.bidang} • Rp ${training.hargaPromo}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminTrainingFormPage(training: training),
                                  ),
                                );
                                _refreshTrainings();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                              onPressed: () => _deleteTraining(training.idPelatihan),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminTrainingFormPage(),
            ),
          );
          _refreshTrainings();
        },
      ),
    );
  }
}
