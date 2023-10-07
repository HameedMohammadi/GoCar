// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_car/models/catalog.dart';
import 'package:go_car/widgets/carview.dart';
import 'package:go_car/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  final days = 30;
  final name = "Ammad";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: catalogmodel.product.length,
          itemBuilder: (context, index) {
            return productWidget(
              Item: catalogmodel.product.toList()[index],
            );
          },
        ),
      ),
      drawer: mydrawer(),
    );
  }
}
