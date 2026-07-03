import 'package:flutter/material.dart';
import 'package:safenesia_1/features/regulation/models/regulation_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';

// ==========================================
// 4. ARTIKEL, REGULASI, & KARIR PAGES
// ==========================================
class RegulasiPage extends StatefulWidget {
  const RegulasiPage({super.key});

  @override
  State<RegulasiPage> createState() => _RegulasiPageState();
}

class _RegulasiPageState extends State<RegulasiPage> {
  late Future<List<RegulationModel>> _regulationsFuture;

  @override
  void initState() {
    super.initState();
    _regulationsFuture = DatabaseHelper.instance.readAllRegulations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regulasi K3')),
      body: FutureBuilder<List<RegulationModel>>(
        future: _regulationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada regulasi.'));
          }

          final regulations = snapshot.data!;
          
          // Group by category
          final Map<String, List<RegulationModel>> grouped = {};
          for (var reg in regulations) {
            if (!grouped.containsKey(reg.category)) {
              grouped[reg.category] = [];
            }
            grouped[reg.category]!.add(reg);
          }

          final categories = grouped.keys.toList();

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, i) {
              final category = categories[i];
              final categoryRegulations = grouped[category]!;
              
              return ExpansionTile(
                title: Text(
                  category,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: categoryRegulations.map((reg) => ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: Text(reg.title),
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Menampilkan PDF ${reg.title}...')),
                  ),
                )).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
