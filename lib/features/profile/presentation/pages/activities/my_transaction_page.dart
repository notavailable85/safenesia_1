import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/profile/models/transaction_model.dart';

// ==========================================
// SUB-HALAMAN KONTAINER 1
// ==========================================

// 1.A. HISTORY TRANSAKSI
class HistoryTransactionPage extends StatefulWidget {
  const HistoryTransactionPage({super.key});
  @override
  State<HistoryTransactionPage> createState() => _HistoryTransactionPageState();
}

class _HistoryTransactionPageState extends State<HistoryTransactionPage> {
  String selectedFilter = 'Semua';
  final List<String> filters = [
    'Semua',
    'Pelatihan',
    'Sertifikasi',
    'Riksa Uji',
    'Perpanjangan',
  ];

  List<TransactionModel> allData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final data = await DatabaseHelper.instance.readAllTransactions();
    setState(() {
      allData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var filteredData = selectedFilter == 'Semua'
        ? allData
        : allData.where((e) => e.layanan == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('History Transaksi')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: filters
                  .map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(f),
                        selected: selectedFilter == f,
                        onSelected: (val) => setState(() => selectedFilter = f),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredData.isEmpty
                ? const Center(child: Text('Belum ada transaksi.'))
                : ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, i) => Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text(filteredData[i].judul),
                        subtitle: Text(
                          "${filteredData[i].layanan} | ${filteredData[i].tanggal}",
                        ),
                        trailing: Chip(
                          label: Text(filteredData[i].status),
                          backgroundColor: filteredData[i].status == 'Selesai'
                              ? Colors.green.withValues(alpha: 0.2)
                              : Colors.orange.withValues(alpha: 0.2),
                          side: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
