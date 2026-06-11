import 'package:flutter/material.dart';

@immutable
class AppStrings {
  const AppStrings._();

  // App General Strings (Gunakan localization jika mendukung multi-bahasa)
  static const String appName = 'Safenesia';
  static const String welcomeTitle = 'Selamat Datang di Safenesia';
  static const String errorGeneric =
      'Terjadi kesalahan, silakan coba lagi nanti.';

  // API Endpoints
  static const String baseUrl = 'https://api.safenesia.com/v1';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';

  // Local Storage Keys
  static const String keyToken = 'cached_auth_token';
  static const String keyIsFirstRun = 'is_first_time_launch';
  static const String keyThemeMode = 'app_theme_mode';
}
