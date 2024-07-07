import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:series_spot/core/presentation/routes/route_names.dart';
import 'package:series_spot/features/home/presentation/home_screen.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

final router = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: RouteNames.home,
  observers: [],
  routes: [
    GoRoute(
      name: RouteNames.home,
      path: RouteNames.home,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const HomeScreen(),
          name: state.name,
        );
      },
    ),
  ],
);
