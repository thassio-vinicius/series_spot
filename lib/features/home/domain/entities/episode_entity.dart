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
  final int? number;
  final String? type;
  final String? airDate;
  final String? airtime;
  final String? airStamp;
  final int? runtime;
  final RatingEntity? rating;
  final ImageEntity? image;
  final String? summary;
  final LinksEntity? links;

  const EpisodeEntity({
    required this.id,
    required this.url,
    required this.name,
    required this.season,
    this.number,
    this.type,
    this.airDate,
    this.airtime,
    this.airStamp,
    this.runtime,
    this.rating,
    this.image,
    this.summary,
    this.links,
  });

  factory EpisodeEntity.fromModel(EpisodeModel model) {
    return EpisodeEntity(
      id: model.id,
      url: model.url,
      name: model.name,
      season: model.season,
      number: model.number,
      type: model.type,
      airDate: model.airDate,
      airtime: model.airtime,
      airStamp: model.airStamp,
      runtime: model.runtime,
      rating:
          model.rating == null ? null : RatingEntity.fromModel(model.rating!),
      image: model.image == null ? null : ImageEntity.fromModel(model.image!),
      summary: model.summary,
      links: model.links == null ? null : LinksEntity.fromModel(model.links!),
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
        airDate,
        airtime,
        airStamp,
        runtime,
        rating,
        image,
        summary,
        links,
      ];
}
