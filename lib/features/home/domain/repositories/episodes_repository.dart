import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:series_spot/core/errors/failure.dart';
import 'package:series_spot/core/errors/failures.dart';
import 'package:series_spot/features/home/data/data_source/episodes.dart';
import 'package:series_spot/features/home/domain/entities/episode_entity.dart';

abstract class EpisodesRepository {
  const EpisodesRepository();
  Future<Either<Failure, List<EpisodeEntity>>> fetchEpisodes(int id);
}

class FetchEpisodesRepositoryImpl extends EpisodesRepository {
  final FetchEpisodesDataSource _dataSource;
  const FetchEpisodesRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<EpisodeEntity>>> fetchEpisodes(int id) async {
    try {
      final response = await _dataSource.fetchEpisodes(id);

      return Right(response.map((e) => EpisodeEntity.fromModel(e)).toList());
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return const Left(NoEpisodesFailure());
    }
  }
}
