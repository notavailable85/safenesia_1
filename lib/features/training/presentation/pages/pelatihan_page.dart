// import 'package:flutter/material.dart';

// void main() {
//   runApp(const SafeNesiaApp());
// }

// class SafeNesiaApp extends StatelessWidget {
//   const SafeNesiaApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pelatihan K3',
//       theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
//       home: const TrainingListPage(),
//     );
//   }
// }

// // ==========================================
// // 1. HALAMAN DAFTAR PELATHAN (TABS & CARD)
// // ==========================================
// class TrainingListPage extends StatelessWidget {
//   const TrainingListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4, // Kuartal/Per 3 Bulan dalam setahun
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Daftar Pelatihan K3'),
//           backgroundColor: Colors.blue,
//           foregroundColor: Colors.white,
//           bottom: const TabBar(
//             isScrollable: true,
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.white70,
//             tabs: [
//               Tab(text: 'Jan - Mar'),
//               Tab(text: 'Apr - Jun'),
//               Tab(text: 'Jul - Sep'),
//               Tab(text: 'Okt - Des'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildTrainingList(context, 'Kuartal 1'),
//             _buildTrainingList(context, 'Kuartal 2'),
//             _buildTrainingList(context, 'Kuartal 3'),
//             _buildTrainingList(context, 'Kuartal 4'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTrainingList(BuildContext context, String kuartal) {
//     // Data Dummy Pelatihan
//     final dummyTrainings = [
//       {
//         'judul': 'Ahli K3 Umum',
//         'sertifikasi': 'Sertifikasi Kemnaker RI',
//         'tanggal': '12 Jul - 24 Jul 2026',
//         'harga': 5500000,
//       },
//       {
//         'judul': 'Petugas Pemadam Kebakaran Kelas D',
//         'sertifikasi': 'Sertifikasi Kemnaker RI',
//         'tanggal': '18 Agst - 21 Agst 2026',
//         'harga': 3500000,
//       },
//       {
//         'judul': 'K3 Bekerja di Ketinggian',
//         'sertifikasi': 'Sertifikasi Kemnaker RI',
//         'tanggal': '05 Sep - 08 Sep 2026',
//         'harga': 4000000,
//       },
//     ];

//     return ListView.builder(
//       padding: const EdgeInsets.all(12),
//       itemCount: dummyTrainings.length,
//       itemBuilder: (context, index) {
//         final item = dummyTrainings[index];
//         return Card(
//           elevation: 4,
//           margin: const EdgeInsets.only(bottom: 12),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item['judul'] as String,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Chip(
//                   label: Text(item['sertifikasi'] as String),
//                   backgroundColor: Colors.blue.shade50,
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.calendar_today,
//                       size: 16,
//                       color: Colors.grey,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(item['tanggal'] as String),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Rp ${item['harga']}',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 TrainingDetailPage(trainingData: item),
//                           ),
//                         );
//                       },
//                       child: const Text('Detail & Daftar'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // ==========================================
// // 2. HALAMAN DETAIL PELATHAN
// // ==========================================
// class TrainingDetailPage extends StatelessWidget {
//   final Map<String, dynamic> trainingData;

//   const TrainingDetailPage({super.key, required this.trainingData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(trainingData['judul'])),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Dummy Foto Produk Pelatihan
//             Container(
//               width: double.infinity,
//               height: 200,
//               color: Colors.blueGrey.shade100,
//               child: const Icon(Icons.image, size: 100, color: Colors.white),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               trainingData['judul'],
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               trainingData['sertifikasi'],
//               style: const TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             const Divider(height: 32),

//             _buildSection(
//               'Deskripsi',
//               'Pelatihan ini dirancang untuk membekali peserta dengan pengetahuan dan keterampilan praktis terkait keselamatan kerja sesuai regulasi undang-undang.',
//             ),
//             _buildSection(
//               'Persyaratan',
//               '1. Pendidikan minimal D3/S1 (Umum) atau SMA (Pengalaman kerja K3 2 tahun)\n2. Scan KTP & Ijazah\n3. Surat Rekomendasi Perusahaan (jika utusan)',
//             ),
//             _buildSection(
//               'Materi Pelatihan',
//               '• Peraturan Perundangan K3\n• Dasar-dasar K3\n• Manajemen Risiko & SMK3\n• Analisis Kecelakaan Kerja',
//             ),
//             _buildSection(
//               'Fasilitas',
//               '• Sertifikat Kemnaker RI\n• Modul & Training Kit\n• Makan Siang & Coffee Break\n• Kemeja Safety (Wearpack)',
//             ),
//             _buildSection(
//               'Info Pendaftaran',
//               'Pendaftaran ditutup H-7 sebelum pelaksanaan kelas dimulai. Kuota terbatas untuk efektivitas praktikum.',
//             ),

//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   foregroundColor: Colors.white,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           OrderFormPage(trainingData: trainingData),
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   'Pesan Pelatihan Sekarang',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(String title, String content) {
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
//               color: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(content, style: const TextStyle(fontSize: 14, height: 1.4)),
//         ],
//       ),
//     );
//   }
// }

// // ==========================================
// // 3. HALAMAN FORM DATA PEMESAN & PESERTA
// // ==========================================
// class OrderFormPage extends StatefulWidget {
//   final Map<String, dynamic> trainingData;
//   const OrderFormPage({super.key, required this.trainingData});

//   @override
//   State<OrderFormPage> createState() => _OrderFormPageState();
// }

// class _OrderFormPageState extends State<OrderFormPage> {
//   final _formKey = GlobalKey<FormState>();

//   // Form 1
//   String _jenisPeserta = 'Pribadi';
//   int _jumlahPeserta = 1;

//   // Form 2 (Data Pemesan Utama)
//   final _namaPemesanController = TextEditingController();
//   final _ktpPemesanController = TextEditingController();
//   final _waPemesanController = TextEditingController();
//   final _emailPemesanController = TextEditingController();

//   // Form 3 (Daftar Peserta detail)
//   List<Map<String, String>> _daftarPeserta = [];

//   @override
//   void initState() {
//     super.initState();
//     _updatePesertaList();
//   }

//   void _updatePesertaList() {
//     _daftarPeserta = List.generate(_jumlahPeserta, (index) {
//       if (index < _daftarPeserta.length) return _daftarPeserta[index];
//       return {'nama': '', 'ktp': '', 'wa': '', 'email': ''};
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Data Pemesan & Peserta')),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             // --- FORM 1: TIPE & JUMLAH PESERTA ---
//             const Text(
//               'Form 1: Tipe & Jumlah Peserta',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   children: [
//                     DropdownButtonFormField<String>(
//                       value: _jenisPeserta,
//                       decoration: const InputDecoration(
//                         labelText: 'Jenis Peserta',
//                       ),
//                       items: ['Pribadi', 'Perusahaan']
//                           .map(
//                             (t) => DropdownMenuItem(value: t, child: Text(t)),
//                           )
//                           .toList(),
//                       onChanged: (val) => setState(() => _jenisPeserta = val!),
//                     ),
//                     DropdownButtonFormField<int>(
//                       value: _jumlahPeserta,
//                       decoration: const InputDecoration(
//                         labelText: 'Jumlah Peserta (Maksimal 10)',
//                       ),
//                       items: List.generate(
//                         10,
//                         (i) => DropdownMenuItem(
//                           value: i + 1,
//                           child: Text('${i + 1} Orang'),
//                         ),
//                       ),
//                       onChanged: (val) {
//                         setState(() {
//                           _jumlahPeserta = val!;
//                           _updatePesertaList();
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // --- FORM 2: DATA PEMESAN ---
//             const Text(
//               'Form 2: Kontak Pemesan Utama',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _namaPemesanController,
//                       decoration: const InputDecoration(
//                         labelText: 'Nama Lengkap',
//                       ),
//                       validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
//                     ),
//                     TextFormField(
//                       controller: _ktpPemesanController,
//                       decoration: const InputDecoration(labelText: 'Nomor KTP'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     TextFormField(
//                       controller: _waPemesanController,
//                       decoration: const InputDecoration(
//                         labelText: 'No. WhatsApp',
//                       ),
//                       keyboardType: TextInputType.phone,
//                     ),
//                     TextFormField(
//                       controller: _emailPemesanController,
//                       decoration: const InputDecoration(labelText: 'Email'),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // --- FORM 3: DETAIL PESERTA ---
//             const Text(
//               'Form 3: Detail Setiap Peserta (Wajib Diisi)',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: _jumlahPeserta,
//               itemBuilder: (context, index) {
//                 final p = _daftarPeserta[index];
//                 bool isDataFilled = p['nama']!.isNotEmpty;

//                 return Card(
//                   color: isDataFilled
//                       ? Colors.green.shade50
//                       : Colors.orange.shade50,
//                   child: ListTile(
//                     title: Text(
//                       'Peserta ${index + 1}: ${isDataFilled ? p['nama'] : "Belum diisi"}',
//                     ),
//                     subtitle: Text(
//                       isDataFilled
//                           ? 'KTP: ${p['ktp']}'
//                           : 'Klik tombol edit di samping untuk mengisi data',
//                     ),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.edit, color: Colors.blue),
//                       onPressed: () async {
//                         // Arahkan ke halaman baru untuk input detail peserta
//                         final result = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailPesertaInputPage(
//                               index: index,
//                               initialData: p,
//                             ),
//                           ),
//                         );
//                         if (result != null) {
//                           setState(() {
//                             _daftarPeserta[index] = result;
//                           });
//                         }
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.all(16),
//               ),
//               onPressed: () {
//                 // Validasi data peserta harus terisi semua
//                 bool allFilled = _daftarPeserta.every(
//                   (p) => p['nama']!.isNotEmpty,
//                 );
//                 if (_formKey.currentState!.validate() && allFilled) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => OrderSummaryPage(
//                         trainingData: widget.trainingData,
//                         jumlahPeserta: _jumlahPeserta,
//                         daftarPeserta: _daftarPeserta,
//                         jenisPeserta: _jenisPeserta,
//                       ),
//                     ),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text(
//                         'Mohon lengkapi seluruh formulir dan detail data peserta!',
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

// // HALAMAN SUB-FORM INPUT PESERTA (HALAMAN BARU)
// class DetailPesertaInputPage extends StatefulWidget {
//   final int index;
//   final Map<String, String> initialData;
//   const DetailPesertaInputPage({
//     super.key,
//     required this.index,
//     required this.initialData,
//   });

//   @override
//   State<DetailPesertaInputPage> createState() => _DetailPesertaInputPageState();
// }

// class _DetailPesertaInputPageState extends State<DetailPesertaInputPage> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _namaCtrl;
//   late TextEditingController _ktpCtrl;
//   late TextEditingController _waCtrl;
//   late TextEditingController _emailCtrl;

//   @override
//   void initState() {
//     super.initState();
//     _namaCtrl = TextEditingController(text: widget.initialData['nama']);
//     _ktpCtrl = TextEditingController(text: widget.initialData['ktp']);
//     _waCtrl = TextEditingController(text: widget.initialData['wa']);
//     _emailCtrl = TextEditingController(text: widget.initialData['email']);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Data Lengkap Peserta ${widget.index + 1}')),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             TextFormField(
//               controller: _namaCtrl,
//               decoration: const InputDecoration(labelText: 'Nama Lengkap'),
//               validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
//             ),
//             TextFormField(
//               controller: _ktpCtrl,
//               decoration: const InputDecoration(labelText: 'Nomor KTP'),
//               keyboardType: TextInputType.number,
//               validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
//             ),
//             TextFormField(
//               controller: _waCtrl,
//               decoration: const InputDecoration(labelText: 'No. WA'),
//               keyboardType: TextInputType.phone,
//               validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
//             ),
//             TextFormField(
//               controller: _emailCtrl,
//               decoration: const InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//               validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   Navigator.pop(context, {
//                     'nama': _namaCtrl.text,
//                     'ktp': _ktpCtrl.text,
//                     'wa': _waCtrl.text,
//                     'email': _emailCtrl.text,
//                   });
//                 }
//               },
//               child: const Text('Simpan Data Peserta'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ==========================================
// // 4. HALAMAN RINGKASAN PEMESANAN (CHECKOUT)
// // ==========================================
// class OrderSummaryPage extends StatelessWidget {
//   final Map<String, dynamic> trainingData;
//   final int jumlahPeserta;
//   final String jenisPeserta;
//   final List<Map<String, String>> daftarPeserta;

//   const OrderSummaryPage({
//     super.key,
//     required this.trainingData,
//     required this.jumlahPeserta,
//     required this.jenisPeserta,
//     required this.daftarPeserta,
//   });

//   @override
//   Widget build(BuildContext context) {
//     int hargaSatuan = trainingData['harga'] as int;
//     int totalHarga = hargaSatuan * jumlahPeserta;

//     return Scaffold(
//       appBar: AppBar(title: const Text('Konfirmasi Pemesanan')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // Info Pelatihan
//           Card(
//             child: ListTile(
//               title: Text(
//                 trainingData['judul'],
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 '${trainingData['sertifikasi']}\nTipe: $jenisPeserta',
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),

//           // Daftar Peserta
//           const Text(
//             'Daftar Peserta:',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           ...daftarPeserta.map(
//             (p) => ListTile(
//               leading: const Icon(Icons.person),
//               title: Text(p['nama']!),
//               subtitle: Text('KTP: ${p['ktp']} | WA: ${p['wa']}'),
//             ),
//           ),
//           const Divider(height: 32),

//           // Rincian Harga
//           const Text(
//             'Rincian Pembayaran:',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Harga Satuan ($jumlahPeserta x)'),
//               Text('Rp $hargaSatuan'),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Total Pembayaran',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               Text(
//                 'Rp $totalHarga',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                   color: Colors.green,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 32),

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
//                   builder: (context) => QrisPaymentPage(totalBayar: totalHarga),
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
// class QrisPaymentPage extends StatelessWidget {
//   final int totalBayar;
//   const QrisPaymentPage({super.key, required this.totalBayar});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Pembayaran QRIS')),
//       body: Center(
//         child: Padding(
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
//               // Simulai Gambar QRIS
//               Container(
//                 width: 250,
//                 height: 250,
//                 color: Colors.white,
//                 child: Card(
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.qr_code_2,
//                           size: 140,
//                           color: Colors.black,
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'GPN - QRIS DUMMY',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey.shade700,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton.icon(
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
//               ),
//               const SizedBox(height: 40),

//               // Tombol Simulasi Pembayaran Sukses (Sebelum dihubungkan ke Webhook/Midtrans)
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   foregroundColor: Colors.white,
//                 ),
//                 onPressed: () {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const PaymentSuccessPage(),
//                     ),
//                     (route) => route.isFirst,
//                   );
//                 },
//                 child: const Text('Simulasi Bayar Berhasil (Webhook Dummy)'),
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
// class PaymentSuccessPage extends StatelessWidget {
//   const PaymentSuccessPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.check_circle, size: 100, color: Colors.green),
//               const SizedBox(height: 24),
//               const Text(
//                 'Pembayaran Berhasil!',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 12),
//               const Text(
//                 'Terima kasih! Pembayaran Anda telah kami terima. E-tiket dan instruksi kelas pelatihan telah dikirim ke Email pemesan.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Kembali ke Home (Daftar Pelatihan)
//                 },
//                 child: const Text('Kembali ke Halaman Utama'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
