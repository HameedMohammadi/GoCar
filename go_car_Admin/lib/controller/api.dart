// ignore_for_file: camel_case_types, avoid_print
import 'dart:convert';
//import 'dart:ffi';

import "package:flutter/foundation.dart";
import 'package:http/http.dart' as http;
import 'package:rest_apis/models/car.dart';

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

  Future<Map<String, dynamic>> updateCar(
      Map<String, dynamic> updateData, String id) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3007/api/car/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to update car: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to update car: $error');
    }
  }

  Future<car?> fetchCarData(String carID) async {
    final String getcarURL = "http://localhost:3007/api/car/$carID";
    try {
      final response = await http.get(Uri.parse(getcarURL));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        car cardata = car.fromJson(responseData);
        return cardata;
      } else {
        print(
            'Failed to fetch car data with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error : $error');
      return null;
    }
  }
}
