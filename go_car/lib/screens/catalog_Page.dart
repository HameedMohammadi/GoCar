// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names, unused_local_variable, unnecessary_null_comparison, unused_import, sort_child_properties_last, unnecessary_import

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unicons/unicons.dart';
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
    Size size = MediaQuery.of(context).size; //check the size of device
    ThemeData themeData = Theme.of(context);

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
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
