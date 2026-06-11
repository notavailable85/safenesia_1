class RouteGuards {
  RouteGuards._();

  static bool isAuthenticated(bool loggedIn) {
    return loggedIn;
  }

  static bool isGuest(bool loggedIn) {
    return !loggedIn;
  }
}
