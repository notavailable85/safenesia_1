import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safenesia_1/core/theme/app_themes.dart' show AppThemes;
import 'package:safenesia_1/core/theme/theme_notifier.dart';
import 'package:safenesia_1/features/auth/presentation/pages/splash/splash_screen.dart';
import 'package:safenesia_1/core/database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved theme color
  final prefs = await SharedPreferences.getInstance();
  final savedColor = prefs.getInt('app_theme_color');
  if (savedColor != null) {
    appThemeNotifier.value = Color(savedColor);
  }

  final savedModeIndex = prefs.getInt('app_theme_mode');
  if (savedModeIndex != null) {
    appThemeModeNotifier.value = ThemeMode.values[savedModeIndex];
  }

  // Pastikan database dan dummy data selesai di-seed sebelum UI dirender
  // Ini memperbaiki bug dimana tab Pelatihan K3 di IndexedStack kosong saat pertama kali dibuka.
  await DatabaseHelper.instance.database;

  runApp(const SafenesiaApp());
}

class SafenesiaApp extends StatelessWidget {
  const SafenesiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: appThemeNotifier,
      builder: (context, primaryColor, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: appThemeModeNotifier,
          builder: (context, themeMode, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Safenesia App',
              theme: AppThemes.getLightTheme(primaryColor),
              darkTheme: AppThemes.getDarkTheme(primaryColor),
              themeMode: themeMode,
              home: const SplashScreen(),
              //cek
            );
          },
        );
      },
    );
  }
}
