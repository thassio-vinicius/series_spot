import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_spot/core/errors/failures.dart';
import 'package:series_spot/features/home/data/data_source/shows.dart';
import 'package:series_spot/features/home/data/models/show_model.dart';
import 'package:series_spot/features/home/data/models/show_query_model.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';
import 'package:series_spot/features/home/domain/entities/show_query_entity.dart';
import 'package:series_spot/features/home/domain/repositories/shows_repository.dart';

class MockFetchShowsDataSource extends Mock implements FetchShowsDataSource {}

void main() {
  late FetchShowsRepositoryImpl repository;
  late MockFetchShowsDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockFetchShowsDataSource();
    repository = FetchShowsRepositoryImpl(mockDataSource);
  });

  const tPageNumber = 1;
  const tSearchQuery = 'query';
  final tShowModelList = [
    ShowModel(id: 1, name: 'Show 1', url: '', genres: []),
    ShowModel(id: 2, name: 'Show 2', url: '', genres: []),
  ];
  final tShowEntityList =
      tShowModelList.map((e) => ShowEntity.fromModel(e)).toList();

  final tShowQueryModelList = [
    ShowQueryModel(show: tShowModelList[0], score: 0),
    ShowQueryModel(show: tShowModelList[1], score: 0),
  ];
  final tShowQueryEntityList =
      tShowQueryModelList.map((e) => ShowQueryEntity.fromModel(e)).toList();
  final tSearchResult = tShowQueryEntityList.map((e) => e.show).toList();

  group('fetchShows', () {
    test(
        'should return a list of ShowEntity when the call to data source is successful',
        () async {
      when(() => mockDataSource.fetchShows(any()))
          .thenAnswer((_) async => tShowModelList);

      final result = await repository.fetchShows(tPageNumber);

      verify(() => mockDataSource.fetchShows(tPageNumber));

      result.fold(
        (l) => fail('Expected a Right, but got a Left'),
        (r) => expect(
            const DeepCollectionEquality().equals(tShowEntityList, r), isTrue),
      );
    });

    test(
        'should return a NoShowsQueryFailure when the call to data source throws an exception',
        () async {
      when(() => mockDataSource.fetchShows(any())).thenThrow(Exception());

      final result = await repository.fetchShows(tPageNumber);

      verify(() => mockDataSource.fetchShows(tPageNumber));
      expect(result, const Left(NoShowsQueryFailure()));
    });
  });

  group('searchShows', () {
    test(
        'should return a list of ShowEntity when the call to data source is successful',
        () async {
      when(() => mockDataSource.searchShows(any()))
          .thenAnswer((_) async => tShowQueryModelList);

      final result = await repository.searchShows(tSearchQuery);

      verify(() => mockDataSource.searchShows(tSearchQuery));
      result.fold(
        (l) => fail('Expected a Right, but got a Left'),
        (r) => expect(
            const DeepCollectionEquality().equals(tShowEntityList, r), isTrue),
      );
    });

    test(
        'should return a NoShowsQueryFailure when the call to data source throws an exception',
        () async {
      when(() => mockDataSource.searchShows(any())).thenThrow(Exception());

      final result = await repository.searchShows(tSearchQuery);

      verify(() => mockDataSource.searchShows(tSearchQuery));
      expect(result, const Left(NoShowsQueryFailure()));
    });
  });
}
