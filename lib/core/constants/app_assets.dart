import 'package:flutter/material.dart';

@immutable
class AppAssets {
  const AppAssets._();

  // Base Paths
  static const String _imagePath = 'assets/images';
  static const String _iconPath = 'assets/icons';
  static const String _lottiePath = 'assets/lottie';

  // Images
  static const String logo = '$_imagePath/app_logo.png';
  static const String onboarding1 = '$_imagePath/onboarding_welcome.png';
  static const String placeholder = '$_imagePath/placeholder.jpg';

  // Icons (SVG atau PNG khusus)
  static const String icGoogle = '$_iconPath/google_logo.svg';
  static const String icVerified = '$_iconPath/verified_check.svg';

  // Animations (Lottie)
  static const String loadingAnimation = '$_lottiePath/loading.json';
  static const String successAnimation = '$_lottiePath/success.json';
}
