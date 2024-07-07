part of 'fetch_episodes_cubit.dart';

abstract class EpisodesState extends Equatable {
  const EpisodesState();

  @override
  List<Object?> get props => [];
}

class EpisodesInitialState extends EpisodesState {
  const EpisodesInitialState();
}

class EpisodesLoadingState extends EpisodesState {
  const EpisodesLoadingState();
}

class EpisodesFailedState extends EpisodesState {
  final Failure failure;

  const EpisodesFailedState({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class EpisodesLoadedState extends EpisodesState {
  const EpisodesLoadedState({required this.episodes});

  final List<EpisodeEntity> episodes;

  @override
  List<Object?> get props => [episodes];
}
