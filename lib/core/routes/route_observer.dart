import 'dart:developer';
import 'package:flutter/widgets.dart';

class AppRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    log(
      'didPush: ${route.settings.name}, previousRoute: ${previousRoute?.settings.name}',
      name: 'AppRouteObserver',
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    log(
      'didPop: ${route.settings.name}, previousRoute: ${previousRoute?.settings.name}',
      name: 'AppRouteObserver',
    );
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    log(
      'didReplace: ${newRoute?.settings.name}, oldRoute: ${oldRoute?.settings.name}',
      name: 'AppRouteObserver',
    );
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    log(
      'didRemove: ${route.settings.name}, previousRoute: ${previousRoute?.settings.name}',
      name: 'AppRouteObserver',
    );
  }
}
