// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; // Pastikan package ini sudah di-install

// class AppTheme {
//   // 1. Definisikan Palet Warna Utama Anda
//   static const Color primaryColor = Color(0xFF00BFA5); // Biru Utama
//   static const Color secondaryColor = Color(0xFF1565C0); // Teal / Aksen
//   static const Color backgroundColor = Color(
//     0xFFF5F7FA,
//   ); // Abu-abu kebiruan terang
//   static const Color surfaceColor = Colors.white; // Putih untuk Card/Container
//   static const Color textPrimaryColor = Color(
//     0xFF2C3E50,
//   ); // Biru gelap untuk teks
//   static const Color textSecondaryColor = Color(
//     0xFF7F8C8D,
//   ); // Abu-abu untuk teks pendukung

//   // 2. Konfigurasi Tema Terang (Light Theme) Lengkap
//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true, // Wajib true untuk desain modern Flutter
//       scaffoldBackgroundColor: backgroundColor,
//       primaryColor: primaryColor,

//       // -- Skema Warna Global --
//       colorScheme: const ColorScheme.light(
//         primary: primaryColor,
//         secondary: secondaryColor,
//         surface: surfaceColor,
//         error: Colors.redAccent,
//         onPrimary: Colors.white, // Warna teks/icon di atas warna primary
//         onSecondary: Colors.white,
//         onSurface: textPrimaryColor,
//       ),

//       // -- Konfigurasi Global Font & Text --
//       // Jika menggunakan Google Fonts (misal: Poppins)
//       textTheme: GoogleFonts.poppinsTextTheme().copyWith(
//         displayLarge: const TextStyle(
//           color: textPrimaryColor,
//           fontWeight: FontWeight.bold,
//         ),
//         titleLarge: const TextStyle(
//           color: textPrimaryColor,
//           fontSize: 20,
//           fontWeight: FontWeight.w600,
//         ),
//         bodyLarge: const TextStyle(color: textPrimaryColor, fontSize: 16),
//         bodyMedium: const TextStyle(color: textSecondaryColor, fontSize: 14),
//       ),

//       // -- Konfigurasi AppBar --
//       appBarTheme: AppBarTheme(
//         backgroundColor: primaryColor,
//         foregroundColor: Colors.white, // Warna teks & icon di AppBar
//         elevation: 0,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//         titleTextStyle: GoogleFonts.inter(
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//           color: Colors.white,
//         ),
//       ),

//       // -- Konfigurasi Card --
//       cardTheme: CardThemeData(
//         color: Colors.white,
//         elevation: 2,
//         shadowColor: const Color(0x1A000000),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12), // Sudut membulat
//         ),
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       ),

//       // -- Konfigurasi Tombol (ElevatedButton) --
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: primaryColor,
//           foregroundColor: Colors.white, // Warna teks tombol
//           elevation: 0,
//           padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
//           textStyle: GoogleFonts.inter(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//       ),

//       // -- Konfigurasi Tombol Garis (OutlinedButton) --
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: primaryColor,
//           side: const BorderSide(color: primaryColor, width: 1.5),
//           padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
//           textStyle: GoogleFonts.inter(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//       ),

//       // -- Konfigurasi Input / TextField --
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 16,
//           horizontal: 16,
//         ),
//         labelStyle: const TextStyle(color: textSecondaryColor),
//         hintStyle: const TextStyle(color: textSecondaryColor),
//         // Border saat normal
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
//         ),
//         // Border saat sedang diketik (fokus)
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: primaryColor, width: 2),
//         ),
//         // Border saat ada error/validasi gagal
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.redAccent, width: 1),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.redAccent, width: 2),
//         ),
//       ),

//       // -- Konfigurasi Ikon --
//       iconTheme: const IconThemeData(color: primaryColor, size: 24),

//       // -- Konfigurasi Divider (Garis Pemisah) --
//       dividerTheme: DividerThemeData(
//         color: Colors.grey.shade300,
//         thickness: 1,
//         space: 1,
//       ),
//     );
//   }
// }
