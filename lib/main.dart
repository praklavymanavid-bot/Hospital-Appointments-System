// /lib/main.dart

import 'domain/hospital_system.dart';
import 'domain/patient.dart';
import 'domain/doctor.dart';
import 'ui/appointment_schedule.dart'; // Imports the UI stub

void main() {
  print('--- Hospital Management System Initializing ---');

  // 1. Initialize the Core Domain System
  final system = HospitalManagementSystem();

  // 2. Add Initial Entities
  final alice = Patient(
    id: 'P001',
    name: 'Alice Smith',
    phoneNumber: '555-1234',
    dateOfBirth: DateTime(1990, 1, 1),
    address: '123 Main St',
  );
  final drDoe = Doctor(
    id: 'D001',
    name: 'Dr. John Doe',
    phoneNumber: '555-5678',
    specialization: 'Cardiology',
    licenseNumber: 'L12345',
  );

  system.addPatient(alice);
  system.addDoctor(drDoe);

  print(
    'System ready with ${system.patients.length} patient(s) and ${system.doctors.length} doctor(s).',
  );

  // 3. Initialize and run the UI/Scheduler flow
  final scheduler = AppointmentScheduler(system);

  // --- Demonstration of a business use case ---
  final tomorrow = DateTime.now().add(const Duration(days: 1));
  scheduler.scheduleNewAppointment(
    alice,
    drDoe,
    tomorrow.copyWith(hour: 10, minute: 0),
    'Annual Physical Exam',
  );

  // Check patient's schedule
  scheduler.viewPatientAppointments(alice);

  print('--- Initialization Complete ---');
}
