import 'package:flutter/material.dart';

// ==========================================
// 3. DETAIL PAGES
// ==========================================
Widget _buildDetailSection(String title, String content) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
      ],
    ),
  );
}

class DetailPelatihanPage extends StatelessWidget {
  final String title;
  const DetailPelatihanPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pelatihan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 200,
            color: Colors.blueGrey.shade100,
            child: const Icon(Icons.image, size: 80),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 32),
          _buildDetailSection(
            'Deskripsi',
            'Pelatihan komprehensif untuk mencetak tenaga ahli profesional di bidangnya.',
          ),
          _buildDetailSection(
            'Persyaratan',
            '1. Minimal D3/S1\n2. Pas Foto 3x4\n3. Surat Rekomendasi',
          ),
          _buildDetailSection(
            'Materi Pelatihan',
            '• Peraturan Perundangan\n• Dasar-dasar K3\n• Manajemen Risiko',
          ),
          _buildDetailSection(
            'Fasilitas',
            '• Modul Softcopy\n• Sertifikat\n• Kaos Safety',
          ),
          _buildDetailSection(
            'Info Pendaftaran',
            'Pendaftaran ditutup 3 hari sebelum kelas dimulai.',
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Daftar Sekarang'),
          ),
        ],
      ),
    );
  }
}

class DetailSertifikasiPage extends StatelessWidget {
  final String title;
  const DetailSertifikasiPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Sertifikasi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 200,
            color: Colors.green.shade100,
            child: const Icon(Icons.verified, size: 80),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 32),
          _buildDetailSection(
            'Deskripsi',
            'Sertifikasi untuk memastikan sistem manajemen perusahaan Anda sesuai standar.',
          ),
          _buildDetailSection(
            'Persyaratan',
            '1. Legalitas Perusahaan\n2. Manual Sistem Manajemen\n3. Bukti Implementasi',
          ),
          _buildDetailSection(
            'Tahapan',
            '1. Pendaftaran\n2. Audit Tahap 1\n3. Audit Tahap 2\n4. Penerbitan Sertifikat',
          ),
          _buildDetailSection(
            'Fasilitas',
            '• Sertifikat Resmi\n• Laporan Audit\n• Softcopy Logo',
          ),
          _buildDetailSection(
            'Info Pendaftaran',
            'Hubungi admin untuk penjadwalan Kick-off meeting.',
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Pesan Sertifikasi'),
          ),
        ],
      ),
    );
  }
}

class DetailRiksaUjiPage extends StatelessWidget {
  final String title;
  const DetailRiksaUjiPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Riksa Uji')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 200,
            color: Colors.orange.shade100,
            child: const Icon(Icons.precision_manufacturing, size: 80),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 32),
          _buildDetailSection(
            'Deskripsi',
            'Pengujian untuk memastikan kelayakan operasional dan keamanan alat kerja Anda.',
          ),
          _buildDetailSection(
            'Persyaratan',
            '1. Data Perusahaan\n2. Dokumen Teknis Alat\n3. Akses Lokasi Unit',
          ),
          _buildDetailSection(
            'Spesifikasi Alat',
            'Cakupan: Pemeriksaan Visual, Uji Tidak Merusak (NDT), Uji Beban.',
          ),
          _buildDetailSection(
            'Fasilitas',
            '• Suket Kemnaker\n• Plat Layak Operasi\n• Laporan Teknis',
          ),
          _buildDetailSection(
            'Info Pendaftaran',
            'Jadwal riksa uji disesuaikan dengan kesiapan lapangan.',
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Pesan Riksa Uji'),
          ),
        ],
      ),
    );
  }
}

class DetailPerpanjanganPage extends StatelessWidget {
  final String title;
  const DetailPerpanjanganPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Perpanjangan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 200,
            color: Colors.teal.shade100,
            child: const Icon(Icons.autorenew, size: 80),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 32),
          _buildDetailSection(
            'Deskripsi',
            'Perpanjangan masa berlaku dokumen legalitas kompetensi ahli.',
          ),
          _buildDetailSection(
            'Persyaratan',
            '1. SKP/Lisensi Asli Lama\n2. KTP & Pas Foto Terbaru\n3. Surat Laporan Kegiatan',
          ),
          _buildDetailSection(
            'Materi (Refreshment)',
            '• Update Regulasi\n• Studi Kasus Kecelakaan Kerja',
          ),
          _buildDetailSection(
            'Fasilitas',
            '• SKP/Lisensi Baru\n• Gratis Ongkir Pengiriman',
          ),
          _buildDetailSection(
            'Info Pendaftaran',
            'Maksimal H-30 sebelum expired.',
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
            child: const Text('Ajukan Perpanjangan'),
          ),
        ],
      ),
    );
  }
}
