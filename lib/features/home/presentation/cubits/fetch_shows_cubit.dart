import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:series_spot/core/errors/failure.dart';
import 'package:series_spot/core/errors/failures.dart';
import 'package:series_spot/core/utils/base_cubit.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';
import 'package:series_spot/features/home/domain/repositories/shows_repository.dart';

part 'fetch_shows_state.dart';

class ShowsCubit extends BaseCubit<ShowsState> {
  ShowsCubit(this._repository) : super(const ShowsInitialState());

  int _pageNumber = 0;
  bool _isFetching = false;
  bool isLastPage = false;

  final ShowsRepository _repository;
  List<ShowEntity> shows = [];

  void checkPagination() {
    emit(FetchNextPageState(shows: shows));
    fetchShows(fromPreviousPage: true);
  }

  Future<void> searchShows(
    String searchQuery,
  ) async {
    emit(const ShowsLoadingState());

    final response = await _repository.searchShows(searchQuery);

    response.fold(
      (l) {
        debugPrint(l.toString());
        emit(ShowsFailedState(failure: l));
      },
      (r) {
        _pageNumber = 0;
        //shows.clear();

        if (r.isEmpty) {
          emit(const ShowsFailedState(failure: NoShowsQueryFailure()));

          return;
        }

        emit(ShowsLoadedState(shows: r, page: _pageNumber));
      },
    );
  }

  Future<void> fetchShows({
    bool fromPreviousPage = false,
  }) async {
    if (_isFetching) return;
    _isFetching = true;
    if (!fromPreviousPage) emit(const ShowsLoadingState());

    final response = await _repository.fetchShows(_pageNumber);

    response.fold(
      (l) {
        debugPrint(l.toString());
        emit(ShowsFailedState(failure: l));
      },
      (r) {
        if (r.isEmpty) {
          emit(const ShowsFailedState(failure: NoShowsQueryFailure()));
          _isFetching = false;
          return;
        }
        shows.addAll(r);

        emit(ShowsLoadedState(shows: shows, page: _pageNumber));

        _pageNumber++;
      },
    );
    _isFetching = false;
  }
}
