import 'package:series_spot/features/home/data/models/episode_model.dart';

class EpisodesResponseModel {
  final List<EpisodeModel> episodes;

  EpisodesResponseModel({required this.episodes});

  factory EpisodesResponseModel.fromJson(List<dynamic> json) {
    return EpisodesResponseModel(
      episodes: json.map((e) => EpisodeModel.fromJson(e)).toList(),
    );
  }
}
