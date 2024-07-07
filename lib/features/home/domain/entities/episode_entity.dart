import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/episode_model.dart';
import 'package:series_spot/features/home/domain/entities/image_entity.dart';
import 'package:series_spot/features/home/domain/entities/links_entity.dart';
import 'package:series_spot/features/home/domain/entities/rating_entity.dart';

class EpisodeEntity extends Equatable {
  final int id;
  final String url;
  final String name;
  final int season;
  final int number;
  final String type;
  final String airdate;
  final String airtime;
  final String airstamp;
  final int runtime;
  final RatingEntity rating;
  final ImageEntity image;
  final String summary;
  final LinksEntity links;

  const EpisodeEntity({
    required this.id,
    required this.url,
    required this.name,
    required this.season,
    required this.number,
    required this.type,
    required this.airdate,
    required this.airtime,
    required this.airstamp,
    required this.runtime,
    required this.rating,
    required this.image,
    required this.summary,
    required this.links,
  });

  factory EpisodeEntity.fromModel(EpisodeModel model) {
    return EpisodeEntity(
      id: model.id,
      url: model.url,
      name: model.name,
      season: model.season,
      number: model.number,
      type: model.type,
      airdate: model.airDate,
      airtime: model.airtime,
      airstamp: model.airStamp,
      runtime: model.runtime,
      rating: RatingEntity.fromModel(model.rating),
      image: ImageEntity.fromModel(model.image),
      summary: model.summary,
      links: LinksEntity.fromModel(model.links),
    );
  }

  @override
  List<Object?> get props => [
        id,
        url,
        name,
        season,
        number,
        type,
        airdate,
        airtime,
        airstamp,
        runtime,
        rating,
        image,
        summary,
        links,
      ];
}
