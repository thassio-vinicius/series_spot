import 'package:series_spot/features/home/data/models/show_model.dart';

class ShowQueryModel {
  final double score;
  final ShowModel show;

  ShowQueryModel({required this.score, required this.show});

  factory ShowQueryModel.fromJson(Map<String, dynamic> json) {
    return ShowQueryModel(
      score: json['score'],
      show: ShowModel.fromJson(json['show']),
    );
  }
}
