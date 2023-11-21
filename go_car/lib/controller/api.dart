// ignore_for_file: camel_case_types, avoid_print
import 'dart:convert';
import "package:flutter/foundation.dart";
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
}
