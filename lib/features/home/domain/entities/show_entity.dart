import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/show_model.dart';
import 'package:series_spot/features/home/domain/entities/externals_entity.dart';
import 'package:series_spot/features/home/domain/entities/image_entity.dart';
import 'package:series_spot/features/home/domain/entities/links_entity.dart';
import 'package:series_spot/features/home/domain/entities/network_entity.dart';
import 'package:series_spot/features/home/domain/entities/rating_entity.dart';
import 'package:series_spot/features/home/domain/entities/schedule_entity.dart';

class ShowEntity extends Equatable {
  final int id;
  final String? url;
  final String name;
  final String? type;
  final String? language;
  final List<String>? genres;
  final String? status;
  final int? runtime;
  final int? averageRuntime;
  final String? premiered;
  final ScheduleEntity? schedule;
  final RatingEntity? rating;
  final int? weight;
  final NetworkEntity? network;
  final String? webChannel;
  final String? dvdCountry;
  final String? ended;
  final String? officialSite;
  final ExternalsEntity? externals;
  final ImageEntity? image;
  final String? summary;
  final int? updated;
  final LinksEntity? links;

  const ShowEntity({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    required this.runtime,
    required this.averageRuntime,
    required this.premiered,
    required this.ended,
    required this.officialSite,
    required this.schedule,
    required this.rating,
    required this.weight,
    required this.network,
    required this.webChannel,
    required this.dvdCountry,
    required this.externals,
    required this.image,
    required this.summary,
    required this.updated,
    required this.links,
  });

  factory ShowEntity.fromModel(ShowModel model) {
    return ShowEntity(
      id: model.id,
      url: model.url,
      name: model.name,
      type: model.type,
      language: model.language,
      genres: model.genres,
      status: model.status,
      runtime: model.runtime,
      averageRuntime: model.averageRuntime,
      premiered: model.premiered,
      ended: model.ended,
      officialSite: model.officialSite,
      schedule: model.schedule == null
          ? null
          : ScheduleEntity.fromModel(model.schedule!),
      rating:
          model.rating == null ? null : RatingEntity.fromModel(model.rating!),
      weight: model.weight,
      network: model.network == null
          ? null
          : NetworkEntity.fromModel(model.network!),
      webChannel: model.webChannel,
      dvdCountry: model.dvdCountry,
      externals: model.externals == null
          ? null
          : ExternalsEntity.fromModel(model.externals!),
      image: model.image == null ? null : ImageEntity.fromModel(model.image!),
      summary: model.summary,
      updated: model.updated,
      links: model.links == null ? null : LinksEntity.fromModel(model.links!),
    );
  }

  @override
  List<Object?> get props => [
        id,
        url,
        name,
        type,
        language,
        genres,
        status,
        runtime,
        averageRuntime,
        premiered,
        ended,
        officialSite,
        schedule,
        rating,
        weight,
        network,
        webChannel,
        dvdCountry,
        externals,
        image,
        summary,
        updated,
        links,
      ];
}
