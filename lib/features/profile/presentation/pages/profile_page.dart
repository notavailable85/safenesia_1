import 'package:flutter/material.dart';
import 'package:safenesia_1/features/profile/presentation/pages/activities/my_certificate_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/activities/my_document_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/activities/my_training_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/activities/my_transaction_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/information/about_us_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/information/support_center_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/profile_setting/edit_password_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/profile_setting/edit_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ==========================================
// 1. HALAMAN UTAMA AKUN
// ==========================================
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isBiometricEnabled = false;
  String _userName = 'Pengguna';
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _userName = prefs.getString('user_name') ?? 'Pengguna';
        _userEmail = prefs.getString('user_email') ?? '';
      });
    }
  }

  void _showBiometricDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Login Sidik Jari'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Gunakan Sidik Jari'),
                  Switch(
                    value: isBiometricEnabled,
                    onChanged: (val) {
                      setStateDialog(() => isBiometricEnabled = val);
                      setState(
                        () => isBiometricEnabled = val,
                      ); // Update parent state
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ],
            );
          },
        );
      },
    );
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
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  _userEmail,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // KONTAINER 1
          const Text(
            'Aktivitas Saya',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Card(
            margin: const EdgeInsets.only(top: 8, bottom: 24),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('History Transaksi'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const HistoryTransactionPage(),
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('Pelatihan yang Saya Ikuti'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const MyTrainingPage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.folder),
                  title: const Text('Dokumen Saya'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const MyDocumentsPage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.workspace_premium),
                  title: const Text('E-Certificate'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const ECertificatePage()),
                  ),
                ),
              ],
            ),
          ),

          // KONTAINER 2
          const Text(
            'Pengaturan Akun',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Card(
            margin: const EdgeInsets.only(top: 8, bottom: 24),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Edit Password'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const EditPasswordPage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit Profil'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const EditProfilePage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.fingerprint),
                  title: const Text('Login Sidik Jari'),
                  trailing: Text(
                    isBiometricEnabled ? 'Aktif' : 'Nonaktif',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  onTap: _showBiometricDialog,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.cleaning_services),
                  title: const Text('Bersihkan Cache'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cache berhasil dibersihkan'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // KONTAINER 3
          const Text(
            'Informasi Umum',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Card(
            margin: const EdgeInsets.only(top: 8, bottom: 32),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Tentang Kami'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const AboutUsPage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Pusat Bantuan'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const HelpCenterPage()),
                  ),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.android),
                  title: Text('Versi Aplikasi'),
                  trailing: Text(
                    'v1.0.0',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          // TOMBOL LOGOUT
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red,
              padding: const EdgeInsets.all(16),
            ),
            icon: const Icon(Icons.logout),
            label: const Text(
              'Keluar (Logout)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onPressed: () {
              // Aksi Logout
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
