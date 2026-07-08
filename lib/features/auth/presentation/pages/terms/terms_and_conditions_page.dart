import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syarat & Ketentuan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Syarat & Ketentuan Safenesia',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Selamat datang di aplikasi Safenesia. Dengan mengunduh, menginstal, atau menggunakan aplikasi ini, Anda menyetujui syarat dan ketentuan berikut:\n\n'
              '1. Penggunaan Aplikasi\n'
              'Aplikasi Safenesia ditujukan untuk membantu Anda dalam mengakses layanan pelatihan, sertifikasi, dan informasi terkait K3 (Keselamatan dan Kesehatan Kerja). Anda setuju untuk menggunakan aplikasi ini sesuai dengan hukum yang berlaku di Indonesia.\n\n'
              '2. Akun Pengguna\n'
              'Anda bertanggung jawab atas kerahasiaan informasi akun dan password Anda. Setiap aktivitas yang terjadi menggunakan akun Anda adalah tanggung jawab Anda sepenuhnya.\n\n'
              '3. Layanan dan Transaksi\n'
              'Setiap transaksi atau pendaftaran pelatihan yang dilakukan melalui aplikasi ini bersifat final sesuai dengan ketentuan masing-masing penyelenggara atau layanan.\n\n'
              '4. Hak Kekayaan Intelektual\n'
              'Semua konten, logo, dan materi dalam aplikasi Safenesia dilindungi oleh hak cipta dan dilarang untuk disalin, direproduksi, atau didistribusikan tanpa izin tertulis dari Safenesia.\n\n'
              '5. Perubahan Syarat\n'
              'Safenesia berhak memperbarui Syarat dan Ketentuan ini sewaktu-waktu. Kami akan memberitahukan pembaruan tersebut melalui aplikasi.\n\n'
              'Jika Anda memiliki pertanyaan lebih lanjut, silakan hubungi layanan pelanggan kami.',
              style: TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
