import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/links_model.dart';
import 'package:series_spot/features/home/domain/entities/link_entity.dart';
import 'package:series_spot/features/home/domain/entities/previous_episode_entity.dart';

class LinksEntity extends Equatable {
  final SelfLinkEntity self;
  final PreviousEpisodeEntity? previousEpisode;

  const LinksEntity({required this.self, required this.previousEpisode});

  factory LinksEntity.fromModel(LinksModel model) {
    return LinksEntity(
      self: SelfLinkEntity.fromModel(model.self),
      previousEpisode: model.previousEpisode != null
          ? PreviousEpisodeEntity.fromModel(model.previousEpisode!)
          : null,
    );
  }

  @override
  List<Object?> get props => [self, previousEpisode];
}
