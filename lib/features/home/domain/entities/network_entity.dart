import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/network_model.dart';
import 'package:series_spot/features/home/domain/entities/country_entity.dart';

class NetworkEntity extends Equatable {
  final int id;
  final String name;
  final CountryEntity country;
  final String? officialSite;

  const NetworkEntity({
    required this.id,
    required this.name,
    required this.country,
    this.officialSite,
  });

  factory NetworkEntity.fromModel(NetworkModel model) {
    return NetworkEntity(
      id: model.id,
      name: model.name,
      country: CountryEntity.fromModel(model.country),
      officialSite: model.officialSite,
    );
  }

  @override
  List<Object?> get props => [id, name, country, officialSite];
}
