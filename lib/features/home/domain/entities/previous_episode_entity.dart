import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/previous_episode_model.dart';

class PreviousEpisodeEntity extends Equatable {
  final String href;
  final String name;

  const PreviousEpisodeEntity({required this.href, required this.name});

  factory PreviousEpisodeEntity.fromModel(PreviousEpisodeModel model) {
    return PreviousEpisodeEntity(
      href: model.href,
      name: model.name,
    );
  }

  @override
  List<Object?> get props => [href, name];
}
