import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:series_spot/core/errors/failure.dart';
import 'package:series_spot/core/errors/failures.dart';
import 'package:series_spot/core/utils/base_cubit.dart';
import 'package:series_spot/features/home/domain/entities/episode_entity.dart';
import 'package:series_spot/features/home/domain/repositories/episodes_repository.dart';

part 'fetch_episodes_state.dart';

class EpisodesCubit extends BaseCubit<EpisodesState> {
  EpisodesCubit(this._repository) : super(const EpisodesInitialState());

  final EpisodesRepository _repository;

  Future<void> fetchEpisodes(int id) async {
    emit(const EpisodesLoadingState());

    final response = await _repository.fetchEpisodes(id);

    response.fold(
      (l) {
        debugPrint(l.toString());
        emit(EpisodesFailedState(failure: l));
      },
      (r) {
        if (r.isEmpty) {
          emit(const EpisodesFailedState(failure: NoEpisodesFailure()));

          return;
        }

        emit(EpisodesLoadedState(episodes: r));
      },
    );
  }
}
