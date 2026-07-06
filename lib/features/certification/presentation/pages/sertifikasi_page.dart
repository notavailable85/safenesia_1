// import 'package:flutter/material.dart';

// void main() {
//   // MaterialApp cukup dipanggil sekali di sini.
//   runApp(const CertificationApp());
// }

// class CertificationApp extends StatelessWidget {
//   const CertificationApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Aplikasi Sertifikasi',
//       theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
//       home: const CertListPage(),
//     );
//   }
// }

// // ==========================================
// // MODEL DATA DUMMY
// // ==========================================
// class CertModel {
//   final String id;
//   final String title;
//   final String category; // 'SMK3' atau 'ISO'
//   final String level; // Awal/Transisi/Lanjutan atau KAN/UKAS/EGAC
//   final int basePrice;

//   CertModel({
//     required this.id,
//     required this.title,
//     required this.category,
//     required this.level,
//     required this.basePrice,
//   });
// }

// final List<CertModel> dummyCertifications = [
//   CertModel(
//     id: '1',
//     title: 'Sertifikasi SMK3 PP 50/2012',
//     category: 'SMK3',
//     level: 'Kriteria: Awal (64 Kriteria)',
//     basePrice: 15000000,
//   ),
//   CertModel(
//     id: '2',
//     title: 'Sertifikasi SMK3 Konstruksi',
//     category: 'SMK3',
//     level: 'Kriteria: Lanjutan (166 Kriteria)',
//     basePrice: 25000000,
//   ),
//   CertModel(
//     id: '3',
//     title: 'Sertifikasi SMK3 Manufaktur',
//     category: 'SMK3',
//     level: 'Kriteria: Transisi (122 Kriteria)',
//     basePrice: 20000000,
//   ),
//   CertModel(
//     id: '4',
//     title: 'Sertifikasi ISO 9001:2015',
//     category: 'ISO',
//     level: 'Akreditasi: KAN',
//     basePrice: 12000000,
//   ),
//   CertModel(
//     id: '5',
//     title: 'Sertifikasi ISO 45001:2018',
//     category: 'ISO',
//     level: 'Akreditasi: UKAS',
//     basePrice: 18000000,
//   ),
//   CertModel(
//     id: '6',
//     title: 'Sertifikasi ISO 14001:2015',
//     category: 'ISO',
//     level: 'Akreditasi: EGAC',
//     basePrice: 16000000,
//   ),
// ];

// // ==========================================
// // 1. HALAMAN DAFTAR SERTIFIKASI
// // ==========================================
// class CertListPage extends StatefulWidget {
//   const CertListPage({super.key});

//   @override
//   State<CertListPage> createState() => _CertListPageState();
// }

// class _CertListPageState extends State<CertListPage> {
//   String _selectedCategory = 'SMK3';

//   @override
//   Widget build(BuildContext context) {
//     // Filter data berdasarkan kategori yang dipilih
//     final filteredList = dummyCertifications
//         .where((cert) => cert.category == _selectedCategory)
//         .toList();

//     // Scaffold dipakai di setiap halaman
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Daftar Sertifikasi'),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           // Filter Kategori di Body Atas
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             width: double.infinity,
//             color: Colors.white,
//             child: SegmentedButton<String>(
//               segments: const [
//                 ButtonSegment(value: 'SMK3', label: Text('Sertifikasi SMK3')),
//                 ButtonSegment(value: 'ISO', label: Text('Sertifikasi ISO')),
//               ],
//               selected: {_selectedCategory},
//               onSelectionChanged: (Set<String> newSelection) {
//                 setState(() {
//                   _selectedCategory = newSelection.first;
//                 });
//               },
//             ),
//           ),
//           const Divider(height: 1),
//           // Daftar Sertifikasi (Cards)
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: filteredList.length,
//               itemBuilder: (context, index) {
//                 final cert = filteredList[index];
//                 return Card(
//                   elevation: 3,
//                   margin: const EdgeInsets.only(bottom: 12),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           cert.title,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Chip(
//                               label: Text(
//                                 cert.category,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               backgroundColor: cert.category == 'SMK3'
//                                   ? Colors.blue.shade100
//                                   : Colors.orange.shade100,
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 cert.level,
//                                 style: TextStyle(color: Colors.grey.shade700),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Rp ${cert.basePrice}',
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green,
//                               ),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         CertDetailPage(certData: cert),
//                                   ),
//                                 );
//                               },
//                               child: const Text('Detail'),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ==========================================
// // 2. HALAMAN DETAIL SERTIFIKASI
// // ==========================================
// class CertDetailPage extends StatefulWidget {
//   final CertModel certData;
//   const CertDetailPage({super.key, required this.certData});

//   @override
//   State<CertDetailPage> createState() => _CertDetailPageState();
// }

// class _CertDetailPageState extends State<CertDetailPage> {
//   bool _withConsultation = false;
//   final int _consultationFee = 5000000;

//   @override
//   Widget build(BuildContext context) {
//     int currentTotal =
//         widget.certData.basePrice + (_withConsultation ? _consultationFee : 0);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Detail Sertifikasi')),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Foto Produk
//                   Container(
//                     width: double.infinity,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       color: Colors.indigo.shade50,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.verified,
//                       size: 80,
//                       color: Colors.indigo,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     widget.certData.title,
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Kategori: ${widget.certData.category} | ${widget.certData.level}',
//                     style: const TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                   const Divider(height: 32),

//                   _buildDetailSection(
//                     'Deskripsi',
//                     'Layanan sertifikasi resmi untuk memastikan sistem manajemen perusahaan Anda memenuhi standar yang ditetapkan oleh badan regulasi atau internasional.',
//                   ),
//                   _buildDetailSection(
//                     'Persyaratan',
//                     '1. Legalitas Perusahaan (Akta, NIB, NPWP)\n2. Struktur Organisasi\n3. Dokumen Manual Sistem Manajemen\n4. Laporan Internal Audit',
//                   ),
//                   _buildDetailSection(
//                     'Tahapan',
//                     '1. Kick-off Meeting\n2. Audit Stage 1 (Tinjauan Dokumen)\n3. Audit Stage 2 (Tinjauan Lapangan)\n4. Penerbitan Sertifikat',
//                   ),
//                   _buildDetailSection(
//                     'Fasilitas',
//                     '• Sertifikat Resmi\n• Laporan Hasil Audit\n• Softcopy Logo Sertifikasi',
//                   ),
//                   _buildDetailSection(
//                     'Info Pendaftaran',
//                     'Pendaftaran wajib dilakukan oleh perwakilan sah perusahaan. Jadwal audit akan disesuaikan setelah pembayaran DP atau Lunas.',
//                   ),

//                   const Divider(height: 32),
//                   // Opsi Konsultasi
//                   const Text(
//                     'Opsi Tambahan',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Card(
//                     color: _withConsultation
//                         ? Colors.indigo.shade50
//                         : Colors.white,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: CheckboxListTile(
//                       title: const Text(
//                         'Tambah Sesi Konsultasi & Pendampingan',
//                       ),
//                       subtitle: Text('Biaya tambahan: Rp $_consultationFee'),
//                       value: _withConsultation,
//                       activeColor: Colors.indigo,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           _withConsultation = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Bottom Booking Bar
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.shade300,
//                   blurRadius: 10,
//                   offset: const Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Total Biaya:',
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                     Text(
//                       'Rp $currentTotal',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.indigo,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 12,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CertFormPage(
//                           certData: widget.certData,
//                           withConsultation: _withConsultation,
//                           consultationFee: _consultationFee,
//                           totalPrice: currentTotal,
//                         ),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Pesan Sekarang',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailSection(String title, String content) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.indigo,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
//         ],
//       ),
//     );
//   }
// }

// // ==========================================
// // 3. HALAMAN FORM DATA PEMESAN & PERUSAHAAN
// // ==========================================
// class CertFormPage extends StatefulWidget {
//   final CertModel certData;
//   final bool withConsultation;
//   final int consultationFee;
//   final int totalPrice;

//   const CertFormPage({
//     super.key,
//     required this.certData,
//     required this.withConsultation,
//     required this.consultationFee,
//     required this.totalPrice,
//   });

//   @override
//   State<CertFormPage> createState() => _CertFormPageState();
// }

// class _CertFormPageState extends State<CertFormPage> {
//   final _formKey = GlobalKey<FormState>();

//   // Form 1: Detail Pemesan
//   final _namaController = TextEditingController();
//   final _ktpController = TextEditingController();
//   final _waController = TextEditingController();
//   final _emailController = TextEditingController();

//   // Form 2: Detail Perusahaan
//   final _namaPerusahaanController = TextEditingController();
//   final _alamatPerusahaanController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Formulir Pemesanan')),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             // --- FORM 1: DETAIL PEMESAN ---
//             const Text(
//               'Form 1: Detail PIC / Pemesan',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Card(
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _namaController,
//                       decoration: const InputDecoration(
//                         labelText: 'Nama Lengkap',
//                       ),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Nama wajib diisi' : null,
//                     ),
//                     TextFormField(
//                       controller: _ktpController,
//                       decoration: const InputDecoration(labelText: 'Nomor KTP'),
//                       keyboardType: TextInputType.number,
//                       validator: (value) =>
//                           value!.isEmpty ? 'KTP wajib diisi' : null,
//                     ),
//                     TextFormField(
//                       controller: _waController,
//                       decoration: const InputDecoration(
//                         labelText: 'No. WhatsApp',
//                       ),
//                       keyboardType: TextInputType.phone,
//                       validator: (value) =>
//                           value!.isEmpty ? 'WA wajib diisi' : null,
//                     ),
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: const InputDecoration(labelText: 'Email'),
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value!.isEmpty) return 'Email wajib diisi';
//                         if (!value.contains('@'))
//                           return 'Format email tidak valid';
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // --- FORM 2: DETAIL PERUSAHAAN ---
//             const Text(
//               'Form 2: Detail Perusahaan',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Card(
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _namaPerusahaanController,
//                       decoration: const InputDecoration(
//                         labelText: 'Nama Perusahaan PT/CV',
//                       ),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Nama Perusahaan wajib diisi' : null,
//                     ),
//                     TextFormField(
//                       controller: _alamatPerusahaanController,
//                       decoration: const InputDecoration(
//                         labelText: 'Alamat Lengkap Perusahaan',
//                       ),
//                       maxLines: 3,
//                       validator: (value) =>
//                           value!.isEmpty ? 'Alamat wajib diisi' : null,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.indigo,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.all(16),
//               ),
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   // Kirim data ke halaman Ringkasan
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CertSummaryPage(
//                         certData: widget.certData,
//                         withConsultation: widget.withConsultation,
//                         consultationFee: widget.consultationFee,
//                         totalPrice: widget.totalPrice,
//                         namaPerusahaan: _namaPerusahaanController.text,
//                         alamatPerusahaan: _alamatPerusahaanController.text,
//                       ),
//                     ),
//                   );
//                 }
//               },
//               child: const Text(
//                 'Lanjut Ke Ringkasan Pemesanan',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ==========================================
// // 4. HALAMAN RINGKASAN PEMESANAN
// // ==========================================
// class CertSummaryPage extends StatelessWidget {
//   final CertModel certData;
//   final bool withConsultation;
//   final int consultationFee;
//   final int totalPrice;
//   final String namaPerusahaan;
//   final String alamatPerusahaan;

//   const CertSummaryPage({
//     super.key,
//     required this.certData,
//     required this.withConsultation,
//     required this.consultationFee,
//     required this.totalPrice,
//     required this.namaPerusahaan,
//     required this.alamatPerusahaan,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Konfirmasi Pemesanan')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           const Text(
//             'Layanan Dipilih:',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Card(
//             margin: const EdgeInsets.only(top: 8, bottom: 16),
//             child: ListTile(
//               leading: const Icon(Icons.description, color: Colors.indigo),
//               title: Text(
//                 certData.title,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(certData.level),
//             ),
//           ),

//           const Text(
//             'Data Perusahaan:',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Card(
//             margin: const EdgeInsets.only(top: 8, bottom: 24),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     namaPerusahaan,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     alamatPerusahaan,
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const Text(
//             'Rincian Biaya:',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text('Biaya Sertifikasi Dasar'),
//               Text('Rp ${certData.basePrice}'),
//             ],
//           ),
//           const SizedBox(height: 8),
//           if (withConsultation)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Biaya Konsultasi'),
//                 Text('Rp $consultationFee'),
//               ],
//             ),
//           const Divider(height: 32, thickness: 1),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Total Tagihan',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               Text(
//                 'Rp $totalPrice',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Colors.green,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 40),

//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.all(16),
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       CertPaymentQrisPage(totalBayar: totalPrice),
//                 ),
//               );
//             },
//             child: const Text(
//               'Lanjut Ke Pembayaran QRIS',
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ==========================================
// // 5. HALAMAN PEMBAYARAN QRIS (DUMMY)
// // ==========================================
// class CertPaymentQrisPage extends StatelessWidget {
//   final int totalBayar;
//   const CertPaymentQrisPage({super.key, required this.totalBayar});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Pembayaran QRIS')),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Total Tagihan: Rp $totalBayar',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               // Dummy Gambar QRIS
//               Container(
//                 width: 280,
//                 height: 300,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(color: Colors.grey.shade300, blurRadius: 10),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.qr_code_2,
//                       size: 180,
//                       color: Colors.black87,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'QRIS PAYMENT DUMMY',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey.shade800,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Text(
//                       'Scan menggunakan e-Wallet / M-Banking',
//                       style: TextStyle(
//                         color: Colors.grey.shade600,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               OutlinedButton.icon(
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text(
//                         'Gambar QRIS berhasil diunduh ke galeri (Simulasi).',
//                       ),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.download),
//                 label: const Text('Download QRIS untuk Scan Hp'),
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 12,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),

//               // Bypass Simulasi Sukses
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.indigo,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 32,
//                     vertical: 16,
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const CertSuccessPage(),
//                     ),
//                     (route) => route.isFirst,
//                   );
//                 },
//                 child: const Text(
//                   'Simulasi Bayar Berhasil',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ==========================================
// // 6. HALAMAN SUKSES PEMBAYARAN
// // ==========================================
// class CertSuccessPage extends StatelessWidget {
//   const CertSuccessPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(32.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.verified_rounded,
//                 size: 120,
//                 color: Colors.green,
//               ),
//               const SizedBox(height: 24),
//               const Text(
//                 'Pendaftaran Berhasil!',
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Terima kasih! Pembayaran sertifikasi telah kami terima. Tim kami akan segera menghubungi PIC terdaftar untuk mengatur jadwal Kick-off Meeting.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
//               ),
//               const SizedBox(height: 40),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.indigo,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.all(16),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context); // Kembali ke Root
//                   },
//                   child: const Text(
//                     'Kembali ke Halaman Utama',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
