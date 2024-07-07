class PreviousEpisodeModel {
  final String href;
  final String name;

  PreviousEpisodeModel({required this.href, required this.name});

  factory PreviousEpisodeModel.fromJson(Map<String, dynamic> json) {
    return PreviousEpisodeModel(
      href: json['href'],
      name: json['name'],
    );
  }
}
