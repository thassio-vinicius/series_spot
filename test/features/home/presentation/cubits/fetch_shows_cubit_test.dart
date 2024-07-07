import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_spot/core/errors/failures.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';
import 'package:series_spot/features/home/domain/repositories/shows_repository.dart';
import 'package:series_spot/features/home/presentation/list_shows/cubit/fetch_shows_cubit.dart';

class MockShowsRepository extends Mock implements ShowsRepository {}

void main() {
  late ShowsCubit cubit;
  late MockShowsRepository mockRepository;

  setUp(() {
    mockRepository = MockShowsRepository();
    cubit = ShowsCubit(mockRepository);
  });

  const tSearchQuery = 'query';
  final tShowEntityList = [
    const ShowEntity(
      id: 1,
      name: 'Show 1',
      url: '',
      summary: '',
      language: '',
      genres: [],
    ),
    const ShowEntity(
      id: 2,
      name: 'Show 2',
      url: '',
      summary: '',
      language: '',
      genres: [],
    ),
  ];

  group('ShowsCubit', () {
    test('initial state should be ShowsInitialState', () {
      expect(cubit.state, equals(const ShowsInitialState()));
    });

    blocTest<ShowsCubit, ShowsState>(
      'emits [ShowsLoadingState, ShowsLoadedState] when searchShows is successful',
      build: () {
        when(() => mockRepository.searchShows(any()))
            .thenAnswer((_) async => Right(tShowEntityList));
        return cubit;
      },
      act: (cubit) => cubit.searchShows(tSearchQuery),
      expect: () => [
        const ShowsLoadingState(),
        ShowsLoadedState(shows: tShowEntityList, page: 0),
      ],
      verify: (_) {
        verify(() => mockRepository.searchShows(tSearchQuery)).called(1);
      },
    );

    blocTest<ShowsCubit, ShowsState>(
      'emits [ShowsLoadingState, ShowsFailedState] when searchShows fails',
      build: () {
        when(() => mockRepository.searchShows(any()))
            .thenAnswer((_) async => const Left(NoShowsQueryFailure()));
        return cubit;
      },
      act: (cubit) => cubit.searchShows(tSearchQuery),
      expect: () => [
        const ShowsLoadingState(),
        const ShowsFailedState(failure: NoShowsQueryFailure()),
      ],
      verify: (_) {
        verify(() => mockRepository.searchShows(tSearchQuery)).called(1);
      },
    );

    blocTest<ShowsCubit, ShowsState>(
      'emits [ShowsLoadingState, ShowsLoadedState] when fetchShows is successful',
      build: () {
        when(() => mockRepository.fetchShows(any()))
            .thenAnswer((_) async => Right(tShowEntityList));
        return cubit;
      },
      act: (cubit) => cubit.fetchShows(),
      expect: () => [
        const ShowsLoadingState(),
        ShowsLoadedState(shows: tShowEntityList, page: 0),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchShows(0)).called(1);
      },
    );

    blocTest<ShowsCubit, ShowsState>(
      'emits [ShowsLoadingState, ShowsFailedState] when fetchShows fails',
      build: () {
        when(() => mockRepository.fetchShows(any()))
            .thenAnswer((_) async => const Left(NoShowsQueryFailure()));
        return cubit;
      },
      act: (cubit) => cubit.fetchShows(),
      expect: () => [
        const ShowsLoadingState(),
        const ShowsFailedState(failure: NoShowsQueryFailure()),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchShows(0)).called(1);
      },
    );
  });
}
