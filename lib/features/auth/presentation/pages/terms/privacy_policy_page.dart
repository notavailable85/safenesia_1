import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebijakan Privasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kebijakan Privasi Safenesia',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kami di Safenesia sangat menghargai privasi Anda. Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda:\n\n'
              '1. Pengumpulan Informasi\n'
              'Kami mengumpulkan informasi yang Anda berikan saat mendaftar, seperti nama, email, nomor telepon, dan data relevan lainnya yang dibutuhkan untuk pendaftaran pelatihan atau layanan K3.\n\n'
              '2. Penggunaan Informasi\n'
              'Data Anda digunakan untuk:\n'
              '- Memproses pendaftaran dan layanan Anda.\n'
              '- Memberikan informasi terbaru mengenai pelatihan atau karir.\n'
              '- Meningkatkan kualitas layanan aplikasi Safenesia.\n\n'
              '3. Keamanan Data\n'
              'Kami menggunakan langkah-langkah keamanan teknis yang wajar untuk melindungi data pribadi Anda dari akses yang tidak sah, perubahan, atau pengungkapan.\n\n'
              '4. Berbagi Informasi\n'
              'Kami tidak akan menjual atau menyewakan informasi pribadi Anda kepada pihak ketiga. Informasi hanya dapat dibagikan kepada penyelenggara pelatihan terkait yang Anda ikuti.\n\n'
              '5. Hak Anda\n'
              'Anda berhak untuk mengakses, memperbarui, atau meminta penghapusan data pribadi Anda dengan menghubungi layanan dukungan kami.\n\n'
              'Kebijakan ini dapat berubah sewaktu-waktu, dan Anda akan menerima pemberitahuan apabila terdapat perubahan material.',
              style: TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
