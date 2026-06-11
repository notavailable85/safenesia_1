import 'package:flutter/material.dart';

@immutable
class AppColors {
  const AppColors._(); // Private constructor untuk mencegah instansiasi

  // Primary & Secondary
  static const Color primary = Color(0xFF0288D1);
  static const Color primaryLight = Color(0xFFB3E5FC);
  static const Color primaryDark = Color(0xFF01579B);
  static const Color accent = Color(0xFF00B0FF);

  // Neutral Colors (Grayscale)
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0BEC5);

  // Semantic Colors (Feedback)
  static const Color success = Color(0xFF4CAF50);
  static const Color info = Color(0xFF2196F3);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFD32F2F);
}
