import 'package:flutter/material.dart';
import 'package:safenesia_1/core/theme/app_themes.dart' show AppThemes;
import 'package:safenesia_1/features/auth/presentation/pages/splash/splash_screen.dart';
import 'package:safenesia_1/features/training/presentation/pages/training_list_page.dart';

void main() {
  runApp(const SafenesiaApp());
}

class SafenesiaApp extends StatelessWidget {
  const SafenesiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safenesia App',
      theme: AppThemes.lightTheme,
      //   colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      //   useMaterial3: true,
      //   brightness: Brightness.light,
      //   scaffoldBackgroundColor: const Color(0xffF7F9FC),
      //   fontFamily: GoogleFonts.poppins().fontFamily,
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: AppColors.primary,
      //     foregroundColor: Colors.white,
      //     titleTextStyle: GoogleFonts.poppins(
      //       fontSize: 16,
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      home: const TrainingListPage(),
    );
  }
}
