// ignore_for_file: prefer_const_constructors, deprecated_member_use, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class mytheme {
  static ThemeData lighttheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.lato().fontFamily,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: Theme.of(context).textTheme.headline6,
            centerTitle: true),
        textTheme: TextTheme(
          bodyText2: GoogleFonts.poppins(color: Colors.black),
        ),
        cardColor: Colors.white,
      );
}
