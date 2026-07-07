import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

// Global ValueNotifier untuk menyimpan state warna utama (primary) aplikasi.
final ValueNotifier<Color> appThemeNotifier = ValueNotifier<Color>(
  AppColors.primary,
);

// Global ValueNotifier untuk menyimpan state mode tema (light, dark, system).
final ValueNotifier<ThemeMode> appThemeModeNotifier = ValueNotifier<ThemeMode>(
  ThemeMode.system,
);
