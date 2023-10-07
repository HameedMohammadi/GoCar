// ignore_for_file: non_constant_identifier_names, camel_case_types

class catalogmodel {
  static final product = {
    items(
        model: "Corolla",
        company: "Toyota",
        number: "LES 302",
        carID: 001,
        carType: "Sedan",
        current_location: "Garage",
        year: 2017,
        color: "#000000",
        price: 2000,
        imageURl: "assets/images/toyota_corolla.png")
  };
}

class items {
  final String model;
  final String company;
  final String number;
  final num carID;
  final String carType;
  final String current_location;
  final num year;
  final String color;
  final num price;
  final String imageURl;

  items(
      {required this.model,
      required this.company,
      required this.number,
      required this.carID,
      required this.carType,
      required this.current_location,
      required this.year,
      required this.color,
      required this.price,
      required this.imageURl});
}
