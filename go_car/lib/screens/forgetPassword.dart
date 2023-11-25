// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, avoid_print, depend_on_referenced_packages, camel_case_types, unused_import, unused_local_variable, non_constant_identifier_names, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_car/controller/api.dart';
import 'package:go_car/models/catalog.dart';
import 'package:go_car/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class forgetPassword extends StatefulWidget {
  const forgetPassword({Key? key}) : super(key: key);

  @override
  _forgetPasswordState createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  api myApi = api();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController codeController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    Widget buildTextFormField(
        String label, TextEditingController controller, bool enables) {
      return TextFormField(
        style: GoogleFonts.poppins(
          color: themeData.primaryColor,
        ),
        enabled: enables,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: size.height * 0.01,
            left: size.width * 0.04,
            right: size.width * 0.04,
          ),
          enabledBorder: textFieldBorder(),
          focusedBorder: textFieldBorder(),
          border: textFieldBorder(),
          hintStyle: GoogleFonts.poppins(
            color: themeData.primaryColor,
          ),
          labelText: label,
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), //appbar size
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: const Color(0xfff8f8f8),
          titleSpacing: 0,
          leadingWidth: size.width * 0.15,
          title: Image.asset(
            "assets/images/mainlogo.png",
            height: size.height * 0.06,
            width: size.width * 0.35,
          ),
          centerTitle: true,
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xfff8f8f8),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'Forget your Password?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              buildTextFormField('Email', emailController, false),
              SizedBox(height: 20),
              buildTextFormField('Password', passwordController, false),
              SizedBox(height: 20),
              buildTextFormField(
                  'Confirm Password', confirmpasswordController, false),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3b22a1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {},
                child: Text(
                  'Confirm',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1.0,
      ),
    );
  }
}
