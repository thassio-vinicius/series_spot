import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series_spot/core/errors/failures.dart';
import 'package:series_spot/features/home/domain/entities/episode_entity.dart';
import 'package:series_spot/features/home/domain/repositories/episodes_repository.dart';
import 'package:series_spot/features/home/presentation/show_details/cubit/fetch_episodes_cubit.dart';

class MockEpisodesRepository extends Mock implements EpisodesRepository {}

void main() {
  late EpisodesCubit cubit;
  late MockEpisodesRepository mockRepository;

  setUp(() {
    mockRepository = MockEpisodesRepository();
    cubit = EpisodesCubit(mockRepository);
  });

  const tId = 1;
  const tEpisodes = [
    EpisodeEntity(
      id: 1,
      url: '',
      name: 'Episode 1',
      season: 1,
      number: 1,
    ),
    EpisodeEntity(
      id: 2,
      url: '',
      name: 'Episode 2',
      season: 1,
      number: 2,
    ),
  ];

  group('EpisodesCubit', () {
    test('initial state should be EpisodesInitialState', () {
      expect(cubit.state, equals(const EpisodesInitialState()));
    });

    blocTest<EpisodesCubit, EpisodesState>(
      'emits [EpisodesLoadingState, EpisodesLoadedState] when fetchEpisodes is successful',
      build: () {
        when(() => mockRepository.fetchEpisodes(any()))
            .thenAnswer((_) async => const Right(tEpisodes));
        return cubit;
      },
      act: (cubit) => cubit.fetchEpisodes(tId),
      expect: () => [
        const EpisodesLoadingState(),
        const EpisodesLoadedState(episodes: tEpisodes),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchEpisodes(tId)).called(1);
      },
    );

    blocTest<EpisodesCubit, EpisodesState>(
      'emits [EpisodesLoadingState, EpisodesFailedState] when fetchEpisodes fails',
      build: () {
        when(() => mockRepository.fetchEpisodes(any()))
            .thenAnswer((_) async => const Left(NoEpisodesFailure()));
        return cubit;
      },
      act: (cubit) => cubit.fetchEpisodes(tId),
      expect: () => [
        const EpisodesLoadingState(),
        const EpisodesFailedState(failure: NoEpisodesFailure()),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchEpisodes(tId)).called(1);
      },
    );

    blocTest<EpisodesCubit, EpisodesState>(
      'emits [EpisodesLoadingState, EpisodesFailedState] when fetchEpisodes returns an empty list',
      build: () {
        when(() => mockRepository.fetchEpisodes(any()))
            .thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.fetchEpisodes(tId),
      expect: () => [
        const EpisodesLoadingState(),
        const EpisodesFailedState(failure: NoEpisodesFailure()),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchEpisodes(tId)).called(1);
      },
    );
  });
}
