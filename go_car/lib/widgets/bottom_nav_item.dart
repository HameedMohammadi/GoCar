// ignore_for_file: unused_import

import 'dart:js';

import 'package:flutter/material.dart';

typedef NavigationCallback = void Function(BuildContext context);

BottomNavigationBarItem buildBottomNavItem(IconData icon, ThemeData themeData,
    Size size, NavigationCallback onPressed, BuildContext context) {
  return BottomNavigationBarItem(
    icon: SizedBox(
      height: size.width * 0.12,
      width: size.width * 0.12,
      child: GestureDetector(
        onTap: () {
          onPressed(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: themeData.primaryColor.withOpacity(0.05),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Icon(
            icon,
          ),
        ),
      ),
    ),
    label: '',
  );
}
