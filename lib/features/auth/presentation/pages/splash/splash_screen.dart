import 'package:flutter/material.dart';
import 'package:safenesia_1/features/auth/presentation/pages/splash/auth_wrapper.dart';

import '../../../../../core/constants/constants.dart';

// ==========================================
// 1. SPLASH SCREEN
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulasi loading selama 2.5 detik, lalu pindah ke AuthWrapper
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthWrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(),
              Image.asset(AppAssets.logoVertical, width: 200, height: 200),
              AppSizes.gapH16,
              // const Icon(Icons.shield, size: 100, color: Colors.white),
              // const SizedBox(height: 16),
              // const Text(
              //   'SAFENESIA',
              //   style: TextStyle(
              //     fontSize: 32,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //     letterSpacing: 2,
              //   ),
              // ),
              // const SizedBox(height: 8),
              // Text(
              //   'Partner Keselamatan Kerja Anda',
              //   style: TextStyle(color: Colors.blue.shade100),
              // ),
              const Spacer(),
              _buildBottomSection(),
              AppSizes.gapH24, // Memberikan sedikit jarak dari dasar layar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
        AppSizes.gapH24,
        Text(
          'Hi, Safetizen!',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
