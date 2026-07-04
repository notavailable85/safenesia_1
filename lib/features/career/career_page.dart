import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/career/models/career_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';

// ==========================================
// 4. ARTIKEL, REGULASI, & KARIR PAGES
// ==========================================
class KarirPage extends StatefulWidget {
  const KarirPage({super.key});
  @override
  State<KarirPage> createState() => _KarirPageState();
}

class _KarirPageState extends State<KarirPage> {
  late Future<List<CareerModel>> _careersFuture;

  @override
  void initState() {
    super.initState();
    _refreshCareers();
  }

  void _refreshCareers() {
    setState(() {
      _careersFuture = DatabaseHelper.instance.readAllCareers();
    });
  }

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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: -8,
                  vertical: 6,
                ),
                indicator: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                labelColor: Theme.of(context).colorScheme.onSurface,
                unselectedLabelColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                labelStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(text: 'Daftar Lowongan'),
                  Tab(text: 'Tersimpan'),
                ],
              ),
            ),
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
                        icon: Icon(Icons.tune, color: Theme.of(context).colorScheme.primary),
                        onPressed: () => _showFilter(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<CareerModel>>(
                    future: _careersFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('Tidak ada lowongan.'));
                      }
                      
                      final careers = snapshot.data!;
                      return ListView.builder(
                        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 100),
                        itemCount: careers.length,
                        itemBuilder: (c, i) => _buildJobCard(careers[i]),
                      );
                    },
                  ),
                ),
              ],
            ),
            FutureBuilder<List<CareerModel>>(
              future: _careersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada lowongan tersimpan.'));
                }
                
                final savedCareers = snapshot.data!.where((c) => c.isSaved == 1).toList();
                
                if (savedCareers.isEmpty) {
                  return const Center(child: Text('Tidak ada lowongan tersimpan.'));
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 100),
                  itemCount: savedCareers.length,
                  itemBuilder: (c, i) => _buildJobCard(savedCareers[i]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(CareerModel career) {
    bool isSaved = career.isSaved == 1;
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
                  Text(
                    career.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Bidang: ${career.field} | ${career.company}',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        career.location,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'Rp ${career.salaryMin ~/ 1000000} Jt - Rp ${career.salaryMax ~/ 1000000} Jt',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () async {
                final updatedCareer = CareerModel(
                  id: career.id,
                  title: career.title,
                  company: career.company,
                  field: career.field,
                  location: career.location,
                  salaryMin: career.salaryMin,
                  salaryMax: career.salaryMax,
                  isSaved: isSaved ? 0 : 1,
                );
                await DatabaseHelper.instance.updateCareer(updatedCareer);
                _refreshCareers();
              },
            ),
          ],
        ),
      ),
    );
  }
}
