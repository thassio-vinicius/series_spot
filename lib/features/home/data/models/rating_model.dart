class RatingModel {
  final double? average;

  RatingModel({this.average});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      average: json['average']?.toDouble(),
    );
  }
}
