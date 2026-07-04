import 'package:flutter/material.dart';

// ==========================================
// 2. SEARCH & NOTIFICATION PAGE
// ==========================================
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> history = ['K3 Umum', 'ISO 9001', 'Perpanjangan Lisensi'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Cari layanan, artikel...',
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.white54, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.white54, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.white, width: 1.5),
            ),
            filled: true,
            fillColor: Colors.white12,
            hintStyle: const TextStyle(color: Colors.white70),
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.white70,
              size: 20,
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pencarian Terakhir',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => setState(() => history.clear()),
                  child: const Text(
                    'Hapus Semua',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            ...history.map(
              (h) => ListTile(
                leading: const Icon(Icons.history),
                title: Text(h),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Pencarian Populer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children:
                  ['Ahli K3', 'Riksa Uji Lift', 'Auditor SMK3', 'First Aid']
                      .map(
                        (p) => Chip(
                          label: Text(p),
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          side: BorderSide.none,
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
