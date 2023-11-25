// ignore_for_file: prefer_const_constructors, avoid_web_libraries_in_flutter, unused_import

import 'dart:js';

import 'package:go_car/screens/editUser.dart';
import 'package:go_car/screens/home.dart';
import 'package:go_car/widgets/bottom_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

Widget buildBottomNavBar(
    int currIndex, Size size, ThemeData themeData, BuildContext context) {
  return BottomNavigationBar(
    iconSize: size.width * 0.07,
    elevation: 0,
    selectedLabelStyle: const TextStyle(fontSize: 0),
    unselectedLabelStyle: const TextStyle(fontSize: 0),
    currentIndex: currIndex,
    backgroundColor: const Color(0x00ffffff),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: themeData.brightness == Brightness.dark
        ? Colors.indigoAccent
        : Colors.black,
    unselectedItemColor: const Color(0xff3b22a1),
    onTap: (value) {
      if (value != currIndex) {
        if (value == 1) {
          Get.off(home());
        }
      }
    },
    items: [
      buildBottomNavItem(UniconsLine.bell, themeData, size, (ctx) {
        Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => editUser()));
      }, context),
      buildBottomNavItem(UniconsLine.map_marker, themeData, size, (ctx) {
        Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => editUser()));
      }, context),
      buildBottomNavItem(UniconsLine.user, themeData, size, (ctx) {
        Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => editUser()));
      }, context),
      buildBottomNavItem(UniconsLine.apps, themeData, size, (ctx) {
        Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => editUser()));
      }, context),
    ],
  );
}
