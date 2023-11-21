// ignore_for_file: camel_case_types, avoid_print, unused_import, prefer_const_declarations
import 'dart:convert';
import "package:flutter/foundation.dart";
import 'package:get/get.dart';
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

  Future<bool> loginUser(String name, String password) async {
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
        return true;
      } else if (response.statusCode == 401) {
        print("Invalid Credentials");
        return false;
      } else if (response.statusCode == 404) {
        print("User Not Found");
        return false;
      } else {
        print('Login failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error : $error');
    }
    return false;
  }
}
