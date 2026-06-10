import 'package:flutter/material.dart';
import 'package:safenesia_1/features/training/presentation/pages/training_detail_page.dart';

// ==========================================
// 1. HALAMAN DAFTAR PELATHAN (TABS & CARD)
// ==========================================
class TrainingListPage extends StatelessWidget {
  const TrainingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Kuartal/Per 3 Bulan dalam setahun
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Pelatihan K3'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Jan - Mar'),
              Tab(text: 'Apr - Jun'),
              Tab(text: 'Jul - Sep'),
              Tab(text: 'Okt - Des'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTrainingList(context, 'Kuartal 1'),
            _buildTrainingList(context, 'Kuartal 2'),
            _buildTrainingList(context, 'Kuartal 3'),
            _buildTrainingList(context, 'Kuartal 4'),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainingList(BuildContext context, String kuartal) {
    // Data Dummy Pelatihan
    final dummyTrainings = [
      {
        'judul': 'Ahli K3 Umum',
        'sertifikasi': 'Sertifikasi Kemnaker RI',
        'tanggal': '12 Jul - 24 Jul 2026',
        'harga': 5500000,
      },
      {
        'judul': 'Petugas Pemadam Kebakaran Kelas D',
        'sertifikasi': 'Sertifikasi Kemnaker RI',
        'tanggal': '18 Agst - 21 Agst 2026',
        'harga': 3500000,
      },
      {
        'judul': 'K3 Bekerja di Ketinggian',
        'sertifikasi': 'Sertifikasi Kemnaker RI',
        'tanggal': '05 Sep - 08 Sep 2026',
        'harga': 4000000,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: dummyTrainings.length,
      itemBuilder: (context, index) {
        final item = dummyTrainings[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['judul'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Chip(
                  label: Text(item['sertifikasi'] as String),
                  backgroundColor: Colors.blue.shade50,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(item['tanggal'] as String),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp ${item['harga']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TrainingDetailPage(trainingData: item),
                          ),
                        );
                      },
                      child: const Text('Detail & Daftar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
