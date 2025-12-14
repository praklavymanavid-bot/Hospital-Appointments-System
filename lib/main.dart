import 'domain/hospital_system.dart';
import 'domain/patient.dart';
import 'domain/doctor.dart';
import 'ui/appointment_schedule.dart'; 

void main() {
  print('--- Hospital Management System Initializing ---');

  final system = HospitalManagementSystem();
  final mona = Patient(
    id: 'P001',
    name: 'Mona',
    phoneNumber: '087878626',
    dateOfBirth: DateTime(1990, 01, 03),
    address: '546489',
  );
  final drKo = Doctor(
    id: 'D001',
    name: 'Dr.KO',
    phoneNumber: '097265846',
    specialization: 'Cardiology',
    licenseNumber: 'L198',
  );

  system.addPatient(mona);
  system.addDoctor(drKo);

  print(
    'System ready with ${system.patients.length} patient(s) and ${system.doctors.length} doctor(s).',
  );

  // 3. Initialize and run the UI/Scheduler flow
  final scheduler = AppointmentScheduler(system);

  // --- Demonstration of a business use case ---
  final tomorrow = DateTime.now().add(const Duration(days: 1));
  scheduler.scheduleNewAppointment(
    mona,
    drKo,
    tomorrow.copyWith(hour: 10, minute: 0),
    'Annual Physical Exam',
  );

  // Check patient's schedule
  scheduler.viewPatientAppointments(mona);

  print('--- Initialization Complete ---');
}
