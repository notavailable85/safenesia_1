import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:safenesia_1/features/auth/presentation/pages/splash/auth_wrapper.dart';
import 'package:safenesia_1/features/profile/presentation/pages/activities/my_certificate_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/activities/my_document_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/activities/my_training_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/activities/my_transaction_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/information/about_us_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/information/support_center_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/information/terms_conditions_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/information/privacy_policy_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/profile_setting/edit_password_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/profile_setting/edit_profile_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/profile_setting/theme_setting_page.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safenesia_1/core/utils/user_state.dart';

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
  String? _userAvatarPath;
  final LocalAuthentication _auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    UserState.profileUpdatedNotifier.addListener(_loadUserData);
    _loadBiometricStatus();
  }

  Future<void> _loadBiometricStatus() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        isBiometricEnabled = prefs.getBool('is_biometric_enabled') ?? false;
      });
    }
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
                    onChanged: (val) async {
                      if (val) {
                        try {
                          final List<BiometricType> availableBiometrics = await _auth.getAvailableBiometrics();
                          
                          if (availableBiometrics.isEmpty) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Anda belum mendaftarkan sidik jari di pengaturan HP Anda.')),
                              );
                              setStateDialog(() => isBiometricEnabled = false);
                              setState(() => isBiometricEnabled = false);
                            }
                            return;
                          }

                          final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
                          final bool canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
                          
                          if (canAuthenticate) {
                            final bool didAuthenticate = await _auth.authenticate(
                              localizedReason: 'Pindai sidik jari Anda untuk mengaktifkan fitur ini',
                              biometricOnly: true,
                            );
                            
                            if (didAuthenticate) {
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('is_biometric_enabled', true);
                              setStateDialog(() => isBiometricEnabled = true);
                              setState(() => isBiometricEnabled = true);
                              
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login sidik jari berhasil diaktifkan')),
                                );
                              }
                            } else {
                              // User cancelled
                              setStateDialog(() => isBiometricEnabled = false);
                              setState(() => isBiometricEnabled = false);
                            }
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Perangkat tidak mendukung sidik jari')),
                              );
                              setStateDialog(() => isBiometricEnabled = false);
                              setState(() => isBiometricEnabled = false);
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Anda belum mendaftarkan sidik jari / kunci layar.')),
                            );
                            setStateDialog(() => isBiometricEnabled = false);
                            setState(() => isBiometricEnabled = false);
                          }
                        }
                      } else {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('is_biometric_enabled', false);
                        setStateDialog(() => isBiometricEnabled = false);
                        setState(() => isBiometricEnabled = false);
                      }
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

  Future<void> _clearCache() async {
    try {
      // 1. Clear Image Cache
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();
      
      // 2. Clear Temporary Directory (Cache)
      final tempDir = await getTemporaryDirectory();
      if (tempDir.existsSync()) {
        final List<FileSystemEntity> children = tempDir.listSync();
        for (final FileSystemEntity child in children) {
          try {
            // Jangan hapus foto profil pengguna jika tersimpan di cache
            if (_userAvatarPath != null && _userAvatarPath!.startsWith(child.path)) {
              continue;
            }
            child.deleteSync(recursive: true);
          } catch (_) {
            // Ignore if a specific file/dir cannot be deleted
          }
        }
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cache berhasil dibersihkan'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membersihkan cache: $e'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
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
              backgroundImage: _userAvatarPath != null && File(_userAvatarPath!).existsSync()
                  ? FileImage(File(_userAvatarPath!))
                  : null,
              child: _userAvatarPath == null || !File(_userAvatarPath!).existsSync()
                  ? Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
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
      ),
      body: ListTileTheme(
        data: ListTileThemeData(
          iconColor: Theme.of(context).colorScheme.primary,
          titleTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        child: ListView(
        padding: const EdgeInsets.only(
          left: 16,
          top: 16,
          right: 16,
          bottom: 100,
        ),
        children: [
          // KONTAINER 1
          const Text(
            'Aktivitas Saya',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
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
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fitur ini sedang dalam tahap pengembangan'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
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
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fitur ini sedang dalam tahap pengembangan'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // KONTAINER 2
          const Text(
            'Pengaturan Akun',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
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
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const EditProfilePage(),
                      ),
                    );
                    _loadUserData(); // Reload after editing
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.color_lens),
                  title: const Text('Tema Aplikasi'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const ThemeSettingPage(),
                      ),
                    );
                  },
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
                  onTap: _clearCache,
                ),
              ],
            ),
          ),

          // KONTAINER 3
          const Text(
            'Informasi Umum',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
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
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Syarat dan Ketentuan'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const TermsConditionsPage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('Kebijakan Privasi'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const PrivacyPolicyPage()),
                  ),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.android),
                  title: Text('Versi Aplikasi'),
                  trailing: Text(
                    'v1.0.0+2',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          // KONTAINER ADMIN
          const Text(
            'Admin',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Card(
            color: Theme.of(context).colorScheme.primary,
            margin: const EdgeInsets.only(top: 8, bottom: 32),
            child: ListTile(
              leading: const Icon(
                Icons.admin_panel_settings,
                color: Colors.white,
              ),
              title: const Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => const AdminDashboardPage()),
              ),
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
              'Keluar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('is_logged_in', false);

              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (c) => const AuthWrapper()),
                  (route) => false,
                );
              }
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
      ),
    );
  }
}
