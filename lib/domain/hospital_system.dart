import 'patient.dart';
import 'doctor.dart';
import 'appointment.dart';

class HospitalManagementSystem {
  final List<Patient> _patients = [];
  final List<Doctor> _doctors = [];
  final List<Appointment> _appointments = [];
  final List<Meeting> _meetings = [];

  List<Patient> get patients => List.unmodifiable(_patients);
  List<Doctor> get doctors => List.unmodifiable(_doctors);
  List<Appointment> get appointments => List.unmodifiable(_appointments);
  List<Meeting> get meetings => List.unmodifiable(_meetings);

  void addPatient(Patient patient) => _patients.add(patient);
  void addDoctor(Doctor doctor) => _doctors.add(doctor);

  Appointment scheduleAppointment({
    required Patient patient,
    required Doctor doctor,
    required DateTime dateTime,
    required String reason,
  }) {
    if (!doctor.isAvailable(dateTime)) {
      throw Exception("Doctor not available at this time.");
    }

    final String appointmentId = 'A-${_appointments.length + 1}';

    final appointment = Appointment(
      id: appointmentId,
      dateTime: dateTime,
      reason: reason,
      patient: patient,
      doctor: doctor,
    );

    _appointments.add(appointment);
    patient.appointments.add(appointment);
    return appointment;
  }

  void cancelAppointment(String appointmentId) {
    final appointment = _appointments.firstWhere(
      (a) => a.id == appointmentId,
      orElse: () => throw Exception('Appointment not found.'),
    );
    appointment.cancel();
  }

  Meeting createMeeting({
    required Appointment appointment,
    required DateTime startTime,
    required DateTime endTime,
    required String topic,
    required String location,
  }) {
    // Accessing the enum from the imported appointment file
    if (appointment.status != AppointmentStatus.scheduled) {
      throw Exception('Cannot create meeting for a non-scheduled appointment.');
    }

    final String meetingId = 'M-${_meetings.length + 1}';
    final meeting = Meeting(
      id: meetingId,
      startTime: startTime,
      endTime: endTime,
      topic: topic,
      location: location,
      appointment: appointment,
    );

    _meetings.add(meeting);
    appointment.complete();
    return meeting;
  }
}
