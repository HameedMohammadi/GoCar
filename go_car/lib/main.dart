// ignore_for_file: prefer_const_constructors, unused_import, non_constant_identifier_names, avoid_print, prefer_const_declarations

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_car/screens/catalog_Page.dart';
import 'package:go_car/screens/details.dart';
import 'package:go_car/screens/login_signup.dart';
import 'package:go_car/screens/loginPage.dart';
import 'package:go_car/screens/signupPage.dart';
import 'package:go_car/screens/home.dart';
import 'package:go_car/utilities/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_car/widgets/theme.dart';
import 'package:go_car/models/catalog.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mytheme.lighttheme(context),
      routes: {
        MyRoutes.mainRoute: (context) => Login(),
        //MyRoutes.mainRoute: (context) => login_signup(),
        MyRoutes.signupRoute: (context) => signup(),
        MyRoutes.homeRoute: (context) => home(),
        MyRoutes.catalogRoute: (context) => catalog_page()
      },
    );
  }
}

Future<void> loadData() async {
  try {
    final String baseURL = "http://localhost:3007/api/car";

    final response = await http.get(Uri.parse(baseURL));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<items> filteredItems = List.from(data)
          .where((item) => item['status'] != false)
          .map<items>((item) => items.fromMap(item))
          .toList();
      catalogmodel.product = filteredItems;
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error loading data: $e');
  }
}
