import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/auth/presentation/pages/splash/auth_wrapper.dart';
import 'package:lottie/lottie.dart';
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
    Future.delayed(const Duration(milliseconds: 2500), () {
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
      backgroundColor: AppColors.backgroundLight,
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
        Lottie.asset(AppAssets.lottieHiWeCouple, width: 150),
        AppSizes.gapH16,
        Text(
          'Hi, Safetizen!',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: AppColors.primaryDark,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
