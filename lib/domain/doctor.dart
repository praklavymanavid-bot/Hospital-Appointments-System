// /lib/domain/doctor.dart

class Doctor {
  final String id;
  String name;
  String phoneNumber;
  String specialization;
  String licenseNumber;

  Doctor({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.specialization,
    required this.licenseNumber,
  });

  void updatePhoneNumber(String newNumber) {
    phoneNumber = newNumber;
  }

  bool isAvailable(DateTime time) {
    return true;
  }
}
