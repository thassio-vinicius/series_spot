import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/country_model.dart';

class CountryEntity extends Equatable {
  final String name;
  final String code;
  final String timezone;

  const CountryEntity({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory CountryEntity.fromModel(CountryModel model) {
    return CountryEntity(
      name: model.name,
      code: model.code,
      timezone: model.timezone,
    );
  }

  @override
  List<Object> get props => [name, code, timezone];
}
