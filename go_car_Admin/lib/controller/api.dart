// ignore_for_file: camel_case_types, avoid_print
import 'dart:convert';
//import 'dart:ffi';

import "package:flutter/foundation.dart";
import 'package:http/http.dart' as http;

class api {
  final String baseURL = "http://localhost:3007/api/car";

  Future<void> addCar(Map udata) async {
    try {
      final res = await http.post(Uri.parse(baseURL),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(udata));
      if (res.statusCode == 201) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("failed to get response");
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getAllCars() async {
    try {
      final response = await http.get(Uri.parse(baseURL));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Map<String, dynamic>> cars = List<Map<String, dynamic>>.from(
          data.map((car) => Map<String, dynamic>.from(car)),
        );
        return cars;
      } else {
        throw Exception('Failed to load cars');
      }
    } catch (err) {
      throw Exception('Failed to load cars: $err');
    }
  }

  Future<bool> carRentStatus(String carId, bool isAvailable) async {
    final String apiUrl = 'http://localhost:3007/api/car/$carId';
    try {
      final response = await http
          .put(Uri.parse(apiUrl), body: {'avail': isAvailable.toString()});
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('message') &&
            responseData['message'] ==
                'Car availability updated successfully') {
          return true; // Return true if the update was successful
        } else {
          throw Exception('Failed to update car avail');
        }
      } else {
        throw Exception('Failed to update car avail');
      }
    } catch (err) {
      throw Exception('Failed to update : $err');
    }
  }
}
