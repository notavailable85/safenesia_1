import 'package:flutter/material.dart';
import 'package:safenesia_1/features/inspection/models/inspection_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';

class AdminInspectionListPage extends StatefulWidget {
  const AdminInspectionListPage({super.key});

  @override
  State<AdminInspectionListPage> createState() => _AdminInspectionListPageState();
}

class _AdminInspectionListPageState extends State<AdminInspectionListPage> {
  List<InspectionModel> _inspections = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await DatabaseHelper.instance.readAllInspections();
    setState(() {
      _inspections = data;
      _isLoading = false;
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'On Progress':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showStatusDialog(InspectionModel ins) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['Pending', 'On Progress', 'Completed', 'Rejected']
                .map(
                  (status) => ListTile(
                    title: Text(status),
                    trailing: ins.status == status
                        ? const Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () async {
                      final updated = InspectionModel(
                        id: ins.id,
                        companyName: ins.companyName,
                        equipmentType: ins.equipmentType,
                        location: ins.location,
                        scheduledDate: ins.scheduledDate,
                        notes: ins.notes,
                        status: status,
                      );
                      await DatabaseHelper.instance.updateInspection(updated);
                      if (!dialogContext.mounted) return;
                      Navigator.pop(dialogContext);
                      _loadData();
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  void _deleteInspection(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Pesanan?'),
        content: const Text('Pesanan ini akan dihapus permanen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseHelper.instance.deleteInspection(id);
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Riksa Uji'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _inspections.isEmpty
              ? const Center(child: Text('Belum ada pesanan.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _inspections.length,
                  itemBuilder: (context, index) {
                    final ins = _inspections[index];
                    final date = DateTime.tryParse(ins.scheduledDate);
                    final dateStr = date != null ? '${date.day}/${date.month}/${date.year}' : ins.scheduledDate;

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ins.companyName,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                InkWell(
                                  onTap: () => _showStatusDialog(ins),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(ins.status),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          ins.status,
                                          style: const TextStyle(color: Colors.white, fontSize: 12),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(Icons.edit, size: 14, color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Text('Alat: ${ins.equipmentType}'),
                            Text('Lokasi: ${ins.location}'),
                            Text('Tanggal: $dateStr'),
                            if (ins.notes.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text('Catatan: ${ins.notes}', style: const TextStyle(fontStyle: FontStyle.italic)),
                            ],
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteInspection(ins.id),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
