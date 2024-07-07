import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:series_spot/core/errors/failure.dart';
import 'package:series_spot/core/errors/failures.dart';
import 'package:series_spot/features/home/data/data_source/shows.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';
import 'package:series_spot/features/home/domain/entities/show_query_entity.dart';

abstract class ShowsRepository {
  const ShowsRepository();
  Future<Either<Failure, List<ShowEntity>>> fetchShows(int pageNumber);
  Future<Either<Failure, List<ShowEntity>>> searchShows(String searchQuery);
}

class FetchShowsRepositoryImpl extends ShowsRepository {
  final FetchShowsDataSource _dataSource;
  const FetchShowsRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<ShowEntity>>> fetchShows(int pageNumber) async {
    try {
      final response = await _dataSource.fetchShows(pageNumber);

      return Right(response.map((e) => ShowEntity.fromModel(e)).toList());
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return const Left(NoShowsQueryFailure());
    }
  }

  @override
  Future<Either<Failure, List<ShowEntity>>> searchShows(
      String searchQuery) async {
    try {
      final response = await _dataSource.searchShows(searchQuery);

      final queryList =
          response.map((e) => ShowQueryEntity.fromModel(e)).toList();

      return Right(queryList.map((e) => e.show).toList());
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return const Left(NoShowsQueryFailure());
    }
  }
}
