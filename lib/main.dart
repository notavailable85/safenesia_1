import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safenesia_1/core/theme/app_themes.dart' show AppThemes;
import 'package:safenesia_1/core/theme/theme_notifier.dart';
import 'package:safenesia_1/features/auth/presentation/pages/splash/splash_screen.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_list_page.dart';
import 'package:safenesia_1/features/home/presentation/pages/home_page.dart';
import 'package:safenesia_1/features/home/presentation/pages/navigation_bottom.dart';
import 'package:safenesia_1/features/training/presentation/pages/training_list_page.dart';

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
              home: const MainNavigationScreen(),
            );
          },
        );
      },
    );
  }
}
