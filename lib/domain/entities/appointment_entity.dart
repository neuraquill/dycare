// lib/domain/entities/appointment_entity.dart

class AppointmentEntity {
  final String id;
  final String patientId;
  final String nurseId;
  final DateTime dateTime;
  final String status;
  final String? notes;

  AppointmentEntity({
    required this.id,
    required this.patientId,
    required this.nurseId,
    required this.dateTime,
    required this.status,
    this.notes,
  });

  factory AppointmentEntity.fromJson(Map<String, dynamic> json) {
    return AppointmentEntity(
      id: json['id'],
      patientId: json['patientId'],
      nurseId: json['nurseId'],
      dateTime: DateTime.parse(json['dateTime']),
      status: json['status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'nurseId': nurseId,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
      'notes': notes,
    };
  }
}