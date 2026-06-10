import 'package:flutter/material.dart';

// ==========================================
// 2. SEARCH & NOTIFICATION PAGE
// ==========================================
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.warning, color: Colors.red),
            title: Text('Sertifikat Berakhir'),
            subtitle: Text(
              'Sertifikat Ahli K3 Umum Anda akan kadaluarsa dalam 30 hari.',
            ),
          ),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.green),
            title: Text('Transaksi Berhasil'),
            subtitle: Text('Pembayaran Riksa Uji Crane telah diverifikasi.'),
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.blue),
            title: Text('Update Aplikasi'),
            subtitle: Text(
              'Versi terbaru Safenesia kini tersedia dengan fitur baru!',
            ),
          ),
        ],
      ),
    );
  }
}
