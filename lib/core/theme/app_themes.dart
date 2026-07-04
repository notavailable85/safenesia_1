import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// Import konstanta yang sudah dibuat sebelumnya
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

@immutable
class AppThemes {
  const AppThemes._(); // Private constructor

  // Fungsi utilitas untuk memanipulasi warna dinamis
  static Color _lighten(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
  }

  static Color _darken(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }

  // ==========================================
  // LIGHT THEME (TEMA TERANG)
  // ==========================================
  static ThemeData getLightTheme(Color customPrimary) {
    // Menghasilkan warna state
    final hoverColor = _lighten(customPrimary, 0.08);
    final pressedColor = _darken(customPrimary, 0.12);
    final disabledColor = Colors.grey.shade300;
    final disabledTextColor = Colors.grey.shade500;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: customPrimary,
      fontFamily: GoogleFonts.inter().fontFamily,
      scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      colorScheme: ColorScheme.light(
        primary: customPrimary,
        secondary: AppColors.accent,
        error: AppColors.error,
        surface: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),

      // Pengaturan AppBar Global (Minimalis)
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: customPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        toolbarHeight: 68,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      
      // Card Theme (Minimalis)
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),

      // Divider Theme (Minimalis)
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade100,
        thickness: 1,
        space: 1,
      ),

      // Pengaturan Tombol Global (ElevatedButton)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) return disabledColor;
            if (states.contains(MaterialState.pressed)) return pressedColor;
            if (states.contains(MaterialState.hovered)) return hoverColor;
            return customPrimary; // Normal
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) return disabledTextColor;
            return Colors.white;
          }),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: AppSizes.md, horizontal: AppSizes.lg),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      // Segmented Button Theme
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.selected)) {
              return customPrimary;
            }
            return null;
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            }
            return null;
          }),
        ),
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: customPrimary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 24),
        unselectedIconTheme: const IconThemeData(color: Colors.white70, size: 24),
        selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
        unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.white70),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: customPrimary,
        foregroundColor: Colors.white,
        hoverColor: hoverColor,
        splashColor: pressedColor,
        focusColor: hoverColor,
        elevation: 4,
        hoverElevation: 6,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Pengaturan TextField Global (Minimalis)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: customPrimary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
    );
  }

  // ==========================================
  // DARK THEME (TEMA GELAP)
  // ==========================================
  static ThemeData getDarkTheme(Color customPrimary) {
    // Menghasilkan warna state untuk Dark Mode
    final hoverColor = _lighten(customPrimary, 0.08);
    final pressedColor = _darken(customPrimary, 0.12);
    final disabledColor = Colors.grey.shade800;
    final disabledTextColor = Colors.grey.shade500;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: customPrimary,
      fontFamily: GoogleFonts.inter().fontFamily,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: ColorScheme.dark(
        primary: customPrimary,
        secondary: AppColors.accent,
        error: AppColors.error,
        surface: AppColors.surfaceDark,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),

      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: customPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        toolbarHeight: 68, // Menyamakan tinggi dengan Bottom Navbar
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade800, width: 1),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: Colors.grey.shade800,
        thickness: 1,
        space: 1,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) return disabledColor;
            if (states.contains(MaterialState.pressed)) return pressedColor;
            if (states.contains(MaterialState.hovered)) return hoverColor;
            return customPrimary;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) return disabledTextColor;
            return Colors.white;
          }),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: AppSizes.md, horizontal: AppSizes.lg),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          textStyle: MaterialStateProperty.all(
            GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.selected)) {
              return customPrimary;
            }
            return null;
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            }
            return Colors.white; // Unselected is white in dark mode
          }),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: customPrimary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 24),
        unselectedIconTheme: const IconThemeData(color: Colors.white70, size: 24),
        selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
        unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.white70),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: customPrimary,
        foregroundColor: Colors.white,
        hoverColor: hoverColor,
        splashColor: pressedColor,
        focusColor: hoverColor,
        elevation: 4,
        hoverElevation: 6,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: customPrimary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
    );
  }
}
