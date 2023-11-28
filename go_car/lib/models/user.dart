// ignore_for_file: camel_case_types

class User {
  final String name;
  final String email;
  final String phonenumber;
  final String? emergencyContact;
  final String password;
  final String? cnic;
  final String? dob;
  final List<String>? rentalHistory;
  final bool? license;

  User({
    required this.name,
    required this.email,
    required this.phonenumber,
    this.emergencyContact,
    required this.password,
    this.cnic,
    this.dob,
    this.rentalHistory,
    this.license,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'] as String,
        email: json['email'] as String,
        phonenumber: json['phonenumber'] as String,
        emergencyContact: json['emergencycontact'] as String?,
        cnic: json['cnic'] as String?,
        dob: json['dob'] as String?,
        rentalHistory: (json['rentalhistory'] as List<dynamic>?)
                ?.map((history) => history.toString())
                .toList() ??
            [],
        license: json['license'] as bool?,
        password: json['password'] as String
        // Extract and assign other properties from the JSON object here...
        );
  }
}

//For the data user that entered into the App.
class Session {
  static User? loggedInUser; // Store the logged-in user data

  static void login(User user) {
    loggedInUser = user;
  }

  static void logout() {
    loggedInUser = null;
  }

  static bool isLoggedIn() {
    return loggedInUser != null;
  }
}
