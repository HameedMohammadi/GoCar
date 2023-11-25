// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, avoid_print, depend_on_referenced_packages, camel_case_types, unused_import, unused_local_variable, non_constant_identifier_names, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_car/controller/api.dart';
import 'package:go_car/models/catalog.dart';
import 'package:go_car/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class editUser extends StatefulWidget {
  const editUser({Key? key}) : super(key: key);

  @override
  _editUserState createState() => _editUserState();
}

class _editUserState extends State<editUser> {
  User? loggedInUser;
  api myApi = api();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loggedInUser = Session.loggedInUser;
    nameController.text = loggedInUser?.name ?? '';
    emailController.text = loggedInUser?.email ?? '';
    phonenumberController.text = loggedInUser?.phonenumber ?? '';
    dobController.text = loggedInUser?.dob ?? '';
    cnicController.text = loggedInUser?.cnic ?? '';
    passwordController.text = loggedInUser?.password ?? '';
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
                'Personal Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              buildTextFormField('Email', emailController, true),
              SizedBox(height: 20),
              buildTextFormField('Password', passwordController, true),
              SizedBox(height: 20),
              buildTextFormField('User Name', nameController, true),
              SizedBox(height: 20),
              buildTextFormField('CNIC', cnicController, true),
              SizedBox(height: 20),
              buildTextFormField('Phone Number', phonenumberController, true),
              SizedBox(height: 20),
              buildTextFormField('Date of Birth', dobController, true),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3b22a1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () async {
                    String? loginUserID = await myApi.loginUser(
                        loggedInUser!.name, loggedInUser!.password);
                    String USERID = loginUserID ?? '';
                    final Map<String, dynamic> data = {
                      "name": nameController.text,
                      "email": emailController.text,
                      "password": passwordController.text,
                      "phonenumber": phonenumberController.text,
                      "cnic": cnicController.text,
                      "dob": dobController.text,
                    };
                    await myApi.updateUser(data, USERID);
                    final updatedUser = await myApi.fetchUserData(USERID);
                    if (updatedUser != null) {
                      setState(() {
                        loggedInUser = updatedUser;
                      });
                    } else {
                      print('didn update');
                    }
                  },
                  child: Text(
                    'Update',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ]),
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
