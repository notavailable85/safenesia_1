import 'package:flutter/material.dart';
import 'package:safenesia_1/core/theme/app_themes.dart' show AppThemes;
import 'package:safenesia_1/features/auth/presentation/pages/splash/splash_screen.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_list_page.dart';
import 'package:safenesia_1/features/home/presentation/pages/home_page.dart';
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
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      //   colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      //   useMaterial3: true,
      //   brightness: Brightness.light,
      //   scaffoldBackgroundColor: const Color(0xffF7F9FC),
      //   fontFamily: GoogleFonts.poppins().fontFamily,
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: AppColors.primary,
      //
      //     titleTextStyle: GoogleFonts.poppins(
      //       fontSize: 16,
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      home: const HomePage(),
    );
  }
}
