import 'package:flutter/material.dart';

// ==========================================
// 4. ARTIKEL, REGULASI, & KARIR PAGES
// ==========================================
class RegulasiPage extends StatelessWidget {
  const RegulasiPage({super.key});
  @override
  Widget build(BuildContext context) {
    final categories = [
      'Undang-undang',
      'Peraturan Presiden',
      'Peraturan Pemerintah',
      'Peraturan Menteri',
      'Keputusan Menteri',
      'Instruksi Menteri',
      'Keputusan Dirjen',
      'Surat Edaran Menteri',
      'Keputusan Bersama Menteri',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Regulasi K3')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, i) => ExpansionTile(
          title: Text(
            categories[i],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text('File PDF ${categories[i]} No.1'),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Menampilkan PDF...')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
