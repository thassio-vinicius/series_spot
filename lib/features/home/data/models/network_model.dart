import 'package:series_spot/features/home/data/models/country_model.dart';

class NetworkModel {
  final int id;
  final String name;
  final CountryModel country;
  final String? officialSite;

  NetworkModel({
    required this.id,
    required this.name,
    required this.country,
    this.officialSite,
  });

  factory NetworkModel.fromJson(Map<String, dynamic> json) {
    return NetworkModel(
      id: json['id'],
      name: json['name'],
      country: CountryModel.fromJson(json['country']),
      officialSite: json['officialSite'],
    );
  }
}
