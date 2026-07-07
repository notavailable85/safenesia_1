import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:safenesia_1/core/constants/constants.dart';
import 'package:safenesia_1/features/auth/presentation/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ==========================================
// 3. ONBOARDING PAGE (4 Bagian)
// ==========================================
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "PELATIHAN K3",
      "desc":
          "Tingkatkan kompetensi Anda dengan berbagai program pelatihan K3 bersertifikasi Kemnaker dan BNSP.",
      "icon": AppAssets.lottieOnboarding1,
    },
    {
      "title": "SERTIFIKASI ISO & SMK3",
      "desc":
          "Bantu perusahaan Anda memenuhi standar mutu dan keselamatan kerja nasional maupun internasional.",
      "icon": AppAssets.lottieOnboarding2,
    },
    {
      "title": "RIKSA UJI ALAT",
      "desc":
          "Pastikan kelayakan dan keamanan alat kerja berat Anda melalui proses riksa uji yang kredibel.",
      "icon": AppAssets.lottieOnboarding3,
    },
    {
      "title": "RESERTIFIKASI",
      "desc":
          "Urus perpanjangan lisensi K3 Anda dengan cepat dan mudah tanpa ribet administrasi.",
      "icon": AppAssets.lottieOnboarding4,
    },
  ];

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'school':
        return Icons.school;
      case 'verified':
        return Icons.verified;
      case 'precision_manufacturing':
        return Icons.precision_manufacturing;
      case 'autorenew':
        return Icons.autorenew;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('has_seen_onboarding', true);
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Lewati',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        onboardingData[index]["icon"]!.endsWith('.json')
                            ? Lottie.asset(
                                onboardingData[index]["icon"]!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  debugPrint('Lottie Error: $error');
                                  return const Icon(
                                    Icons.image_not_supported,
                                    size: 150,
                                    color: Colors.grey,
                                  );
                                },
                              )
                            : Icon(
                                _getIcon(onboardingData[index]["icon"]!),
                                size: 150,
                                color: Colors.blue.shade800,
                              ),
                        const SizedBox(height: 40),
                        Text(
                          onboardingData[index]["title"]!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          onboardingData[index]["desc"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondaryLight,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index, context),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (_currentPage == onboardingData.length - 1) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('has_seen_onboarding', true);
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    _currentPage == onboardingData.length - 1
                        ? "Mulai Sekarang"
                        : "Selanjutnya",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _currentPage == index
            ? Colors.blue.shade800
            : Colors.grey.shade300,
      ),
    );
  }
}

// data sebelum diubah ke lottie
// import 'package:flutter/material.dart';
// import 'package:safenesia_1/features/auth/presentation/pages/login/login_page.dart';

// // ==========================================
// // 3. ONBOARDING PAGE (4 Bagian)
// // ==========================================
// class OnboardingPage extends StatefulWidget {
//   const OnboardingPage({super.key});

//   @override
//   State<OnboardingPage> createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<OnboardingPage> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   final List<Map<String, String>> onboardingData = [
//     {
//       "title": "Pelatihan K3",
//       "desc":
//           "Tingkatkan kompetensi Anda dengan berbagai program pelatihan K3 bersertifikasi Kemnaker dan BNSP.",
//       "icon": "school",
//     },
//     {
//       "title": "Sertifikasi ISO & SMK3",
//       "desc":
//           "Bantu perusahaan Anda memenuhi standar mutu dan keselamatan kerja nasional maupun internasional.",
//       "icon": "verified",
//     },
//     {
//       "title": "Riksa Uji Alat",
//       "desc":
//           "Pastikan kelayakan dan keamanan alat kerja berat Anda melalui proses riksa uji yang kredibel.",
//       "icon": "precision_manufacturing",
//     },
//     {
//       "title": "Resertifikasi",
//       "desc":
//           "Urus perpanjangan lisensi K3 Anda dengan cepat dan mudah tanpa ribet administrasi.",
//       "icon": "autorenew",
//     },
//   ];

//   IconData _getIcon(String iconName) {
//     switch (iconName) {
//       case 'school':
//         return Icons.school;
//       case 'verified':
//         return Icons.verified;
//       case 'precision_manufacturing':
//         return Icons.precision_manufacturing;
//       case 'autorenew':
//         return Icons.autorenew;
//       default:
//         return Icons.info;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: TextButton(
//                 onPressed: () => Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginPage()),
//                 ),
//                 child: const Text(
//                   'Lewati',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: PageView.builder(
//                 controller: _pageController,
//                 onPageChanged: (value) => setState(() => _currentPage = value),
//                 itemCount: onboardingData.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(40.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           _getIcon(onboardingData[index]["icon"]!),
//                           size: 120,
//                           color: Colors.blue.shade800,
//                         ),
//                         const SizedBox(height: 40),
//                         Text(
//                           onboardingData[index]["title"]!,
//                           style: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           onboardingData[index]["desc"]!,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 onboardingData.length,
//                 (index) => buildDot(index, context),
//               ),
//             ),
//             const SizedBox(height: 40),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 40),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue.shade800,
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () {
//                     if (_currentPage == onboardingData.length - 1) {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const LoginPage(),
//                         ),
//                       );
//                     } else {
//                       _pageController.nextPage(
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeIn,
//                       );
//                     }
//                   },
//                   child: Text(
//                     _currentPage == onboardingData.length - 1
//                         ? "Mulai Sekarang"
//                         : "Selanjutnya",
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }

//   Container buildDot(int index, BuildContext context) {
//     return Container(
//       height: 10,
//       width: _currentPage == index ? 25 : 10,
//       margin: const EdgeInsets.only(right: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: _currentPage == index
//             ? Colors.blue.shade800
//             : Colors.grey.shade300,
//       ),
//     );
//   }
// }
