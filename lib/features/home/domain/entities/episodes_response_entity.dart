import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/episodes_response_model.dart';
import 'package:series_spot/features/home/domain/entities/episode_entity.dart';

class EpisodesResponseEntity extends Equatable {
  final List<EpisodeEntity> episodes;

  const EpisodesResponseEntity({required this.episodes});

  factory EpisodesResponseEntity.fromModel(EpisodesResponseModel model) {
    return EpisodesResponseEntity(
      episodes: model.episodes.map((e) => EpisodeEntity.fromModel(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [episodes];
}
