import 'package:series_spot/features/home/data/models/image_model.dart';
import 'package:series_spot/features/home/data/models/links_model.dart';
import 'package:series_spot/features/home/data/models/rating_model.dart';

class EpisodeModel {
  final int id;
  final String url;
  final String name;
  final int season;
  final int number;
  final String type;
  final String airDate;
  final String airtime;
  final String airStamp;
  final int runtime;
  final RatingModel rating;
  final ImageModel image;
  final String summary;
  final LinksModel links;

  EpisodeModel({
    required this.id,
    required this.url,
    required this.name,
    required this.season,
    required this.number,
    required this.type,
    required this.airDate,
    required this.airtime,
    required this.airStamp,
    required this.runtime,
    required this.rating,
    required this.image,
    required this.summary,
    required this.links,
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
      rating: RatingModel.fromJson(json['rating']),
      image: ImageModel.fromJson(json['image']),
      summary: json['summary'],
      links: LinksModel.fromJson(json['_links']),
    );
  }
}
