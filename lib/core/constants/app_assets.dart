import 'package:flutter/material.dart';

@immutable
class AppAssets {
  const AppAssets._();

  // Base Paths
  static const String _imagePath = 'assets/images';
  static const String _iconPath = 'assets/icons';
  static const String _lottiePath = 'assets/lottie';

  // Images
  static const String logoHorizontal =
      '$_imagePath/logo_safenesia_horizontal.png';
  static const String logoVertical = '$_imagePath/logo_safenesia_vertical.png';
  static const String onboarding1 = '$_imagePath/onboarding_welcome.png';
  static const String placeholder = '$_imagePath/placeholder.jpg';

  // Icons (SVG atau PNG khusus)
  static const String iconSafenesia = '$_iconPath/icon_safenesia.svg';
  static const String iconGoogle = '$_iconPath/icon_google.svg';
  static const String iconFacebook = '$_iconPath/icon_facebook.svg';
  static const String iconTwitter = '$_iconPath/icon_twitter.svg';
  static const String iconInstagram = '$_iconPath/icon_instagram.svg';
  static const String iconYoutube = '$_iconPath/icon_youtube.svg';
  static const String iconLinkedin = '$_iconPath/icon_linkedin.svg';
  static const String iconGithub = '$_iconPath/icon_github.svg';
  static const String iconVerified = '$_iconPath/verified_check.svg';
  static const String iconTiktok = '$_iconPath/icon_tiktok.svg';
  static const String iconApple = '$_iconPath/icon_apple.svg';
  static const String iconEmail = '$_iconPath/icon_email.svg';

  // Animations (Lottie)
  static const String lottieLoadingDotColors =
      '$_lottiePath/loading_dot_colors.json';
  static const String lottieHiWeCouple = '$_lottiePath/hi_we_couple.json';
  static const String lottieOnboarding1 =
      '$_lottiePath/onboarding_training.json';
  static const String lottieOnboarding2 =
      '$_lottiePath/onboarding_certification.json';
  static const String lottieOnboarding3 =
      '$_lottiePath/onboarding_inspection.json';
  static const String lottieOnboarding4 =
      '$_lottiePath/onboarding_renewal.json';
}
