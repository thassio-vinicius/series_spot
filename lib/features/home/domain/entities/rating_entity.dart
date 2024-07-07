import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/rating_model.dart';

class RatingEntity extends Equatable {
  final double? average;

  const RatingEntity({required this.average});

  factory RatingEntity.fromModel(RatingModel model) {
    return RatingEntity(average: model.average);
  }

  @override
  List<Object?> get props => [average];
}
