// /lib/domain/appointment.dart

import 'patient.dart';
import 'doctor.dart';

// The status enum is defined here
enum AppointmentStatus { scheduled, completed, cancelled, noShow }

class Appointment {
  final String id;
  DateTime dateTime;
  String reason;
  AppointmentStatus status;
  final Patient patient;
  final Doctor doctor;

  Appointment({
    required this.id,
    required this.dateTime,
    required this.reason,
    required this.patient,
    required this.doctor,
    this.status = AppointmentStatus.scheduled,
  });

  void cancel() {
    status = AppointmentStatus.cancelled;
  }

  void complete() {
    status = AppointmentStatus.completed;
  }

  void reschedule(DateTime newDateTime) {
    if (doctor.isAvailable(newDateTime)) {
      dateTime = newDateTime;
      status = AppointmentStatus.scheduled;
    } else {
      throw Exception("Doctor is not available at the requested time.");
    }
  }
}

class Meeting {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String topic;
  final String location;
  final Appointment appointment;

  Meeting({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.topic,
    required this.location,
    required this.appointment,
  });
}
