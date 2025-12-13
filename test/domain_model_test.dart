// /test/domain_model_test.dart

// 1. Import the testing framework
import 'package:test/test.dart';

// 2. Import core domain classes using the package name 'dart_project'
import 'package:dart_project/domain/patient.dart';
import 'package:dart_project/domain/doctor.dart';
import 'package:dart_project/domain/appointment.dart';
import 'package:dart_project/domain/hospital_system.dart';

void main() {
  group('Hospital Management System Domain Tests (Consolidated Status)', () {
    late HospitalManagementSystem system;
    late Patient patient1;
    late Doctor doctor1;
    final DateTime now = DateTime.now();

    setUp(() {
      system = HospitalManagementSystem();
      patient1 = Patient(
        id: 'P001',
        name: 'Alice Smith',
        phoneNumber: '555-1234',
        dateOfBirth: DateTime(1990, 1, 1),
        address: '123 Main St',
      );
      doctor1 = Doctor(
        id: 'D001',
        name: 'Dr. John Doe',
        phoneNumber: '555-5678',
        specialization: 'Cardiology',
        licenseNumber: 'L12345',
      );
      system.addPatient(patient1);
      system.addDoctor(doctor1);
    });

    test('1. Schedule Appointment successfully', () {
      final appointmentTime = now.add(const Duration(days: 1));
      final appointment = system.scheduleAppointment(
        patient: patient1,
        doctor: doctor1,
        dateTime: appointmentTime,
        reason: 'Routine Checkup',
      );
      // AppointmentStatus is accessed via the imported appointment.dart
      expect(appointment.status, AppointmentStatus.scheduled);
      expect(system.appointments.length, 1);
    });

    test('2. Cancel Appointment', () {
      final appointmentTime = now.add(const Duration(days: 2));
      final appointment = system.scheduleAppointment(
        patient: patient1,
        doctor: doctor1,
        dateTime: appointmentTime,
        reason: 'Follow-up',
      );

      system.cancelAppointment(appointment.id);
      expect(appointment.status, AppointmentStatus.cancelled);
    });

    test('3. Reschedule Appointment', () {
      final initialTime = now.add(const Duration(days: 3));
      final newTime = now.add(const Duration(days: 5));
      final appointment = system.scheduleAppointment(
        patient: patient1,
        doctor: doctor1,
        dateTime: initialTime,
        reason: 'Initial consultation',
      );

      appointment.reschedule(newTime);
      expect(appointment.dateTime, newTime);
      expect(appointment.status, AppointmentStatus.scheduled);
    });

    test('4. Create Meeting and Complete Appointment', () {
      final apptTime = now.add(const Duration(hours: 10));
      final appointment = system.scheduleAppointment(
        patient: patient1,
        doctor: doctor1,
        dateTime: apptTime,
        reason: 'Therapy Session',
      );

      final meeting = system.createMeeting(
        appointment: appointment,
        startTime: apptTime,
        endTime: apptTime.add(const Duration(hours: 1)),
        topic: 'Session Debrief',
        location: 'Room 305',
      );

      expect(meeting, isNotNull);
      expect(system.meetings.length, 1);
      expect(appointment.status, AppointmentStatus.completed);
    });

    test('5. Cannot Create Meeting for a Cancelled Appointment', () {
      final apptTime = now.add(const Duration(days: 4));
      final appointment = system.scheduleAppointment(
        patient: patient1,
        doctor: doctor1,
        dateTime: apptTime,
        reason: 'Surgical Consult',
      );
      appointment.cancel();

      // This test ensures the system enforces the status rule
      expect(
          () => system.createMeeting(
                appointment: appointment,
                startTime: apptTime,
                endTime: apptTime.add(const Duration(minutes: 30)),
                topic: 'Final Discussion',
                location: 'Office B',
              ),
          throwsA(isA<Exception>()));
    });
  });
}
