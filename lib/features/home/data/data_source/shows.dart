import 'package:series_spot/core/http/apis.dart';
import 'package:series_spot/core/http/client.dart';
import 'package:series_spot/features/home/data/models/show_model.dart';
import 'package:series_spot/features/home/data/models/show_query_model.dart';

class FetchShowsDataSource {
  final HTTP _http;
  const FetchShowsDataSource(this._http);

  Future<List<ShowModel>> fetchShows(int pageNumber) async {
    try {
      final response = await _http.client
          .get(APIs.shows, queryParameters: {'page': pageNumber});

      return List.from(response.data)
          .map((e) => ShowModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ShowQueryModel>> searchShows(String query) async {
    try {
      final response = await _http.client
          .get(APIs.searchShows, queryParameters: {'q': query});

      return List.from(response.data)
          .map((e) => ShowQueryModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
