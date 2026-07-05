// import 'package:flutter/material.dart';

// void main() {
//   runApp(const SafenesiaApp());
// }

// class SafenesiaApp extends StatelessWidget {
//   const SafenesiaApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Safenesia Home Flow',
//       theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
//       home: const MainNavigationScreen(),
//     );
//   }
// }

// // ==========================================
// // 0. MAIN NAVIGATION (BOTTOM NAV BAR)
// // ==========================================
// class MainNavigationScreen extends StatefulWidget {
//   const MainNavigationScreen({super.key});

//   @override
//   State<MainNavigationScreen> createState() => _MainNavigationScreenState();
// }

// class _MainNavigationScreenState extends State<MainNavigationScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     const HomePage(),
//     const KarirPage(),
//     const PelatihanK3ListPage(), // Halaman khusus list Pelatihan dari Bottom Nav
//     const DummyAkunPage(), // Placeholder untuk halaman akun yang sudah dibuat sebelumnya
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) => setState(() => _selectedIndex = index),
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.blue.shade800,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Karir'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'Pelatihan K3',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
//         ],
//       ),
//     );
//   }
// }

// // ==========================================
// // 1. HALAMAN UTAMA (HOME PAGE)
// // ==========================================
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String _selectedFeature = 'Pelatihan K3';

//   final List<Map<String, dynamic>> _features = [
//     {'title': 'Pelatihan K3', 'icon': Icons.school, 'color': Colors.blue},
//     {
//       'title': 'Sertifikasi ISO/SMK3',
//       'icon': Icons.verified,
//       'color': Colors.green,
//     },
//     {
//       'title': 'Riksa Uji Alat',
//       'icon': Icons.precision_manufacturing,
//       'color': Colors.orange,
//     },
//     {'title': 'Perpanjangan', 'icon': Icons.autorenew, 'color': Colors.teal},
//     {'title': 'Artikel K3', 'icon': Icons.article, 'color': Colors.indigo},
//     {'title': 'Regulasi K3', 'icon': Icons.gavel, 'color': Colors.red},
//     {'title': 'Karir K3', 'icon': Icons.work, 'color': Colors.purple},
//     {'title': 'Fitur Lainnya', 'icon': Icons.grid_view, 'color': Colors.grey},
//   ];

//   void _showMembershipPopup() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         contentPadding: const EdgeInsets.all(24),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.workspace_premium, color: Colors.amber, size: 60),
//             const SizedBox(height: 16),
//             const Text(
//               'MEMBER PLATINUM',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//                 color: Colors.amber,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Budi Santoso',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const Text(
//               'budi.santoso@email.com',
//               style: TextStyle(color: Colors.grey),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue.shade800,
//                 foregroundColor: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Kartu Membership diunduh')),
//                 );
//               },
//               icon: const Icon(Icons.download),
//               label: const Text('Unduh Kartu'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showFiturLainnyaPopup() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text(
//           'Fitur Lainnya',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         content: Wrap(
//           spacing: 20,
//           runSpacing: 20,
//           children: [
//             _buildPopupItem(Icons.headset_mic, 'Konsultasi'),
//             _buildPopupItem(Icons.store, 'Toko Safety'),
//             _buildPopupItem(Icons.event, 'Webinar'),
//             _buildPopupItem(Icons.forum, 'Komunitas'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Tutup'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPopupItem(IconData icon, String title) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CircleAvatar(
//           radius: 25,
//           backgroundColor: Colors.blue.shade50,
//           child: Icon(icon, color: Colors.blue),
//         ),
//         const SizedBox(height: 8),
//         Text(title, style: const TextStyle(fontSize: 12)),
//       ],
//     );
//   }

//   void _handleGridTap(String title) {
//     if (title == 'Fitur Lainnya') {
//       _showFiturLainnyaPopup();
//     } else if (title == 'Regulasi K3') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (c) => const RegulasiPage()),
//       );
//     } else if (title == 'Artikel K3') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (c) => const ArtikelPage()),
//       );
//     } else if (title == 'Karir K3') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (c) => const KarirPage()),
//       );
//     } else {
//       // Mengubah state Kontainer 2 (Maksimal 5 item yang tampil)
//       setState(() => _selectedFeature = title);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue.shade800,
//         foregroundColor: Colors.white,
//         titleSpacing: 0,
//         leading: const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: CircleAvatar(
//             backgroundColor: Colors.white,
//             child: Icon(Icons.person, color: Colors.blue),
//           ),
//         ),
//         title: GestureDetector(
//           onTap: _showMembershipPopup,
//           child: const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Budi Santoso',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 'budi.santoso@email.com',
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (c) => const NotificationPage()),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (c) => const SearchPage()),
//             ),
//           ),
//         ],
//       ),
//       body: ListView(
//         children: [
//           // KONTAINER 1: GRID FITUR (4x2)
//           Container(
//             padding: const EdgeInsets.all(16),
//             color: Colors.white,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Layanan Utama',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: 8,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                     mainAxisSpacing: 16,
//                     crossAxisSpacing: 12,
//                     childAspectRatio: 0.85,
//                   ),
//                   itemBuilder: (context, index) {
//                     final feature = _features[index];
//                     return InkWell(
//                       onTap: () => _handleGridTap(feature['title']),
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: feature['color'].withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Icon(
//                               feature['icon'],
//                               color: feature['color'],
//                               size: 28,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             feature['title'],
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           const Divider(thickness: 4, color: Color(0xFFF3F4F6)),

//           // KONTAINER 2: KONTEN DINAMIS
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Pilihan $_selectedFeature',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildDynamicContent(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDynamicContent() {
//     switch (_selectedFeature) {
//       case 'Pelatihan K3':
//         return _buildTabs(
//           ['Kemnaker', 'BNSP', 'Awareness'],
//           [
//             _buildList([
//               'Ahli K3 Umum',
//               'Petugas P3K',
//               'K3 Ketinggian',
//               'K3 Listrik',
//               'K3 Kimia',
//             ], (t) => _navDetailPelatihan(t)),
//             _buildList([
//               'Auditor SMK3',
//               'Ahli K3 Konstruksi',
//             ], (t) => _navDetailPelatihan(t)),
//             _buildList([
//               'Basic Safety',
//               'Ergonomi Perkantoran',
//               'First Aid',
//             ], (t) => _navDetailPelatihan(t)),
//           ],
//         );
//       case 'Sertifikasi ISO/SMK3':
//         return _buildTabs(
//           ['ISO', 'SMK3'],
//           [
//             _buildList([
//               'ISO 9001',
//               'ISO 14001',
//               'ISO 45001',
//             ], (t) => _navDetailSertifikasi(t)),
//             _buildList([
//               'SMK3 64 Kriteria',
//               'SMK3 122 Kriteria',
//               'SMK3 166 Kriteria',
//             ], (t) => _navDetailSertifikasi(t)),
//           ],
//         );
//       case 'Riksa Uji Alat':
//         return _buildList([
//           'Riksa Uji Crane',
//           'Riksa Uji Boiler',
//           'Riksa Uji Lift',
//           'Riksa Uji Genset',
//           'Riksa Uji Penyalur Petir',
//         ], (t) => _navDetailRiksaUji(t));
//       case 'Perpanjangan':
//         return Column(
//           children: [
//             _buildExtCard(
//               'Perpanjangan SKP Ahli K3',
//               'Sertifikasi Kemnaker RI',
//               'Rp 1.500.000',
//               () => _navDetailPerpanjangan('SKP Ahli K3'),
//             ),
//             _buildExtCard(
//               'Perpanjangan Lisensi Alat Berat',
//               'Sertifikasi Kemnaker RI',
//               'Rp 1.200.000',
//               () => _navDetailPerpanjangan('Lisensi Alat Berat'),
//             ),
//           ],
//         );
//       default:
//         return const SizedBox.shrink();
//     }
//   }

//   Widget _buildTabs(List<String> tabTitles, List<Widget> tabViews) {
//     return DefaultTabController(
//       length: tabTitles.length,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TabBar(
//             isScrollable: true,
//             labelColor: Colors.blue,
//             unselectedLabelColor: Colors.grey,
//             tabs: tabTitles.map((t) => Tab(text: t)).toList(),
//           ),
//           SizedBox(height: 350, child: TabBarView(children: tabViews)),
//         ],
//       ),
//     );
//   }

//   Widget _buildList(List<String> items, Function(String) onTap) {
//     return ListView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: items.length > 5 ? 5 : items.length, // Maksimal 5
//       itemBuilder: (context, i) => Card(
//         margin: const EdgeInsets.only(bottom: 8),
//         child: ListTile(
//           title: Text(items[i]),
//           trailing: const Icon(Icons.chevron_right),
//           onTap: () => onTap(items[i]),
//         ),
//       ),
//     );
//   }

//   Widget _buildExtCard(
//     String title,
//     String subtitle,
//     String price,
//     VoidCallback onTap,
//   ) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: ListTile(
//         contentPadding: const EdgeInsets.all(16),
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(subtitle),
//         trailing: Text(
//           price,
//           style: const TextStyle(
//             color: Colors.green,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         onTap: onTap,
//       ),
//     );
//   }

//   void _navDetailPelatihan(String title) => Navigator.push(
//     context,
//     MaterialPageRoute(builder: (c) => DetailPelatihanPage(title: title)),
//   );
//   void _navDetailSertifikasi(String title) => Navigator.push(
//     context,
//     MaterialPageRoute(builder: (c) => DetailSertifikasiPage(title: title)),
//   );
//   void _navDetailRiksaUji(String title) => Navigator.push(
//     context,
//     MaterialPageRoute(builder: (c) => DetailRiksaUjiPage(title: title)),
//   );
//   void _navDetailPerpanjangan(String title) => Navigator.push(
//     context,
//     MaterialPageRoute(builder: (c) => DetailPerpanjanganPage(title: title)),
//   );
// }

// // ==========================================
// // 2. SEARCH & NOTIFICATION PAGE
// // ==========================================
// class NotificationPage extends StatelessWidget {
//   const NotificationPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Notifikasi')),
//       body: ListView(
//         children: const [
//           ListTile(
//             leading: Icon(Icons.warning, color: Colors.red),
//             title: Text('Sertifikat Berakhir'),
//             subtitle: Text(
//               'Sertifikat Ahli K3 Umum Anda akan kadaluarsa dalam 30 hari.',
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.payment, color: Colors.green),
//             title: Text('Transaksi Berhasil'),
//             subtitle: Text('Pembayaran Riksa Uji Crane telah diverifikasi.'),
//           ),
//           ListTile(
//             leading: Icon(Icons.info, color: Colors.blue),
//             title: Text('Update Aplikasi'),
//             subtitle: Text(
//               'Versi terbaru Safenesia kini tersedia dengan fitur baru!',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});
//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   List<String> history = ['K3 Umum', 'ISO 9001', 'Perpanjangan Lisensi'];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const TextField(
//           autofocus: true,
//           decoration: InputDecoration(
//             hintText: 'Cari layanan, artikel...',
//             border: InputBorder.none,
//             hintStyle: TextStyle(color: Colors.white70),
//           ),
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.blue.shade800,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Pencarian Terakhir',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextButton(
//                   onPressed: () => setState(() => history.clear()),
//                   child: const Text(
//                     'Hapus Semua',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ],
//             ),
//             ...history.map(
//               (h) => ListTile(
//                 leading: const Icon(Icons.history),
//                 title: Text(h),
//                 contentPadding: EdgeInsets.zero,
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Pencarian Populer',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//               spacing: 8,
//               children:
//                   ['Ahli K3', 'Riksa Uji Lift', 'Auditor SMK3', 'First Aid']
//                       .map(
//                         (p) => Chip(
//                           label: Text(p),
//                           backgroundColor: Colors.blue.shade50,
//                         ),
//                       )
//                       .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ==========================================
// // 3. DETAIL PAGES
// // ==========================================
// Widget _buildDetailSection(String title, String content) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 16),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
//       ],
//     ),
//   );
// }

// class DetailPelatihanPage extends StatelessWidget {
//   final String title;
//   const DetailPelatihanPage({super.key, required this.title});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Detail Pelatihan')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Container(
//             height: 200,
//             color: Colors.blueGrey.shade100,
//             child: const Icon(Icons.image, size: 80),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             title,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const Divider(height: 32),
//           _buildDetailSection(
//             'Deskripsi',
//             'Pelatihan komprehensif untuk mencetak tenaga ahli profesional di bidangnya.',
//           ),
//           _buildDetailSection(
//             'Persyaratan',
//             '1. Minimal D3/S1\n2. Pas Foto 3x4\n3. Surat Rekomendasi',
//           ),
//           _buildDetailSection(
//             'Materi Pelatihan',
//             '• Peraturan Perundangan\n• Dasar-dasar K3\n• Manajemen Risiko',
//           ),
//           _buildDetailSection(
//             'Fasilitas',
//             '• Modul Softcopy\n• Sertifikat\n• Kaos Safety',
//           ),
//           _buildDetailSection(
//             'Info Pendaftaran',
//             'Pendaftaran ditutup 3 hari sebelum kelas dimulai.',
//           ),
//           ElevatedButton(
//             onPressed: () {},
//             child: const Text('Daftar Sekarang'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DetailSertifikasiPage extends StatelessWidget {
//   final String title;
//   const DetailSertifikasiPage({super.key, required this.title});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Detail Sertifikasi')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Container(
//             height: 200,
//             color: Colors.green.shade100,
//             child: const Icon(Icons.verified, size: 80),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             title,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const Divider(height: 32),
//           _buildDetailSection(
//             'Deskripsi',
//             'Sertifikasi untuk memastikan sistem manajemen perusahaan Anda sesuai standar.',
//           ),
//           _buildDetailSection(
//             'Persyaratan',
//             '1. Legalitas Perusahaan\n2. Manual Sistem Manajemen\n3. Bukti Implementasi',
//           ),
//           _buildDetailSection(
//             'Tahapan',
//             '1. Pendaftaran\n2. Audit Tahap 1\n3. Audit Tahap 2\n4. Penerbitan Sertifikat',
//           ),
//           _buildDetailSection(
//             'Fasilitas',
//             '• Sertifikat Resmi\n• Laporan Audit\n• Softcopy Logo',
//           ),
//           _buildDetailSection(
//             'Info Pendaftaran',
//             'Hubungi admin untuk penjadwalan Kick-off meeting.',
//           ),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Pesan Sertifikasi'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DetailRiksaUjiPage extends StatelessWidget {
//   final String title;
//   const DetailRiksaUjiPage({super.key, required this.title});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Detail Riksa Uji')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Container(
//             height: 200,
//             color: Colors.orange.shade100,
//             child: const Icon(Icons.precision_manufacturing, size: 80),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             title,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const Divider(height: 32),
//           _buildDetailSection(
//             'Deskripsi',
//             'Pengujian untuk memastikan kelayakan operasional dan keamanan alat kerja Anda.',
//           ),
//           _buildDetailSection(
//             'Persyaratan',
//             '1. Data Perusahaan\n2. Dokumen Teknis Alat\n3. Akses Lokasi Unit',
//           ),
//           _buildDetailSection(
//             'Spesifikasi Alat',
//             'Cakupan: Pemeriksaan Visual, Uji Tidak Merusak (NDT), Uji Beban.',
//           ),
//           _buildDetailSection(
//             'Fasilitas',
//             '• Suket Kemnaker\n• Plat Layak Operasi\n• Laporan Teknis',
//           ),
//           _buildDetailSection(
//             'Info Pendaftaran',
//             'Jadwal riksa uji disesuaikan dengan kesiapan lapangan.',
//           ),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.orange,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Pesan Riksa Uji'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DetailPerpanjanganPage extends StatelessWidget {
//   final String title;
//   const DetailPerpanjanganPage({super.key, required this.title});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Detail Perpanjangan')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Container(
//             height: 200,
//             color: Colors.teal.shade100,
//             child: const Icon(Icons.autorenew, size: 80),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             title,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const Divider(height: 32),
//           _buildDetailSection(
//             'Deskripsi',
//             'Perpanjangan masa berlaku dokumen legalitas kompetensi ahli.',
//           ),
//           _buildDetailSection(
//             'Persyaratan',
//             '1. SKP/Lisensi Asli Lama\n2. KTP & Pas Foto Terbaru\n3. Surat Laporan Kegiatan',
//           ),
//           _buildDetailSection(
//             'Materi (Refreshment)',
//             '• Update Regulasi\n• Studi Kasus Kecelakaan Kerja',
//           ),
//           _buildDetailSection(
//             'Fasilitas',
//             '• SKP/Lisensi Baru\n• Gratis Ongkir Pengiriman',
//           ),
//           _buildDetailSection(
//             'Info Pendaftaran',
//             'Maksimal H-30 sebelum expired.',
//           ),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.teal,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Ajukan Perpanjangan'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ==========================================
// // 4. ARTIKEL, REGULASI, & KARIR PAGES
// // ==========================================
// class RegulasiPage extends StatelessWidget {
//   const RegulasiPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final categories = [
//       'Undang-undang',
//       'Peraturan Presiden',
//       'Peraturan Pemerintah',
//       'Peraturan Menteri',
//       'Keputusan Menteri',
//       'Instruksi Menteri',
//       'Keputusan Dirjen',
//       'Surat Edaran Menteri',
//       'Keputusan Bersama Menteri',
//     ];
//     return Scaffold(
//       appBar: AppBar(title: const Text('Regulasi K3')),
//       body: ListView.builder(
//         itemCount: categories.length,
//         itemBuilder: (context, i) => ExpansionTile(
//           title: Text(
//             categories[i],
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           children: [
//             ListTile(
//               leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
//               title: Text('File PDF ${categories[i]} No.1'),
//               onTap: () => ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Menampilkan PDF...')),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ArtikelPage extends StatefulWidget {
//   const ArtikelPage({super.key});
//   @override
//   State<ArtikelPage> createState() => _ArtikelPageState();
// }

// class _ArtikelPageState extends State<ArtikelPage> {
//   String _selectedKategori = 'Umum';
//   final List<String> _kategori = [
//     'Umum',
//     'Listrik',
//     'Konstruksi',
//     'Tambang',
//     'Rumah Sakit',
//     'Oil & Gas',
//     'Manufaktur',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Artikel K3')),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 60,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               itemCount: _kategori.length,
//               itemBuilder: (context, i) => Padding(
//                 padding: const EdgeInsets.only(right: 8),
//                 child: FilterChip(
//                   label: Text(_kategori[i]),
//                   selected: _selectedKategori == _kategori[i],
//                   onSelected: (val) =>
//                       setState(() => _selectedKategori = _kategori[i]),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: 4,
//               itemBuilder: (context, i) => Card(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 150,
//                       width: double.infinity,
//                       color: Colors.grey.shade300,
//                       child: const Icon(Icons.image, size: 50),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Pentingnya APD di Sektor $_selectedKategori',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           const Text(
//                             '12 Agustus 2026',
//                             style: TextStyle(color: Colors.grey, fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class KarirPage extends StatefulWidget {
//   const KarirPage({super.key});
//   @override
//   State<KarirPage> createState() => _KarirPageState();
// }

// class _KarirPageState extends State<KarirPage> {
//   void _showFilter(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           top: 24,
//           left: 24,
//           right: 24,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Filter Lowongan',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const TextField(decoration: InputDecoration(labelText: 'Kota')),
//             const TextField(
//               decoration: InputDecoration(labelText: 'Bidang Spesialis'),
//             ),
//             Row(
//               children: const [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(labelText: 'Gaji Min'),
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(labelText: 'Gaji Max'),
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Terapkan'),
//               ),
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Karir K3'),
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'Daftar Lowongan'),
//               Tab(text: 'Tersimpan'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     children: [
//                       const Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Cari posisi...',
//                             prefixIcon: Icon(Icons.search),
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       IconButton(
//                         icon: const Icon(Icons.tune, color: Colors.blue),
//                         onPressed: () => _showFilter(context),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     itemCount: 4,
//                     itemBuilder: (c, i) => _buildJobCard(false),
//                   ),
//                 ),
//               ],
//             ),
//             ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: 2,
//               itemBuilder: (c, i) => _buildJobCard(true),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildJobCard(bool isSaved) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               color: Colors.grey.shade200,
//               child: const Icon(Icons.business),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'HSE Officer',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const Text(
//                     'Bidang: Manufaktur | PT Maju Jaya',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: const [
//                       Icon(Icons.location_on, size: 14, color: Colors.grey),
//                       SizedBox(width: 4),
//                       Text(
//                         'Jakarta',
//                         style: TextStyle(color: Colors.grey, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: const [
//                       Icon(Icons.monetization_on, size: 14, color: Colors.grey),
//                       SizedBox(width: 4),
//                       Text(
//                         'Rp 8 Jt - Rp 12 Jt',
//                         style: TextStyle(color: Colors.grey, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               isSaved ? Icons.bookmark : Icons.bookmark_border,
//               color: Colors.blue,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ==========================================
// // 5. PLACEHOLDERS (Untuk kelengkapan Bottom Nav)
// // ==========================================
// class PelatihanK3ListPage extends StatelessWidget {
//   const PelatihanK3ListPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Semua Pelatihan K3')),
//       body: const Center(
//         child: Text('Gunakan halaman Pelatihan sebelumnya di sini'),
//       ),
//     );
//   }
// }

// class DummyAkunPage extends StatelessWidget {
//   const DummyAkunPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Akun Saya')),
//       body: const Center(
//         child: Text('Gunakan halaman Akun sebelumnya di sini'),
//       ),
//     );
//   }
// }
