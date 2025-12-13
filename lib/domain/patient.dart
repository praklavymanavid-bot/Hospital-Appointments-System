// /lib/domain/patient.dart

import 'appointment.dart'; // Forward declaration of Appointment

class Patient {
  final String id;
  String name;
  String phoneNumber;
  DateTime dateOfBirth;
  String address;
  final List<Appointment> appointments = [];

  Patient({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.address,
  });

  void updatePhoneNumber(String newNumber) {
    phoneNumber = newNumber;
  }

  void updateAddress(String newAddress) {
    address = newAddress;
  }
}
