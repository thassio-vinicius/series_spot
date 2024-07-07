import 'package:get_it/get_it.dart';
import 'package:series_spot/core/http/client.dart';
import 'package:series_spot/features/home/data/data_source/episodes.dart';
import 'package:series_spot/features/home/data/data_source/shows.dart';
import 'package:series_spot/features/home/domain/repositories/episodes_repository.dart';
import 'package:series_spot/features/home/domain/repositories/shows_repository.dart';
import 'package:series_spot/l10n/global_app_localizations.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton<GlobalAppLocalizations>(GlobalAppLocalizationsImpl());

  sl.registerSingleton<HTTP>(HTTP());

  sl.registerFactory<FetchShowsDataSource>(() => FetchShowsDataSource(sl()));
  sl.registerFactory<ShowsRepository>(() => FetchShowsRepositoryImpl(sl()));
  sl.registerFactory<FetchEpisodesDataSource>(
      () => FetchEpisodesDataSource(sl()));
  sl.registerFactory<EpisodesRepository>(
      () => FetchEpisodesRepositoryImpl(sl()));
}
