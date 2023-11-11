// ignore_for_file: camel_case_types, avoid_print
import 'dart:convert';

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
}
