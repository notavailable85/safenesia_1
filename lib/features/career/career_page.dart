import 'package:flutter/material.dart';

// ==========================================
// 4. ARTIKEL, REGULASI, & KARIR PAGES
// ==========================================
class KarirPage extends StatefulWidget {
  const KarirPage({super.key});
  @override
  State<KarirPage> createState() => _KarirPageState();
}

class _KarirPageState extends State<KarirPage> {
  void _showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 24,
          left: 24,
          right: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Filter Lowongan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const TextField(decoration: InputDecoration(labelText: 'Kota')),
            const TextField(
              decoration: InputDecoration(labelText: 'Bidang Spesialis'),
            ),
            Row(
              children: const [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Gaji Min'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Gaji Max'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Terapkan'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Karir K3'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Daftar Lowongan'),
              Tab(text: 'Tersimpan'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari posisi...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.tune, color: Colors.blue),
                        onPressed: () => _showFilter(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 4,
                    itemBuilder: (c, i) => _buildJobCard(false),
                  ),
                ),
              ],
            ),
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 2,
              itemBuilder: (c, i) => _buildJobCard(true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(bool isSaved) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              color: Colors.grey.shade200,
              child: const Icon(Icons.business),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'HSE Officer',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Text(
                    'Bidang: Manufaktur | PT Maju Jaya',
                    style: TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.location_on, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        'Jakarta',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.monetization_on, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        'Rp 8 Jt - Rp 12 Jt',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
