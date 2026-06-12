import 'package:go_router/go_router.dart';
import 'package:safenesia_1/core/routes/route_names.dart';
import 'package:safenesia_1/core/routes/route_observer.dart';

// Import halaman-halaman Anda
import 'package:safenesia_1/features/auth/presentation/pages/splash/onboarding_page.dart';
import 'package:safenesia_1/features/auth/presentation/pages/login/login_page.dart';
import 'package:safenesia_1/features/auth/presentation/pages/register/verify_email_page.dart';
import 'package:safenesia_1/features/home/presentation/pages/navigation_bottom.dart';
import 'package:safenesia_1/features/notification/notification_page.dart';
import 'package:safenesia_1/features/training/presentation/pages/training_detail_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    // Tentukan halaman pertama yang dimuat saat aplikasi dibuka
    initialLocation: RouteNames.onboarding,
    // Masukkan observer yang sudah Anda miliki untuk tracking navigasi
    observers: [AppRouteObserver()],
    routes: [
      GoRoute(
        path: RouteNames.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.verifyEmail,
        name: 'verifyEmail',
        builder: (context, state) => const VerifyEmailPage(),
      ),
      GoRoute(
        path: RouteNames.main,
        name: 'main',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: RouteNames.notifications,
        name: 'notification',
        builder: (context, state) => const NotificationPage(),
      ),
      // Contoh route yang menerima parameter (data training)
      GoRoute(
        path: RouteNames.trainingDetail,
        name: 'trainingDetail',
        builder: (context, state) {
          // Menerima parameter dari state.extra
          final trainingData = state.extra as Map<String, dynamic>? ?? {};
          return TrainingDetailPage(trainingData: trainingData);
        },
      ),
    ],
  );
}
