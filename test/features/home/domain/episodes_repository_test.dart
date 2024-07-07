import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_spot/core/errors/failures.dart';
import 'package:series_spot/features/home/data/data_source/episodes.dart';
import 'package:series_spot/features/home/data/models/episode_model.dart';
import 'package:series_spot/features/home/domain/entities/episode_entity.dart';
import 'package:series_spot/features/home/domain/repositories/episodes_repository.dart';

class MockFetchEpisodesDataSource extends Mock
    implements FetchEpisodesDataSource {}

void main() {
  late FetchEpisodesRepositoryImpl repository;
  late MockFetchEpisodesDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockFetchEpisodesDataSource();
    repository = FetchEpisodesRepositoryImpl(mockDataSource);
  });

  const tId = 1;
  final tEpisodesModelList = [
    EpisodeModel(id: 1, name: 'Episode 1', season: 1, number: 1, url: ''),
    EpisodeModel(id: 2, name: 'Episode 2', season: 1, number: 2, url: ''),
  ];
  final tEpisodesEntityList =
      tEpisodesModelList.map((e) => EpisodeEntity.fromModel(e)).toList();

  test(
      'should return a list of EpisodeEntity when the call to data source is successful',
      () async {
    when(() => mockDataSource.fetchEpisodes(any()))
        .thenAnswer((_) async => tEpisodesModelList);

    final result = await repository.fetchEpisodes(tId);

    verify(() => mockDataSource.fetchEpisodes(tId));

    result.fold(
      (l) => fail('Expected a Right, but got a Left'),
      (r) => expect(
          const DeepCollectionEquality().equals(tEpisodesEntityList, r),
          isTrue),
    );
  });

  test(
      'should return a NoEpisodesFailure when the call to data source throws an exception',
      () async {
    when(() => mockDataSource.fetchEpisodes(any())).thenThrow(Exception());

    final result = await repository.fetchEpisodes(tId);

    verify(() => mockDataSource.fetchEpisodes(tId));
    expect(result, const Left(NoEpisodesFailure()));
  });
}
