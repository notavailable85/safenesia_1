import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool _isLoading = true;
  bool _isFirstTime = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    final prefs = await SharedPreferences.getInstance();

    // Check if it's the first time
    final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

    // Check login state
    final loggedIn = prefs.getBool('is_logged_in') ?? false;
    final lastActiveStr = prefs.getInt('last_active_time');

    bool activeSession = false;

    if (loggedIn && lastActiveStr != null) {
      final lastActiveTime = DateTime.fromMillisecondsSinceEpoch(lastActiveStr);
      final now = DateTime.now();
      final difference = now.difference(lastActiveTime).inDays;

      if (difference <= 15) {
        activeSession = true;
        // Update last active time to now
        await prefs.setInt('last_active_time', now.millisecondsSinceEpoch);
      } else {
        // Session expired (more than 15 days)
        await prefs.setBool('is_logged_in', false);
      }
    }

    if (mounted) {
      setState(() {
        _isFirstTime = !hasSeenOnboarding;
        _isLoggedIn = activeSession;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Logika pengarah halaman
    if (_isFirstTime) {
      return const OnboardingPage();
    } else if (_isLoggedIn) {
      return const MainNavigationScreen();
    } else {
      return const LoginPage();
    }
  }
}
