import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

@immutable
class AppAppBarTheme {
  const AppAppBarTheme._();

  // ==========================================
  // LIGHT APP BAR THEME
  // ==========================================
  static const AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0, // Menghilangkan bayangan di bawah AppBar
    scrolledUnderElevation:
        0, // Mencegah perubahan warna saat di-scroll di Material 3
    centerTitle: true,
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white, // Mengatur warna teks dan ikon utama
    iconTheme: IconThemeData(color: Colors.white, size: 24.0),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24.0),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  // ==========================================
  // DARK APP BAR THEME
  // ==========================================
  static const AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: AppColors.surfaceDark,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white, size: 24.0),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24.0),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );
}
