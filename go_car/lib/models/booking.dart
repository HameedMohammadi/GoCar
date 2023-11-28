// ignore_for_file: camel_case_types, non_constant_identifier_names

class Booking {
  final String user_id;
  final String car_id;
  final String bookingDays;
  final String price;

  Booking(
      {required this.car_id,
      required this.bookingDays,
      required this.user_id,
      required this.price});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      car_id: json['car_id'] as String,
      bookingDays: json['bookingDays'] as String,
      user_id: json['user_id'] as String,
      price: json['price'] as String,
    );
  }
}
