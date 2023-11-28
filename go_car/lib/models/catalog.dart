// ignore_for_file: non_constant_identifier_names, camel_case_types

class catalogmodel {
  static List<items> product = [];
}

class items {
  final String id;
  final String model;
  final String company;
  final String number;
  final String carType;
  final String current_location;
  final num year;
  final String color;
  final num price;
  final String imageURl;
  final bool isRotated;
  final num carRating;
  final num carpower;
  final String people;
  final String bags;
  final bool avail;
  final bool status;
  items(
      {required this.id,
      required this.model,
      required this.company,
      required this.number,
      required this.carType,
      required this.current_location,
      required this.year,
      required this.color,
      required this.price,
      required this.imageURl,
      required this.isRotated,
      required this.carRating,
      required this.carpower,
      required this.people,
      required this.bags,
      required this.avail,
      required this.status});
  factory items.fromMap(Map<String, dynamic> map) {
    return items(
        id: map['_id'],
        model: map["model"],
        company: map["company"],
        number: map["number"],
        carType: map["carType"],
        current_location: map["current_location"],
        year: map["year"],
        color: map["color"],
        price: map["price"],
        imageURl: map["imageURl"],
        isRotated: map["isRotated"],
        carRating: map["carRating"],
        carpower: map["carpower"],
        people: map["people"],
        bags: map["bags"],
        avail: map["avail"],
        status: map["status"]);
  }
  toMap() => {
        "_id": id,
        "model": model,
        "company": company,
        "number": number,
        "carType": carType,
        "current_location": current_location,
        "year": year,
        "color": color,
        "price": price,
        "imageURL": imageURl,
        "isRotated": isRotated,
        "carRating": carRating,
        "carpower": carpower,
        "people": people,
        "bags": bags,
        "avail": avail,
        "status": status
      };
  factory items.fromJson(Map<String, dynamic> json) {
    return items(
        id: json['_id'] as String,
        model: json["model"] as String,
        company: json["company"] as String,
        number: json["number"] as String,
        carType: json["carType"] as String,
        current_location: json["current_location"] as String,
        year: json["year"] as num,
        color: json["color"] as String,
        price: json["price"] as num,
        imageURl: json["imageURl"] as String,
        isRotated: json["isRotated"] as bool,
        carRating: json["carRating"] as num,
        carpower: json["carpower"] as num,
        people: json["people"] as String,
        bags: json["bags"] as String,
        avail: json["avail"] as bool,
        status: json["status"] as bool);
  }
}
