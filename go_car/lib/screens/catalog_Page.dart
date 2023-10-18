// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names, unused_local_variable, unnecessary_null_comparison, unused_import, sort_child_properties_last

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_car/models/catalog.dart';
import 'package:go_car/widgets/carview.dart';
import 'package:go_car/widgets/drawer.dart';
import 'package:go_car/widgets/theme.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:go_car/widgets/Catalog_Page_Widgets/Catalogitem.dart';
import 'package:go_car/widgets/Catalog_Page_Widgets/Cataloglist.dart';

class catalog_page extends StatefulWidget {
  @override
  State<catalog_page> createState() => _catalog_pageState();
}

class _catalog_pageState extends State<catalog_page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "GoCar".text.xl5.bold.color(mytheme.bluish).make(),
              if (catalogmodel.product != null &&
                  catalogmodel.product.isNotEmpty)
                Cataloglist().expand()
              else
                Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }
}
