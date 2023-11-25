// ignore_for_file: camel_case_types, avoid_print, unused_import, prefer_const_declarations
import 'dart:convert';
import "package:flutter/foundation.dart";
import 'package:get/get.dart';
import 'package:go_car/models/user.dart';
import 'package:http/http.dart' as http;

class api {
  final String userURL = "http://localhost:3007/api/user";
  Future<void> addUser(Map userData) async {
    try {
      final response = await http.post(
        Uri.parse(userURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        print(data);
      } else {
        print("Failed to get a successful response");
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<Map<String, dynamic>> updateUser(
      Map<String, dynamic> updateData, String id) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3007/api/user/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to update user: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to update user: $error');
    }
  }

  Future<String?> loginUser(String name, String password) async {
    final String loginURL = "http://localhost:3007/api/login";
    try {
      final Map<String, String> data = {
        'name': name,
        'password': password,
      };
      final response = await http.post(
        Uri.parse(loginURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String token = responseData['token'];
        String userName = responseData['userName'];
        String userID = responseData['userid'];
        print('Logged in successfully');
        print('Token: $token');
        print('User Name: $userName');
        print('User ID: $userID');
        return userID;
      } else if (response.statusCode == 401) {
        print("Invalid Credentials");
        return null;
      } else if (response.statusCode == 404) {
        print("User Not Found");
        return null;
      } else {
        print('Login failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error : $error');
    }
    return null;
  }

  Future<User?> fetchUserData(String userID) async {
    final String getUserDataURL = "http://localhost:3007/api/user/$userID";
    try {
      final response = await http.get(Uri.parse(getUserDataURL));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        User userData = User.fromJson(responseData);
        return userData;
      } else {
        print(
            'Failed to fetch user data with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error : $error');
      return null;
    }
  }

  Future<String?> bookCar(Map userData) async {
    final String bookingURL = "http://localhost:3007/api/BookCar";

    try {
      final response = await http.post(
        Uri.parse(bookingURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );
      if (response.statusCode == 201) {
        var responseData = json.decode(response.body);
        var bookingId = responseData['_id'];
        return bookingId;
      } else {
        print("Failed to get a successful response");
        return null;
      }
    } catch (error) {
      debugPrint(error.toString());
      return null;
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

  Future<void> rentHistory(String userId, String newItem) async {
    final String apiUrl = 'http://localhost:3007/api/user/$userId/renthistory';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      'newbooking': newItem,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        print('Item added successfully');
      } else {
        print('Failed to add item: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding item: $error');
    }
  }
}
