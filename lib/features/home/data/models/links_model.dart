import 'package:series_spot/features/home/data/models/previous_episode_model.dart';
import 'package:series_spot/features/home/data/models/self_link_model.dart';

class LinksModel {
  final SelfLinkModel self;
  final PreviousEpisodeModel? previousEpisode;

  LinksModel({
    required this.self,
    this.previousEpisode,
  });

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      self: SelfLinkModel.fromJson(json['self']),
      previousEpisode: json['previousepisode'] != null
          ? PreviousEpisodeModel.fromJson(json['previousepisode'])
          : null,
    );
  }
}
