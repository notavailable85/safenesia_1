import 'package:flutter/material.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_list_page.dart';
import 'package:safenesia_1/features/career/career_page.dart';
import 'package:safenesia_1/features/home/presentation/pages/detail_page.dart';
import 'package:safenesia_1/features/notification/notification_page.dart';
import 'package:safenesia_1/features/regulation/regulation_page.dart';
import 'package:safenesia_1/features/search/search_page.dart';

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
              'Budi Santoso',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'budi.santoso@email.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
              ),
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
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.blue),
          ),
        ),
        title: GestureDetector(
          onTap: _showMembershipPopup,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Budi Santoso',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'budi.santoso@email.com',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => const NotificationPage()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => const SearchPage()),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // KONTAINER 1: GRID FITUR (4x2)
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Layanan Utama',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  'Pilihan $_selectedFeature',
                  style: const TextStyle(
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
        return _buildTabs(
          ['Kemnaker', 'BNSP', 'Awareness'],
          [
            _buildList([
              'Ahli K3 Umum',
              'Petugas P3K',
              'K3 Ketinggian',
              'K3 Listrik',
              'K3 Kimia',
            ], (t) => _navDetailPelatihan(t)),
            _buildList([
              'Auditor SMK3',
              'Ahli K3 Konstruksi',
            ], (t) => _navDetailPelatihan(t)),
            _buildList([
              'Basic Safety',
              'Ergonomi Perkantoran',
              'First Aid',
            ], (t) => _navDetailPelatihan(t)),
          ],
        );
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
