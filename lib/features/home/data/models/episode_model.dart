import 'package:series_spot/features/home/data/models/image_model.dart';
import 'package:series_spot/features/home/data/models/links_model.dart';
import 'package:series_spot/features/home/data/models/rating_model.dart';

class EpisodeModel {
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
  final RatingModel? rating;
  final ImageModel? image;
  final String? summary;
  final LinksModel? links;

  EpisodeModel({
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

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      season: json['season'],
      number: json['number'],
      type: json['type'],
      airDate: json['airdate'],
      airtime: json['airtime'],
      airStamp: json['airstamp'],
      runtime: json['runtime'],
      rating:
          json['rating'] == null ? null : RatingModel.fromJson(json['rating']),
      image: json['image'] == null ? null : ImageModel.fromJson(json['image']),
      summary: json['summary'],
      links:
          json['_links'] == null ? null : LinksModel.fromJson(json['_links']),
    );
  }
}
