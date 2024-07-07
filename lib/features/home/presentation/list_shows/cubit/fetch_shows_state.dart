part of 'fetch_shows_cubit.dart';

abstract class ShowsState extends Equatable {
  const ShowsState();

  abstract final List<ShowEntity> shows;

  ShowsState copyWith({List<ShowEntity>? shows});

  @override
  List<Object?> get props => [shows];
}

class ShowsInitialState extends ShowsState {
  @override
  final List<ShowEntity> shows;
  const ShowsInitialState({this.shows = const []});

  @override
  ShowsState copyWith({List<ShowEntity>? shows}) {
    return const ShowsInitialState();
  }
}

class ShowsLoadingState extends ShowsState {
  @override
  final List<ShowEntity> shows;
  const ShowsLoadingState({this.shows = const []});

  @override
  ShowsState copyWith({List<ShowEntity>? shows}) {
    return const ShowsLoadingState();
  }
}

class ShowsFailedState extends ShowsState {
  final Failure failure;

  @override
  final List<ShowEntity> shows;
  const ShowsFailedState({required this.failure, this.shows = const []});

  @override
  ShowsState copyWith({List<ShowEntity>? shows, Failure? failure}) {
    return ShowsFailedState(failure: failure ?? this.failure);
  }

  @override
  List<Object?> get props => [failure];
}

class ShowsLoadedState extends ShowsState {
  const ShowsLoadedState({required this.shows, required this.page});

  final int page;
  @override
  final List<ShowEntity> shows;

  @override
  List<Object?> get props => [page, shows];

  @override
  ShowsState copyWith({List<ShowEntity>? shows, int? page}) {
    return ShowsLoadedState(
      shows: shows ?? this.shows,
      page: page ?? this.page,
    );
  }
}

class FetchNextPageState extends ShowsState {
  @override
  final List<ShowEntity> shows;
  const FetchNextPageState({required this.shows});

  @override
  ShowsState copyWith({List<ShowEntity>? shows}) {
    return const ShowsLoadingState();
  }
}
