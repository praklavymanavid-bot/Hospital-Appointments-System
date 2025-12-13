// /lib/ui/appointment_scheduler_screen.dart

import '../domain/hospital_system.dart';
import '../domain/patient.dart';
import '../domain/doctor.dart';
import '../data/appointment_data.dart';

class AppointmentScheduler {
  final HospitalManagementSystem _system;
  final AppointmentData _dataSource = AppointmentData();

  AppointmentScheduler(this._system);

  void scheduleNewAppointment(
    Patient patient,
    Doctor doctor,
    DateTime time,
    String reason,
  ) {
    try {
      final newAppt = _system.scheduleAppointment(
        patient: patient,
        doctor: doctor,
        dateTime: time,
        reason: reason,
      );
      _dataSource.saveAppointment(newAppt);
      print(
        'UI: ✅ Successfully scheduled and saved appointment ${newAppt.id}.',
      );
    } catch (e) {
      print('UI: ❌ Error scheduling appointment: ${e.toString()}');
    }
  }

  void viewPatientAppointments(Patient patient) {
    print('\nUI: --- Appointments for ${patient.name} ---');
    if (patient.appointments.isEmpty) {
      print('UI: No scheduled appointments.');
      return;
    }
    for (var appt in patient.appointments) {
      print(
        'UI: - ID: ${appt.id}, Date: ${appt.dateTime}, Status: ${appt.status.name}',
      );
    }
  }
}
