class CountryModel {
  final String name;
  final String code;
  final String timezone;

  CountryModel({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'],
      code: json['code'],
      timezone: json['timezone'],
    );
  }
}
