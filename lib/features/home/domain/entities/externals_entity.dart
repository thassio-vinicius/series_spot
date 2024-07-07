import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/externals_model.dart';

class ExternalsEntity extends Equatable {
  final int? tvRage;
  final int? theTvDb;
  final String? imdb;

  const ExternalsEntity({
    required this.tvRage,
    required this.theTvDb,
    required this.imdb,
  });

  factory ExternalsEntity.fromModel(ExternalsModel model) {
    return ExternalsEntity(
      tvRage: model.tvRage,
      theTvDb: model.theTvDb,
      imdb: model.imdb,
    );
  }

  @override
  List<Object?> get props => [tvRage, theTvDb, imdb];
}
