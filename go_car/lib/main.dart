// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:go_car/screens/catalog_Page.dart';
import 'package:go_car/screens/login_signup.dart';
import 'package:go_car/screens/loginPage.dart';
import 'package:go_car/screens/signupPage.dart';
import 'package:go_car/screens/home.dart';
import 'package:go_car/utilities/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_car/widgets/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
