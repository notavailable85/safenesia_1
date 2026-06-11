String? routeRedirect({required bool isLoggedIn, required String location}) {
  final isAuthPage = [
    '/login',
    '/register',
    '/forgot-password',
  ].contains(location);

  if (!isLoggedIn && !isAuthPage) {
    return '/login';
  }

  if (isLoggedIn && isAuthPage) {
    return '/home';
  }

  return null;
}
