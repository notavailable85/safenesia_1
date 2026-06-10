import 'package:flutter/material.dart';

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
  final List<Map<String, String>> allData = [
    {
      'layanan': 'Pelatihan',
      'judul': 'Ahli K3 Umum',
      'status': 'Selesai',
      'tanggal': '12 Jan 2026',
    },
    {
      'layanan': 'Sertifikasi',
      'judul': 'ISO 9001:2015',
      'status': 'Proses',
      'tanggal': '05 Feb 2026',
    },
    {
      'layanan': 'Riksa Uji',
      'judul': 'Riksa Uji Crane',
      'status': 'Selesai',
      'tanggal': '20 Mar 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    var filteredData = selectedFilter == 'Semua'
        ? allData
        : allData.where((e) => e['layanan'] == selectedFilter).toList();

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
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, i) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(filteredData[i]['judul']!),
                  subtitle: Text(
                    "${filteredData[i]['layanan']} | ${filteredData[i]['tanggal']}",
                  ),
                  trailing: Chip(label: Text(filteredData[i]['status']!)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
