import 'dart:math';
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
  List<TrainingSchedule> _schedules = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshSchedules();
  }

  Future<void> _refreshSchedules() async {
    setState(() => _isLoading = true);
    try {
      final data = await DatabaseHelper.instance.readAllSchedulesWithTraining();
      setState(() {
        _schedules = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text('Terjadi kesalahan: $e'),
          ),
        );
      }
    }
  }

  Future<void> _generateDummyData() async {
    setState(() => _isLoading = true);
    try {
      final trainings = await DatabaseHelper.instance.readAllTrainings();
      if (trainings.isEmpty) {
        throw Exception(
          'Tidak ada data pelatihan. Harap tambah data pelatihan terlebih dahulu.',
        );
      }

      final random = Random();
      final randomTraining = trainings[random.nextInt(trainings.length)];
      final trainingId = randomTraining.idPelatihan;

      final now = DateTime.now();

      // Generate untuk 4 bulan (Bulan ini, dan 3 bulan ke depan)
      for (int i = 0; i < 4; i++) {
        final targetMonth = now.month + i;
        final targetYear =
            now.year + (targetMonth > 12 ? (targetMonth - 1) ~/ 12 : 0);
        final actualMonth = targetMonth > 12
            ? (targetMonth - 1) % 12 + 1
            : targetMonth;

        // Pilih tanggal acak antara tanggal 1 sampai 20
        final startDay = random.nextInt(20) + 1;
        final startDate = DateTime(targetYear, actualMonth, startDay);
        final durationDays = 2 + random.nextInt(4); // durasi 2 sampai 5 hari
        final endDate = startDate.add(Duration(days: durationDays));

        final dummyId =
            'dummy_schedule_${now.millisecondsSinceEpoch}_${random.nextInt(1000)}';

        final dummySchedule = TrainingSchedule(
          idJadwal: dummyId,
          idPelatihan: trainingId,
          tanggalStart: startDate.toIso8601String(),
          tanggalEnd: endDate.toIso8601String(),
          gambar: '',
        );

        await DatabaseHelper.instance.createSchedule(dummySchedule);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text(
              '4 Data dummy jadwal (berurutan 4 bulan) berhasil ditambahkan',
            ),
          ),
        );
      }
      _refreshSchedules();
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text('Gagal menambah data dummy: $e'),
          ),
        );
      }
    }
  }

  Future<void> _deleteSchedule(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Jadwal'),
        content: const Text('Apakah Anda yakin ingin menghapus jadwal ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Hapus',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseHelper.instance.deleteSchedule(id);
      _refreshSchedules();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text('Jadwal berhasil dihapus'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Jadwal Pelatihan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_to_photos),
            tooltip: 'Generate Dummy Data',
            onPressed: _generateDummyData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _schedules.isEmpty
          ? const Center(
              child: Text('Belum ada jadwal pelatihan yang dipublikasikan.'),
            )
          : ListView.builder(
              itemCount: _schedules.length,
              itemBuilder: (context, index) {
                final schedule = _schedules[index];
                final trainingName =
                    schedule.trainingData?.namaPelatihan ??
                    'Pelatihan Tidak Diketahui';

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      trainingName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Pelaksanaan: ${schedule.tanggalStr}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminScheduleFormPage(schedule: schedule),
                              ),
                            );
                            _refreshSchedules();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          onPressed: () => _deleteSchedule(schedule.idJadwal),
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
              builder: (context) => const AdminScheduleFormPage(),
            ),
          );
          _refreshSchedules();
        },
      ),
    );
  }
}
