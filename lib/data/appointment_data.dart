// /lib/data/appointment_data_source.dart

import '../domain/appointment.dart';

class AppointmentData {
  void saveAppointment(Appointment appointment) {
    print(
      'DATA: Saving appointment ${appointment.id} for ${appointment.patient.name}...',
    );
  }
}
