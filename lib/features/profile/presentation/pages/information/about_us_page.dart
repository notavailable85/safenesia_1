import 'package:flutter/material.dart';

// ==========================================
// SUB-HALAMAN KONTAINER 3
// ==========================================

// 3.A. TENTANG KAMI
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Kami')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Aplikasi Keselamatan Kerja',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Kami menyediakan layanan pelatihan, sertifikasi, dan riksa uji terbaik di Indonesia untuk memastikan kepatuhan standar industri Anda.',
          ),
          Divider(height: 40),
          Text(
            'Layanan Kami',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Pelatihan Ahli K3'),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Sertifikasi ISO & SMK3'),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Riksa Uji Alat Berat'),
          ),
          Divider(height: 40),
          Text(
            'Kontak Kami',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('support@aplikasik3.com'),
          ),
          ListTile(leading: Icon(Icons.phone), title: Text('021-12345678')),
        ],
      ),
    );
  }
}
