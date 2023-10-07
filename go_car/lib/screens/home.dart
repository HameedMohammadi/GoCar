// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:go_car/widgets/drawer.dart';

class home extends StatelessWidget {
  final days = 30;
  final name = "Ammad";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog App"),
      ),
      body: Center(
          child: Container(
        child: Text("Welcome to $days days of flutter by $name"),
      )),
      drawer: mydrawer(),
    );
  }
}
