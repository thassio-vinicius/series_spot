class ScheduleModel {
  final String time;
  final List<String> days;

  ScheduleModel({required this.time, required this.days});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      time: json['time'],
      days: List<String>.from(json['days']),
    );
  }
}
