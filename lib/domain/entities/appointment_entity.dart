class AppointmentEntity {
  final int id;
  final String userId;
  final String workerId;
  final DateTime time;
  final int hours;

  AppointmentEntity({
    required this.id,
    required this.userId,
    required this.workerId,
    required this.time,
    required this.hours,
  });

  factory AppointmentEntity.fromJson(Map<String, dynamic> json) {
    return AppointmentEntity(
      id: json['id'] as int,
      userId: json['userID'] as String,
      workerId: json['workerID'] as String,
      time: DateTime.parse(json['time'] as String),
      hours: json['hours'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userId,
      'workerID': workerId,
      'time': time.toIso8601String(),
      'hours': hours,
    };
  }
}
