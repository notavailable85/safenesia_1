import 'package:flutter/material.dart';
import 'package:safenesia_1/features/certification/presentation/pages/certification_detail_page.dart';
import 'package:safenesia_1/features/certification/presentation/pages/certification_model.dart';

// ==========================================
// 1. HALAMAN DAFTAR SERTIFIKASI
// ==========================================
class CertListPage extends StatefulWidget {
  const CertListPage({super.key});

  @override
  State<CertListPage> createState() => _CertListPageState();
}

class _CertListPageState extends State<CertListPage> {
  String _selectedCategory = 'SMK3';

  @override
  Widget build(BuildContext context) {
    // Filter data berdasarkan kategori yang dipilih
    final filteredList = dummyCertifications
        .where((cert) => cert.category == _selectedCategory)
        .toList();

    // Scaffold dipakai di setiap halaman
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Sertifikasi'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Filter Kategori di Body Atas
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            color: Colors.white,
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'SMK3', label: Text('Sertifikasi SMK3')),
                ButtonSegment(value: 'ISO', label: Text('Sertifikasi ISO')),
              ],
              selected: {_selectedCategory},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _selectedCategory = newSelection.first;
                });
              },
            ),
          ),
          const Divider(height: 1),
          // Daftar Sertifikasi (Cards)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final cert = filteredList[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cert.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Chip(
                              label: Text(
                                cert.category,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: cert.category == 'SMK3'
                                  ? Colors.blue.shade100
                                  : Colors.orange.shade100,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                cert.level,
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rp ${cert.basePrice}',
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
                                        CertDetailPage(certData: cert),
                                  ),
                                );
                              },
                              child: const Text('Detail'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
