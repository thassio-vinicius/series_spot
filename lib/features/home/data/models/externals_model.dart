class ExternalsModel {
  final int? tvRage;
  final int? theTvDb;
  final String? imdb;

  ExternalsModel({
    this.tvRage,
    this.theTvDb,
    this.imdb,
  });

  factory ExternalsModel.fromJson(Map<String, dynamic> json) {
    return ExternalsModel(
      tvRage: json['tvrage'],
      theTvDb: json['thetvdb'],
      imdb: json['imdb'],
    );
  }
}
