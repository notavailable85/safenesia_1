import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/career/models/career_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/career/presentation/pages/career_detail_page.dart';

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
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Kota / Lokasi')),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Tipe Pekerjaan (Full-time, dll)'),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Tingkat Pengalaman (Entry, Senior)'),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Gaji Min (Juta)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Gaji Max (Juta)'),
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
                child: const Text('Terapkan Filter'),
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
      length: 3,
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
                labelPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                  Tab(text: 'Telah Dilamar'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // TAB 1: DAFTAR LOWONGAN
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari posisi, perusahaan...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.tune, color: Theme.of(context).colorScheme.primary),
                          onPressed: () => _showFilter(context),
                        ),
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
                        padding: const EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 100),
                        itemCount: careers.length,
                        itemBuilder: (c, i) => _buildJobCard(careers[i]),
                      );
                    },
                  ),
                ),
              ],
            ),
            
            // TAB 2: TERSIMPAN
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
                  return const Center(child: Text('Belum ada lowongan yang disimpan.'));
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 100),
                  itemCount: savedCareers.length,
                  itemBuilder: (c, i) => _buildJobCard(savedCareers[i]),
                );
              },
            ),

            // TAB 3: TELAH DILAMAR
            FutureBuilder<List<CareerModel>>(
              future: _careersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada riwayat lamaran.'));
                }
                
                final appliedCareers = snapshot.data!.where((c) => c.isApplied == 1).toList();
                
                if (appliedCareers.isEmpty) {
                  return const Center(
                    child: Text('Anda belum melamar pekerjaan apa pun.\nCari dan lamar sekarang!'),
                  );
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 100),
                  itemCount: appliedCareers.length,
                  itemBuilder: (c, i) => _buildJobCard(appliedCareers[i], isAppliedTab: true),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(CareerModel career, {bool isAppliedTab = false}) {
    bool isSaved = career.isSaved == 1;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CareerDetailPage(career: career),
            ),
          );
          if (result == true) {
            _refreshCareers();
          } else {
            // Also refresh in case save status changed
            _refreshCareers();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row (Logo, Title, Company, Bookmark)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: career.companyLogoUrl.isNotEmpty 
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(career.companyLogoUrl, fit: BoxFit.cover, errorBuilder: (c,e,s) => const Icon(Icons.business, color: Colors.grey)),
                        )
                      : const Icon(Icons.business, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          career.title,
                          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          career.company,
                          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (!isAppliedTab)
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: isSaved ? primaryColor : Colors.grey,
                      ),
                      onPressed: () async {
                        final updatedCareer = CareerModel(
                          id: career.id,
                          title: career.title,
                          company: career.company,
                          field: career.field,
                          location: career.location,
                          jobType: career.jobType,
                          experienceLevel: career.experienceLevel,
                          salaryMin: career.salaryMin,
                          salaryMax: career.salaryMax,
                          description: career.description,
                          requirements: career.requirements,
                          benefits: career.benefits,
                          postedDate: career.postedDate,
                          companyLogoUrl: career.companyLogoUrl,
                          isSaved: isSaved ? 0 : 1,
                          isApplied: career.isApplied,
                        );
                        await DatabaseHelper.instance.updateCareer(updatedCareer);
                        _refreshCareers();
                      },
                    ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Location & Salary
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      career.location,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.monetization_on, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Rp ${career.salaryMin ~/ 1000000} Jt - Rp ${career.salaryMax ~/ 1000000} Jt',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Badges & Date
              Row(
                children: [
                  _buildMiniBadge(career.jobType),
                  const SizedBox(width: 8),
                  _buildMiniBadge(career.experienceLevel),
                  const Spacer(),
                  if (isAppliedTab)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Status: Menunggu',
                        style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    )
                  else
                    Text(
                      'Beberapa hari lalu', // Ideally parse postedDate
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

