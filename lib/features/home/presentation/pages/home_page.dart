import 'dart:io';
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
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:safenesia_1/features/inspection/presentation/pages/inspection_order_page.dart';
import 'package:safenesia_1/features/inspection/presentation/pages/inspection_history_page.dart';
import 'package:safenesia_1/core/widgets/custom_download_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safenesia_1/core/utils/user_state.dart';
import 'package:gal/gal.dart';

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

  String _userName = 'Pengguna';
  String _userEmail = '';
  String? _userAvatarPath;
  final GlobalKey _cardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadSchedules();
    _loadUserData();
    UserState.profileUpdatedNotifier.addListener(_loadUserData);
  }

  @override
  void dispose() {
    UserState.profileUpdatedNotifier.removeListener(_loadUserData);
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (context.mounted) {
      setState(() {
        _userName = prefs.getString('user_name') ?? 'Pengguna';
        _userEmail = prefs.getString('user_email') ?? '';
        _userAvatarPath = prefs.getString('user_avatar_path');
      });
    }
  }

  Future<void> _loadSchedules() async {
    try {
      final data = await DatabaseHelper.instance.readAllSchedulesWithTraining();
      if (context.mounted) {
        setState(() {
          _schedules = data;
          _isLoadingSchedules = false;
        });
      }
    } catch (e) {
      if (context.mounted) {
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
    {'title': 'Karir K3', 'icon': Icons.work, 'color': Colors.purple},
    {'title': 'Regulasi K3', 'icon': Icons.gavel, 'color': Colors.red},
    {'title': 'Fitur Lainnya', 'icon': Icons.grid_view, 'color': Colors.grey},
  ];

  void _showMembershipPopup() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // KARTU PLATINUM
            RepaintBoundary(
              key: _cardKey,
              child: AspectRatio(
                aspectRatio:
                    1.586, // Rasio presisi kartu kredit (85.6mm x 53.98mm)
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFE2E2E2),
                        Color(
                          0xFFC9D6FF,
                        ), // Sedikit kilauan biru es khas platinum
                        Color(0xFFE2E2E2),
                        Color(0xFF9E9E9E),
                        Color(0xFFF5F7FA), // Perak cerah
                      ],
                      stops: [0.0, 0.3, 0.5, 0.8, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 15),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.8),
                      width: 1.5,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Baris Atas: Contactless Icon & Logo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.contactless,
                            color: Color(0xFF555555),
                            size: 28,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'SAFENESIA',
                                style: TextStyle(
                                  color: Color(0xFF222222),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                'PLATINUM',
                                style: TextStyle(
                                  color: const Color(
                                    0xFF222222,
                                  ).withValues(alpha: 0.7),
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Chip EMV
                      Positioned(
                        top: 50,
                        left: 0,
                        child: Container(
                          width: 42,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFE6C27A),
                                Color(0xFFD4AF37),
                                Color(0xFF996515),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.memory,
                            color: Colors.black54,
                            size: 24,
                          ),
                        ),
                      ),

                      // Nomor Kartu Embossed Style
                      const Positioned(
                        bottom: 45,
                        left: 0,
                        child: Text(
                          '5412  7512  3412  9000',
                          style: TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            fontFamily: 'Courier',
                            shadows: [
                              Shadow(
                                color: Colors.white70,
                                blurRadius: 1,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Nama Member
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CARDHOLDER',
                              style: TextStyle(
                                color: const Color(
                                  0xFF222222,
                                ).withValues(alpha: 0.5),
                                fontSize: 8,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              _userName.toUpperCase(),
                              style: const TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Valid Thru
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'VALID THRU',
                              style: TextStyle(
                                color: const Color(
                                  0xFF222222,
                                ).withValues(alpha: 0.5),
                                fontSize: 8,
                                letterSpacing: 1,
                              ),
                            ),
                            const Text(
                              '12/29',
                              style: TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                fontFamily: 'Courier',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Tombol Unduh Kartu
            CustomDownloadButton(
              label: 'Unduh Kartu',
              onPressed: () async {
                try {
                  // Tampilkan loading dialog sebentar
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (c) => const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );

                  // Meminta izin storage dengan gal
                  final hasAccess = await Gal.hasAccess(toAlbum: true);
                  if (!hasAccess) {
                    final request = await Gal.requestAccess(toAlbum: true);
                    if (!request) {
                      if (context.mounted) {
                        Navigator.pop(context); // Tutup loading
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: const Duration(milliseconds: 1500),
                            content: Text(
                              'Izin penyimpanan diperlukan untuk mengunduh kartu',
                            ),
                          ),
                        );
                      }
                      return;
                    }
                  }

                  // Tangkap gambar dari RepaintBoundary
                  RenderRepaintBoundary boundary =
                      _cardKey.currentContext!.findRenderObject()
                          as RenderRepaintBoundary;
                  ui.Image image = await boundary.toImage(
                    pixelRatio: 3.0,
                  ); // Kualitas tinggi
                  final byteData = await image.toByteData(
                    format: ui.ImageByteFormat.png,
                  );
                  final pngBytes = byteData!.buffer.asUint8List();

                  // Simpan ke galeri menggunakan gal
                  await Gal.putImageBytes(
                    pngBytes,
                    name:
                        'Safenesia_Membercard_${DateTime.now().millisecondsSinceEpoch}',
                  );

                  if (!context.mounted) return;
                  Navigator.pop(context); // Tutup loading

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: const Duration(milliseconds: 1500),
                      content: Text(
                        'Kartu berhasil diunduh dan masuk ke galeri!',
                      ),
                    ),
                  );
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context); // Tutup loading
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 1500),
                        content: Text('Gagal mengunduh kartu: $e'),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFiturLainnyaPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: 32 + MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const Text(
                  'Fitur Lainnya',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildPopupItem(
                            Icons.headset_mic,
                            'Konsultasi K3',
                            Colors.blue,
                          ),
                        ),
                        Expanded(
                          child: _buildPopupItem(
                            Icons.report_problem,
                            'Lapor Insiden',
                            Colors.red,
                          ),
                        ),
                        Expanded(
                          child: _buildPopupItem(
                            Icons.checklist_rtl,
                            'Inspeksi Harian',
                            Colors.teal,
                          ),
                        ),
                        Expanded(
                          child: _buildPopupItem(
                            Icons.calculate,
                            'Kalkulator Risiko',
                            Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildPopupItem(
                            Icons.store,
                            'Toko Safety',
                            Colors.green,
                          ),
                        ),
                        Expanded(
                          child: _buildPopupItem(
                            Icons.event,
                            'Webinar K3',
                            Colors.purple,
                          ),
                        ),
                        Expanded(
                          child: _buildPopupItem(
                            Icons.forum,
                            'Komunitas K3',
                            Colors.indigo,
                          ),
                        ),
                        Expanded(
                          child: _buildPopupItem(
                            Icons.newspaper,
                            'Berita Terkini',
                            Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopupItem(
    IconData icon,
    String title, [
    Color color = Colors.blue,
  ]) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: color.withValues(alpha: 0.1),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
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
    } else if (title == 'Regulasi K3' ||
        title == 'Riksa Uji Alat' ||
        title == 'Perpanjangan') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: const Duration(milliseconds: 1500),
          content: Text('Fitur sedang dalam pengembangan'),
        ),
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
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: _userAvatarPath != null
                  ? FileImage(File(_userAvatarPath!))
                  : null,
              child: _userAvatarPath == null
                  ? Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
            ),
            const SizedBox(width: 12), // <-- Jarak pasti antara foto dan teks
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _userEmail,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const SearchPage()),
                ),
                child: const Icon(Icons.search),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const NotificationPage()),
                ),
                child: const Icon(Icons.notifications),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: _showMembershipPopup,
                child: const Icon(Icons.credit_card),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 100),
        children: [
          // SLIDER BANNER
          Container(
            height: 180,
            color: Colors.transparent,
            child: PageView.builder(
              itemCount: _bannerImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentBannerIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: const EdgeInsets.all(16),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                _bannerImages[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _bannerImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // INDIKATOR SLIDER
          Container(
            color: Colors.transparent,
            padding: EdgeInsets.zero,
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // KONTAINER 1: GRID FITUR (4x2)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fitur Utama',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = (constraints.maxWidth - (3 * 12)) / 4;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 16,
                      alignment: WrapAlignment.start,
                      children: List.generate(8, (index) {
                        final feature = _features[index];
                        return SizedBox(
                          width: itemWidth,
                          child: InkWell(
                            onTap: () => _handleGridTap(feature['title']),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: feature['color'].withValues(
                                      alpha: 0.08,
                                    ),
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
                          ),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // KONTAINER 2: KONTEN DINAMIS
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedFeature == 'Pelatihan K3'
                      ? 'Pelatihan Terdekat'
                      : 'Kategori $_selectedFeature',
                  style: GoogleFonts.inter(
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
        return Column(
          children: [
            _buildList([
              'Pesan Riksa Uji Crane',
              'Pesan Riksa Uji Boiler',
              'Pesan Riksa Uji Lift',
              'Pesan Riksa Uji Genset',
              'Pesan Riksa Uji Penyalur Petir',
            ], (t) => _navDetailRiksaUji(t)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InspectionHistoryPage(),
                    ),
                  );
                },
                child: const Text('Lihat Riwayat Pesanan'),
              ),
            ),
          ],
        );
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

    final now = DateTime.now();
    // Anggap jadwal hari ini tetap berlaku (hilangkan jam)
    final today = DateTime(now.year, now.month, now.day);

    final sortedSchedules = List<TrainingSchedule>.from(_schedules);
    sortedSchedules.sort((a, b) {
      DateTime dateA;
      DateTime dateB;
      try {
        dateA = DateTime.parse(a.tanggalStart);
      } catch (e) {
        dateA = DateTime.fromMillisecondsSinceEpoch(0);
      }
      try {
        dateB = DateTime.parse(b.tanggalStart);
      } catch (e) {
        dateB = DateTime.fromMillisecondsSinceEpoch(0);
      }

      final isAPast = dateA.isBefore(today);
      final isBPast = dateB.isBefore(today);

      // Jika salah satu sudah lewat, yang belum lewat diutamakan
      if (isAPast && !isBPast) return 1;
      if (!isAPast && isBPast) return -1;

      // Jika keduanya upcoming (belum lewat), urutkan dari yang paling dekat dengan hari ini
      if (!isAPast && !isBPast) {
        return dateA.compareTo(dateB);
      }
      // Jika keduanya sudah lewat, tampilkan yang paling baru lewat
      else {
        return dateB.compareTo(dateA);
      }
    });

    // Ambil 5 jadwal yang posisinya secara waktu paling dekat dengan hari ini
    final displaySchedules = sortedSchedules.take(5).toList();

    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displaySchedules.length,
          itemBuilder: (context, index) {
            final schedule = displaySchedules[index];
            final training = schedule.trainingData;
            if (training == null) return const SizedBox();

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
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
              ),
            );
          },
        ),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TrainingListPage(),
                ),
              );
            },
            child: Text(
              'Lihat Lainnya',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : null,
              ),
            ),
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
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Card(
          child: ListTile(
            title: Text(items[i]),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onTap(items[i]),
          ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
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
      ),
    );
  }

  void _navDetailSertifikasi(String title) => Navigator.push(
    context,
    MaterialPageRoute(builder: (c) => DetailSertifikasiPage(title: title)),
  );
  void _navDetailRiksaUji(String title) => Navigator.push(
    context,
    MaterialPageRoute(builder: (c) => const InspectionOrderPage()),
  );
  void _navDetailPerpanjangan(String title) => Navigator.push(
    context,
    MaterialPageRoute(builder: (c) => DetailPerpanjanganPage(title: title)),
  );
}
