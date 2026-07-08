import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safenesia_1/features/career/models/career_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/core/widgets/standard_search_field.dart';
import 'package:safenesia_1/features/career/presentation/pages/career_detail_page.dart';
import 'package:safenesia_1/features/career/presentation/pages/career_search_page.dart';

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
  Set<String> _savedCareerIds = {};
  Set<String> _appliedCareerIds = {};

  @override
  void initState() {
    super.initState();
    _careersFuture = DatabaseHelper.instance.readAllCareers();
    _refreshCareers();
  }

  Future<void> _refreshCareers() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('saved_careers') ?? [];
    final applied = prefs.getStringList('applied_careers') ?? [];

    setState(() {
      _savedCareerIds = saved.toSet();
      _appliedCareerIds = applied.toSet();
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
            const TextField(
              decoration: InputDecoration(labelText: 'Kota / Lokasi'),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Tipe Pekerjaan (Full-time, dll)',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Tingkat Pengalaman (Entry, Senior)',
              ),
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
          title: StandardSearchField(
            hintText: 'Cari posisi, perusahaan...',
            readOnly: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CareerSearchPage(),
                ),
              ).then((_) => _refreshCareers());
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => _showFilter(context),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(58),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 2,
                  thickness: 2,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).scaffoldBackgroundColor, // Background tab bar mengikuti scaffold
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black26
                            : Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(
                          0,
                          2,
                        ), // Efek shadow / border standar
                      ),
                    ],
                  ),
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start, // Geser ke samping kiri
                    dividerColor:
                        Colors.transparent, // Hapus garis abu-abu di bawah
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ), // Membuat gap antar tab sekitar 16
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: -8,
                      vertical: 6,
                    ),
                    indicator: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary, // Indikator menggunakan warna tema aplikasi
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ), // Standar border radius 20
                    ),
                    labelColor: Colors
                        .white, // Teks putih saat aktif karena indikator primary
                    unselectedLabelColor: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                    labelStyle: GoogleFonts.inter(
                      fontSize: 14, // Perbesar fontsize
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: GoogleFonts.inter(
                      fontSize: 14, // Perbesar fontsize
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: const [
                      Tab(text: 'Daftar Lowongan'),
                      Tab(text: 'Tersimpan'),
                      Tab(text: 'Telah Dilamar'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // TAB 1: DAFTAR LOWONGAN
            FutureBuilder<List<CareerModel>>(
              future: _careersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Terjadi kesalahan: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada lowongan.'));
                }

                final careers = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                    bottom: 100,
                  ),
                  itemCount: careers.length,
                  itemBuilder: (c, i) => _buildJobCard(careers[i]),
                );
              },
            ),

            // TAB 2: TERSIMPAN
            FutureBuilder<List<CareerModel>>(
              future: _careersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Terjadi kesalahan: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada lowongan tersimpan.'),
                  );
                }

                final savedCareers = snapshot.data!
                    .where((c) => _savedCareerIds.contains(c.id))
                    .toList();

                if (savedCareers.isEmpty) {
                  return const Center(
                    child: Text('Belum ada lowongan yang disimpan.'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                    bottom: 100,
                  ),
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
                  return Center(
                    child: Text('Terjadi kesalahan: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada riwayat lamaran.'),
                  );
                }

                final appliedCareers = snapshot.data!
                    .where((c) => _appliedCareerIds.contains(c.id))
                    .toList();

                if (appliedCareers.isEmpty) {
                  return const Center(
                    child: Text(
                      'Anda belum melamar pekerjaan apa pun.\nCari dan lamar sekarang!',
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                    bottom: 100,
                  ),
                  itemCount: appliedCareers.length,
                  itemBuilder: (c, i) =>
                      _buildJobCard(appliedCareers[i], isAppliedTab: true),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(CareerModel career, {bool isAppliedTab = false}) {
    bool isSaved = _savedCareerIds.contains(career.id);
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
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
                    child: career.companyLogo.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              career.companyLogo,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => const Icon(
                                Icons.business,
                                color: Colors.grey,
                              ),
                            ),
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
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          career.companyName,
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
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
                        final prefs = await SharedPreferences.getInstance();
                        final saved = prefs.getStringList('saved_careers') ?? [];
                        int delta = 0;
                        if (isSaved) {
                          saved.remove(career.id);
                          delta = -1;
                        } else {
                          saved.add(career.id);
                          delta = 1;
                        }
                        await prefs.setStringList('saved_careers', saved);
                        
                        final updatedCareer = career.copyWith(
                          bookmarks: (career.bookmarks + delta) < 0 ? 0 : career.bookmarks + delta
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
                      '${career.city}, ${career.province}',
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (career.salaryVisible && career.salaryMin != null && career.salaryMax != null) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Rp ${(career.salaryMin! / 1000000).toStringAsFixed(0)} Jt - Rp ${(career.salaryMax! / 1000000).toStringAsFixed(0)} Jt',
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),

              // Badges & Date
              Row(
                children: [
                  Flexible(child: _buildMiniBadge(career.employmentType)),
                  const SizedBox(width: 8),
                  Flexible(child: _buildMiniBadge(career.level)),
                  const Spacer(),
                  if (isAppliedTab)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Status: Menunggu',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    Text(
                      'Beberapa hari lalu', // Ideally parse postedDate
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                      ),
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
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 11,
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
