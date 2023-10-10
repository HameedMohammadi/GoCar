// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names, unused_local_variable, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_car/models/catalog.dart';
import 'package:go_car/widgets/carview.dart';
import 'package:go_car/widgets/drawer.dart';

class catalog_page extends StatefulWidget {
  @override
  State<catalog_page> createState() => _catalog_pageState();
}

class _catalog_pageState extends State<catalog_page> {
  @override
  void initState() {
    super.initState();
    loadData() async {
      final catalog_json =
          await rootBundle.loadString("assets/files/catalog.json");
      final decodeData = jsonDecode(catalog_json);
      var productsData = decodeData["products"];
      print(productsData);
      catalogmodel.product = List.from(productsData)
          .map<items>((item) => items.fromMap(item))
          .toList();
      setState(() {});
    }

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GoCar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (catalogmodel.product != null && catalogmodel.product.isNotEmpty)
            ? ListView.builder(
                itemCount: catalogmodel.product.length,
                itemBuilder: (context, index) {
                  return productWidget(
                    Item: catalogmodel.product[index],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      drawer: mydrawer(),
    );
  }
}
