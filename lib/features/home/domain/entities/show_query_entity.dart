import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/show_query_model.dart';
import 'package:series_spot/features/home/domain/entities/show_entity.dart';

class ShowQueryEntity extends Equatable {
  final double score;
  final ShowEntity show;

  const ShowQueryEntity({required this.score, required this.show});

  factory ShowQueryEntity.fromModel(ShowQueryModel model) {
    return ShowQueryEntity(
      score: model.score,
      show: ShowEntity.fromModel(model.show),
    );
  }

  @override
  List<Object?> get props => [score, show];
}
