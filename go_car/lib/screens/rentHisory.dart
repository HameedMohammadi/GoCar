// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names, unused_local_variable, unnecessary_null_comparison, unused_import, sort_child_properties_last

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_car/controller/api.dart';
import 'package:go_car/models/booking.dart';
import 'package:go_car/models/user.dart';
import 'package:unicons/unicons.dart';

import 'package:go_car/models/catalog.dart';
import 'package:go_car/widgets/carview.dart';
import 'package:go_car/widgets/drawer.dart';
import 'package:go_car/widgets/theme.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:go_car/widgets/Catalog_Page_Widgets/Catalogitem.dart';
import 'package:go_car/widgets/Catalog_Page_Widgets/Cataloglist.dart';

class rentHistory extends StatefulWidget {
  @override
  State<rentHistory> createState() => _rentHistorystate();
}

class _rentHistorystate extends State<rentHistory> {
  api myApi = api();
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    loggedInUser = Session.loggedInUser;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    Widget showHistory() {
      return FutureBuilder(
        future: Future.wait(
          loggedInUser!.rentalHistory!.map((rentID) {
            return myApi.fetchbookingData(rentID);
          }).toList(),
        ),
        builder:
            (BuildContext context, AsyncSnapshot<List<Booking?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error loading data');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No rental history found');
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final Booking? bookingDetails = snapshot.data![index];
                return FutureBuilder(
                  future: myApi.fetchCarData(bookingDetails!.car_id),
                  builder: (BuildContext context,
                      AsyncSnapshot<items?> carSnapshot) {
                    if (carSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (carSnapshot.hasError) {
                      return Text('Error loading car data');
                    } else if (!carSnapshot.hasData ||
                        carSnapshot.data == null) {
                      return Text('No car data found');
                    } else {
                      // Display car data attributes here
                      final items carData = carSnapshot.data!;
                      return ListTile(
                        title: Text(
                          'Car Name: ${carData.model}, Car Year: ${carData.year}',
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
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
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [showHistory().expand()],
          ),
        ),
      ),
    );
  }
}
