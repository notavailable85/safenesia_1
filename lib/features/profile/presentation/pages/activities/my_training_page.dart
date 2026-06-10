import 'package:flutter/material.dart';

// ==========================================
// SUB-HALAMAN KONTAINER 1
// ==========================================

// 1.B. PELATIHAN SAYA
class MyTrainingPage extends StatelessWidget {
  const MyTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pelatihan Saya'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Kemnaker'),
              Tab(text: 'BNSP'),
              Tab(text: 'Awareness'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(['Ahli K3 Umum (Kemnaker)', 'Petugas P3K']),
            _buildList(['Auditor SMK3 (BNSP)']),
            _buildList(['Dasar-dasar K3 (Awareness)', 'Ergonomi Perkantoran']),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<String> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, i) => Card(
        child: ListTile(
          leading: const Icon(Icons.school, color: Colors.blue),
          title: Text(items[i]),
          trailing: const Text(
            'Selesai',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
