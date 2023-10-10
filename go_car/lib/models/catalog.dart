// ignore_for_file: non_constant_identifier_names, camel_case_types

class catalogmodel {
  static List<items> product = [];
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
  final bool isRotated;
  final num carRating;

  items({
    required this.model,
    required this.company,
    required this.number,
    required this.carID,
    required this.carType,
    required this.current_location,
    required this.year,
    required this.color,
    required this.price,
    required this.imageURl,
    required this.isRotated,
    required this.carRating,
  });
  factory items.fromMap(Map<String, dynamic> map) {
    return items(
        model: map["model"],
        company: map["company"],
        number: map["number"],
        carID: map["carID"],
        carType: map["carType"],
        current_location: map["current_location"],
        year: map["year"],
        color: map["color"],
        price: map["price"],
        imageURl: map["imageURL"],
        isRotated: map["isRotated"],
        carRating: map["carRating"]);
  }
  toMap() => {
        "model": model,
        "company": company,
        "number": number,
        "carID": carID,
        "carType": carType,
        "current_location": current_location,
        "year": year,
        "color": color,
        "price": price,
        "imageURL": imageURl,
        "isRotated": isRotated,
        "carRating": carRating
      };
}
