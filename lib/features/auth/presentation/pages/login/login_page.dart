
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/gestures.dart';
import 'package:local_auth/local_auth.dart';
import 'package:safenesia_1/features/home/presentation/pages/navigation_bottom.dart';
import 'package:safenesia_1/features/auth/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:safenesia_1/features/auth/presentation/pages/register/register_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/information/terms_conditions_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/information/privacy_policy_page.dart';
import 'package:safenesia_1/core/database/database_helper.dart';

import '../../../../../core/constants/constants.dart';

// ==========================================
// 4. LOGIN PAGE
// ==========================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  bool _isLoadingGoogle = false;
  bool _isBiometricEnabled = false;
  final LocalAuthentication _auth = LocalAuthentication();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkBiometricStatus();
  }

  Future<void> _checkBiometricStatus() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _isBiometricEnabled = prefs.getBool('is_biometric_enabled') ?? false;
      });
      if (_isBiometricEnabled) {
        _authenticateWithBiometrics();
      }
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Pindai sidik jari Anda untuk masuk',
        biometricOnly: true,
      );
      
      if (didAuthenticate) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('login_method', 'biometric');
        await prefs.setBool('is_logged_in', true);
        await prefs.setInt('last_active_time', DateTime.now().millisecondsSinceEpoch);
        
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => const MainNavigationScreen()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Gagal verifikasi sidik jari'),
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid_email':
        return 'Format email tidak valid';
      case 'user_not_found':
        return 'Akun tidak ditemukan';
      case 'wrong_password':
        return 'Password yang dimasukkan salah';
      case 'account_disabled':
        return 'Akun telah dinonaktifkan';
      case 'too_many_requests':
        return 'Terlalu banyak percobaan login. Coba lagi nanti';
      case 'network_error':
        return 'Koneksi internet bermasalah';
      case 'server_error':
        return 'Terjadi kesalahan server';
      case 'session_expired':
        return 'Sesi telah berakhir, silakan login kembali';
      case 'email_not_verified':
        return 'Email belum diverifikasi';
      case 'unauthorized':
        return 'Anda tidak memiliki akses';
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

  Future<void> _login() async {
    final identifier = _emailController.text.trim();
    final password = _passwordController.text;

    if (identifier.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Email dan password harus diisi'),
          backgroundColor: Colors.red.shade600,
        ),
      );
      return;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(identifier)) {
      _showError('invalid_email');
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    final user = await DatabaseHelper.instance.getUserByEmail(identifier);
    bool userFound = user != null;
    bool passwordCorrect = false;
    String? foundUserName;

    if (userFound) {
      if (user.password == password) {
        passwordCorrect = true;
        foundUserName = user.name;
      }
    }

    if (!userFound) {
      _showError('user_not_found');
      return;
    }

    if (!passwordCorrect) {
      _showError('wrong_password');
      return;
    }

    // Simpan data sesi ke SharedPreferences
    await prefs.setString('login_method', 'manual');
    await prefs.setString('user_name', foundUserName ?? 'Pengguna');
    await prefs.setString('user_email', identifier);
    await prefs.setBool('is_logged_in', true);
    await prefs.setInt(
      'last_active_time',
      DateTime.now().millisecondsSinceEpoch,
    );

    // Login berhasil
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (c) => const MainNavigationScreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 6),
                Image.asset(AppAssets.logoVertical, height: 200),
                SizedBox(height: 30),

                const SizedBox(height: 30),

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
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage(),
                      ),
                    ),
                    child: const Text('Lupa Password?'),
                  ),
                ),
                const SizedBox(height: 6),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _login,
                          child: const Text('Login', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                    if (_isBiometricEnabled) ...[
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _authenticateWithBiometrics,
                          child: const Icon(Icons.fingerprint),
                        ),
                      ),
                    ]
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'ATAU',
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),

                // Google Sign-In Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                      ),
                    ),
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
                                // Pengguna membatalkan proses login
                                if (context.mounted) {
                                  setState(() {
                                    _isLoadingGoogle = false;
                                  });
                                }
                                return;
                              }

                              // Simpan data sesi ke SharedPreferences
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('login_method', 'google');
                              await prefs.setString(
                                'user_name',
                                googleUser.displayName ?? 'Pengguna Google',
                              );
                              await prefs.setString(
                                'user_email',
                                googleUser.email,
                              );
                              await prefs.setBool('is_logged_in', true);
                              await prefs.setInt(
                                'last_active_time',
                                DateTime.now().millisecondsSinceEpoch,
                              );

                              if (context.mounted) {
                                setState(() {
                                  _isLoadingGoogle = false;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Login berhasil sebagai ${googleUser.displayName ?? googleUser.email}',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MainNavigationScreen(),
                                  ),
                                );
                              }
                            } catch (error) {
                              if (context.mounted) {
                                setState(() {
                                  _isLoadingGoogle = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Gagal login dengan Google: $error',
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
                      _isLoadingGoogle ? 'Memproses...' : 'Masuk dengan Google',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun?'),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      ),
                      child: const Text(
                        'Daftar Sekarang',
                        // style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'Dengan mendaftar atau masuk, Anda menyetujui ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      children: [
                        TextSpan(
                          text: 'Syarat & Ketentuan',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TermsConditionsPage(),
                                ),
                              );
                            },
                        ),
                        const TextSpan(text: ' dan '),
                        TextSpan(
                          text: 'Kebijakan Privasi',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicyPage(),
                                ),
                              );
                            },
                        ),
                        const TextSpan(text: ' kami.'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
