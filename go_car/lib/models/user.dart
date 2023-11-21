// ignore_for_file: camel_case_types

class User {
  final String name;
  final String email;
  final int phoneNumber;
  final int? emergencyContact;
  final String password;
  final int? cnic;
  final String? dob;
  final List<String>? rentalHistory;
  final bool? license;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.emergencyContact,
    required this.password,
    this.cnic,
    this.dob,
    this.rentalHistory,
    this.license,
  });
}
