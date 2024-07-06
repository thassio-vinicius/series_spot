import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:series_spot/core/presentation/routes/route_names.dart';
import 'package:series_spot/features/splash/presentation/splash_screen.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

final router = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: RouteNames.splash,
  observers: [],
  routes: [
    GoRoute(
      name: RouteNames.splash,
      path: RouteNames.splash,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const SplashScreen(),
          name: state.name,
        );
      },
    ),
  ],
);
