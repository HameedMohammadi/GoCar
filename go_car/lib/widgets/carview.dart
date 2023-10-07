// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:go_car/models/catalog.dart';

class productWidget extends StatelessWidget {
  final items Item;
  const productWidget({super.key, required this.Item}) : assert(Item != null);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Image.asset(Item.imageURl),
          title: Text(Item.carType),
          subtitle: Text("${Item.company} ${Item.model} ${Item.year}"),
          trailing: Text("${Item.price}/per day",
              style: TextStyle(color: Colors.deepPurple),
              textScaleFactor: 1.3)),
    );
  }
}
