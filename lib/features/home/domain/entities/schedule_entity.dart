import 'package:equatable/equatable.dart';
import 'package:series_spot/features/home/data/models/schedule_model.dart';

class ScheduleEntity extends Equatable {
  final String time;
  final List<String> days;

  const ScheduleEntity({required this.time, required this.days});

  factory ScheduleEntity.fromModel(ScheduleModel model) {
    return ScheduleEntity(
      time: model.time,
      days: model.days,
    );
  }

  @override
  List<Object> get props => [time, days];
}
