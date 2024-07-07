import 'package:series_spot/features/home/data/models/externals_model.dart';
import 'package:series_spot/features/home/data/models/image_model.dart';
import 'package:series_spot/features/home/data/models/links_model.dart';
import 'package:series_spot/features/home/data/models/network_model.dart';
import 'package:series_spot/features/home/data/models/rating_model.dart';
import 'package:series_spot/features/home/data/models/schedule_model.dart';

class ShowModel {
  final int id;
  final String? url;
  final String name;
  final String? type;
  final String? language;
  final List<String> genres;
  final String? status;
  final int? runtime;
  final int? averageRuntime;
  final String? premiered;
  final ScheduleModel? schedule;
  final RatingModel? rating;
  final int? weight;
  final NetworkModel? network;
  final String? webChannel;
  final String? dvdCountry;
  final String? ended;
  final String? officialSite;
  final ExternalsModel? externals;
  final ImageModel? image;
  final String? summary;
  final int? updated;
  final LinksModel? links;

  ShowModel({
    required this.id,
    required this.url,
    required this.name,
    required this.genres,
    this.type,
    this.language,
    this.status,
    this.runtime,
    this.averageRuntime,
    this.premiered,
    this.officialSite,
    this.schedule,
    this.rating,
    this.weight,
    this.network,
    this.externals,
    this.image,
    this.summary,
    this.updated,
    this.links,
    this.webChannel,
    this.dvdCountry,
    this.ended,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      language: json['language'],
      genres: List<String>.from(json['genres']),
      status: json['status'],
      runtime: json['runtime'],
      averageRuntime: json['averageRuntime'],
      premiered: json['premiered'],
      ended: json['ended'],
      officialSite: json['officialSite'],
      schedule: ScheduleModel.fromJson(json['schedule']),
      rating: RatingModel.fromJson(json['rating']),
      weight: json['weight'],
      network: json['network'] == null
          ? null
          : NetworkModel.fromJson(json['network']),
      webChannel: json['webChannel']?.toString(),
      dvdCountry: json['dvdCountry']?.toString(),
      externals: ExternalsModel.fromJson(json['externals']),
      image: json['image'] == null ? null : ImageModel.fromJson(json['image']),
      summary: json['summary'],
      updated: json['updated'],
      links: LinksModel.fromJson(json['_links']),
    );
  }
}
