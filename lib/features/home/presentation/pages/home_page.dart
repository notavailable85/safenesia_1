import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_list_page.dart';
import 'package:safenesia_1/features/career/career_page.dart';
import 'package:safenesia_1/features/certification/presentation/pages/certification_list_page.dart';
import 'package:safenesia_1/features/home/presentation/pages/detail_page.dart';
import 'package:safenesia_1/features/notification/notification_page.dart';
import 'package:safenesia_1/features/regulation/regulation_page.dart';
import 'package:safenesia_1/features/search/search_page.dart';
import 'package:safenesia_1/features/training/presentation/pages/training_list_page.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';
import 'package:safenesia_1/features/training/presentation/pages/training_detail_page.dart';

// ==========================================
// 1. HALAMAN UTAMA (HOME PAGE)
// ==========================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedFeature = 'Pelatihan K3';
  int _currentBannerIndex = 0;

  List<TrainingSchedule> _schedules = [];
  bool _isLoadingSchedules = true;

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    try {
      final data = await DatabaseHelper.instance.readAllSchedulesWithTraining();
      if (mounted) {
        setState(() {
          _schedules = data;
          _isLoadingSchedules = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingSchedules = false);
      }
    }
  }

  final List<String> _bannerImages = [
    'assets/images/flayer_pelatihan/flayer_ahli_k3_umum.png',
    'assets/images/flayer_pelatihan/flayer_auditor_smk3.png',
    'assets/images/flayer_pelatihan/flayer_petugas_p3k.png',
  ];

  final List<Map<String, dynamic>> _features = [
    {'title': 'Pelatihan K3', 'icon': Icons.school, 'color': Colors.blue},
    {
      'title': 'Sertifikasi ISO/SMK3',
      'icon': Icons.verified,
      'color': Colors.green,
    },
    {
      'title': 'Riksa Uji Alat',
      'icon': Icons.precision_manufacturing,
      'color': Colors.orange,
    },
    {'title': 'Perpanjangan', 'icon': Icons.autorenew, 'color': Colors.teal},
    {'title': 'Artikel K3', 'icon': Icons.article, 'color': Colors.indigo},
    {'title': 'Regulasi K3', 'icon': Icons.gavel, 'color': Colors.red},
    {'title': 'Karir K3', 'icon': Icons.work, 'color': Colors.purple},
    {'title': 'Fitur Lainnya', 'icon': Icons.grid_view, 'color': Colors.grey},
  ];

  void _showMembershipPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.workspace_premium, color: Colors.amber, size: 60),
            const SizedBox(height: 16),
            const Text(
              'MEMBER PLATINUM',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Azhar Ridwan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'azharridwan@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kartu Membership diunduh')),
                );
              },
              icon: const Icon(Icons.download),
              label: const Text('Unduh Kartu'),
            ),
          ],
        ),
      ),
    );
  }

  void _showFiturLainnyaPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Fitur Lainnya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _buildPopupItem(Icons.headset_mic, 'Konsultasi'),
            _buildPopupItem(Icons.store, 'Toko Safety'),
            _buildPopupItem(Icons.event, 'Webinar'),
            _buildPopupItem(Icons.forum, 'Komunitas'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupItem(IconData icon, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  void _handleGridTap(String title) {
    if (title == 'Fitur Lainnya') {
      _showFiturLainnyaPopup();
    } else if (title == 'Pelatihan K3') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => const TrainingListPage()),
      );
    } else if (title == 'Sertifikasi ISO/SMK3') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => const CertListPage()),
      );
    } else if (title == 'Regulasi K3') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => const RegulasiPage()),
      );
    } else if (title == 'Artikel K3') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => const ArticleListPage()),
      );
    } else if (title == 'Karir K3') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => const KarirPage()),
      );
    } else {
      // Mengubah state Kontainer 2 (Maksimal 5 item yang tampil)
      setState(() => _selectedFeature = title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: _showMembershipPopup,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12), // <-- Jarak pasti antara foto dan teks
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Azhar Ridwan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'azharridwan@gmail.com',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => const SearchPage()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => const NotificationPage()),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // SLIDER BANNER
          Container(
            height: 180,
            color: Colors.white,
            child: PageView.builder(
              itemCount: _bannerImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentBannerIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(_bannerImages[index], fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
          // INDIKATOR SLIDER
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _bannerImages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: _currentBannerIndex == index ? 16.0 : 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: _currentBannerIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          // KONTAINER 1: GRID FITUR (4x2)
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fitur Utama',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final feature = _features[index];
                    return InkWell(
                      onTap: () => _handleGridTap(feature['title']),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: feature['color'].withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              feature['icon'],
                              color: feature['color'],
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            feature['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(thickness: 4, color: Color(0xFFF3F4F6)),

          // KONTAINER 2: KONTEN DINAMIS
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kategori $_selectedFeature',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildDynamicContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicContent() {
    switch (_selectedFeature) {
      case 'Pelatihan K3':
        return _buildTrainingCatalog();
      case 'Sertifikasi ISO/SMK3':
        return _buildTabs(
          ['ISO', 'SMK3'],
          [
            _buildList([
              'ISO 9001',
              'ISO 14001',
              'ISO 45001',
            ], (t) => _navDetailSertifikasi(t)),
            _buildList([
              'SMK3 64 Kriteria',
              'SMK3 122 Kriteria',
              'SMK3 166 Kriteria',
            ], (t) => _navDetailSertifikasi(t)),
          ],
        );
      case 'Riksa Uji Alat':
        return _buildList([
          'Riksa Uji Crane',
          'Riksa Uji Boiler',
          'Riksa Uji Lift',
          'Riksa Uji Genset',
          'Riksa Uji Penyalur Petir',
        ], (t) => _navDetailRiksaUji(t));
      case 'Perpanjangan':
        return Column(
          children: [
            _buildExtCard(
              'Perpanjangan SKP Ahli K3',
              'Sertifikasi Kemnaker RI',
              'Rp 1.500.000',
              () => _navDetailPerpanjangan('SKP Ahli K3'),
            ),
            _buildExtCard(
              'Perpanjangan Lisensi Alat Berat',
              'Sertifikasi Kemnaker RI',
              'Rp 1.200.000',
              () => _navDetailPerpanjangan('Lisensi Alat Berat'),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTrainingCatalog() {
    if (_isLoadingSchedules) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_schedules.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text('Tidak ada jadwal pelatihan.'),
        ),
      );
    }

    final displaySchedules = _schedules.take(10).toList();

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displaySchedules.length,
          itemBuilder: (context, index) {
            final schedule = displaySchedules[index];
            final training = schedule.trainingData;
            if (training == null) return const SizedBox();

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    training.gambarPelatihan,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  training.namaPelatihan,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.verified,
                          size: 14,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            training.sertifikasi,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            schedule.tanggalStr,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TrainingDetailPage(scheduleData: schedule),
                    ),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TrainingListPage(),
                ),
              );
            },
            child: const Text('Lihat Lainnya'),
          ),
        ),
      ],
    );
  }

  Widget _buildTabs(List<String> tabTitles, List<Widget> tabViews) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            isScrollable: true,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: tabTitles.map((t) => Tab(text: t)).toList(),
          ),
          SizedBox(height: 350, child: TabBarView(children: tabViews)),
        ],
      ),
    );
  }

  Widget _buildList(List<String> items, Function(String) onTap) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length > 5 ? 5 : items.length, // Maksimal 5
      itemBuilder: (context, i) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          title: Text(items[i]),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => onTap(items[i]),
        ),
      ),
    );
  }

  Widget _buildExtCard(
    String title,
    String subtitle,
    String price,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(
          price,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  void _navDetailPelatihan(String title) => Navigator.push(
    context,
    MaterialPageRoute(builder: (c) => DetailPelatihanPage(title: title)),
  );
  void _navDetailSertifikasi(String title) => Navigator.push(
    context,
    MaterialPageRoute(builder: (c) => DetailSertifikasiPage(title: title)),
  );
  void _navDetailRiksaUji(String title) => Navigator.push(
    context,
    MaterialPageRoute(builder: (c) => DetailRiksaUjiPage(title: title)),
  );
  void _navDetailPerpanjangan(String title) => Navigator.push(
    context,
    MaterialPageRoute(builder: (c) => DetailPerpanjanganPage(title: title)),
  );
}
