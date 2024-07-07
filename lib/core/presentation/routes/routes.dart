import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:series_spot/core/presentation/routes/route_names.dart';
import 'package:series_spot/features/home/domain/entities/episode_entity.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';
import 'package:series_spot/features/home/presentation/episode_details/episode_details_screen.dart';
import 'package:series_spot/features/home/presentation/list_shows/list_shows_screen.dart';
import 'package:series_spot/features/home/presentation/show_details/tv_show_details_screen.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

final router = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: RouteNames.listShows,
  observers: [],
  routes: [
    GoRoute(
      name: RouteNames.listShows,
      path: RouteNames.listShows,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const ListShowsScreen(),
          name: state.name,
        );
      },
    ),
    GoRoute(
      name: RouteNames.tvShowDetails,
      path: RouteNames.tvShowDetails,
      pageBuilder: (context, state) {
        assert((state.extra as ShowEntity?) != null);
        final show = state.extra as ShowEntity;
        return MaterialPage(
          child: TVShowDetailsScreen(show: show),
          name: state.name,
        );
      },
    ),
    GoRoute(
      name: RouteNames.episodeDetails,
      path: RouteNames.episodeDetails,
      pageBuilder: (context, state) {
        assert((state.extra as EpisodeEntity?) != null);
        final episode = state.extra as EpisodeEntity;
        return MaterialPage(
          child: EpisodeDetailsScreen(episode: episode),
          name: state.name,
        );
      },
    ),
  ],
);
