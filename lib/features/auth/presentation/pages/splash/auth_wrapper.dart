import 'package:flutter/material.dart';
import 'package:safenesia_1/features/home/presentation/pages/navigation_bottom.dart';
import 'package:safenesia_1/features/auth/presentation/pages/login/login_page.dart';
import 'package:safenesia_1/features/auth/presentation/pages/splash/onboarding_page.dart';

// ==========================================
// 2. AUTH WRAPPER (Penentu Navigasi)
// ==========================================
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  // Simulasi state: Di aplikasi asli, cek SharedPreferences atau FirebaseAuth state di sini
  bool isFirstTime = true;
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    // Logika pengarah halaman
    if (isFirstTime) {
      return const OnboardingPage();
    } else if (isLoggedIn) {
      return const MainNavigationScreen();
    } else {
      return const LoginPage();
    }
  }
}
