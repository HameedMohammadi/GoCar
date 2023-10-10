// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, prefer_const_constructors, camel_case_types
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_car/models/catalog.dart';

class productWidget extends StatelessWidget {
  final items Item;
  const productWidget({super.key, required this.Item}) : assert(Item != null);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Item.isRotated
              ? Image.asset(
                  Item.imageURl,
                  height: 80,
                  width: 80,
                )
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: Image.asset(
                    Item.imageURl,
                    height: 80,
                    width: 80,
                    fit: BoxFit.contain,
                  ),
                ),
          title: Text(Item.carType),
          subtitle: Text("${Item.company} ${Item.model} ${Item.year}"),
          trailing: Text("${Item.price}/per day",
              style: TextStyle(color: Colors.deepPurple),
              textScaleFactor: 1.3)),
    );
  }
}
