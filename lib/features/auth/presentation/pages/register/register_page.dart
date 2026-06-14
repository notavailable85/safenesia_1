import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safenesia_1/core/constants/app_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safenesia_1/features/auth/presentation/pages/register/verify_email_page.dart';
import 'package:safenesia_1/features/auth/presentation/pages/login/dummy_home_page.dart';

// ==========================================
// 5. REGISTER PAGE
// ==========================================
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoadingGoogle = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email_already_in_use':
        return 'Email sudah terdaftar';
      case 'invalid_email':
        return 'Format email tidak valid';
      case 'weak_password':
        return 'Password terlalu lemah';
      case 'password_not_match':
        return 'Konfirmasi password tidak sesuai';
      case 'username_taken':
        return 'Username sudah digunakan';
      case 'phone_already_used':
        return 'Nomor telepon sudah terdaftar';
      case 'required_field':
        return 'Semua kolom wajib diisi';
      case 'network_error':
        return 'Koneksi internet bermasalah';
      case 'server_error':
        return 'Gagal membuat akun';
      default:
        return 'Terjadi kesalahan yang tidak diketahui';
    }
  }

  void _showError(String errorCode) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_getErrorMessage(errorCode)),
        backgroundColor: Colors.red.shade600,
      ),
    );
  }

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showError('required_field');
      return;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      _showError('invalid_email');
      return;
    }

    if (password.length < 8) {
      _showError('weak_password');
      return;
    }

    if (password != confirmPassword) {
      _showError('password_not_match');
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    final existingUsersStr = prefs.getString('registered_users');
    List<dynamic> registeredUsers = [];
    if (existingUsersStr != null) {
      registeredUsers = jsonDecode(existingUsersStr);
      for (var user in registeredUsers) {
        if (user['email'] == email) {
          _showError('email_already_in_use');
          return;
        }
      }
    }

    registeredUsers.add({'name': name, 'email': email, 'password': password});

    await prefs.setString('registered_users', jsonEncode(registeredUsers));

    // Tetap simpan untuk kompatibilitas login_page lama
    await prefs.setString('registered_email', email);
    await prefs.setString('registered_password', password);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const VerifyEmailPage()),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            // child: Image.asset(AppAssets.logoVertical, height: 40),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buat Akun Baru',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Lengkapi form di bawah ini untuk mendaftar',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 32),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Konfirmasi Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                ),
                onPressed: _register,
                child: const Text('Daftar', style: TextStyle(fontSize: 16)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text('ATAU', style: TextStyle(color: Colors.grey)),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: _isLoadingGoogle
                    ? null
                    : () async {
                        setState(() {
                          _isLoadingGoogle = true;
                        });

                        try {
                          final GoogleSignIn googleSignIn = GoogleSignIn();
                          final GoogleSignInAccount? googleUser =
                              await googleSignIn.signIn();

                          if (googleUser == null) {
                            if (mounted) {
                              setState(() {
                                _isLoadingGoogle = false;
                              });
                            }
                            return;
                          }

                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('login_method', 'google');
                          await prefs.setString(
                            'user_name',
                            googleUser.displayName ?? 'Pengguna Google',
                          );
                          await prefs.setString('user_email', googleUser.email);

                          if (mounted) {
                            setState(() {
                              _isLoadingGoogle = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Daftar dan login berhasil sebagai ${googleUser.displayName ?? googleUser.email}',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DummyHomePage(),
                              ),
                            );
                          }
                        } catch (error) {
                          if (mounted) {
                            setState(() {
                              _isLoadingGoogle = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Gagal mendaftar dengan Google: $error',
                                ),
                                backgroundColor: Colors.red.shade600,
                              ),
                            );
                          }
                        }
                      },
                icon: _isLoadingGoogle
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : SvgPicture.asset(AppAssets.iconGoogle, height: 24),
                label: Text(
                  _isLoadingGoogle ? 'Memproses...' : 'Daftar dengan Google',
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sudah punya akun?'),
                TextButton(
                  onPressed: () => Navigator.pop(context), // Kembali ke Login
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
