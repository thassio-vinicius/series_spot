import 'package:series_spot/core/http/apis.dart';
import 'package:series_spot/core/http/client.dart';
import 'package:series_spot/features/home/data/models/episode_model.dart';

class FetchEpisodesDataSource {
  final HTTP _http;
  const FetchEpisodesDataSource(this._http);

  Future<List<EpisodeModel>> fetchEpisodes(int id) async {
    try {
      final response = await _http.client.get(APIs.episodes(id));

      return List.from(response.data)
          .map((e) => EpisodeModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
