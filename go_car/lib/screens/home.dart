// ignore_for_file: prefer_const_constructors, unused_import, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:go_car/models/catalog.dart';
import 'package:go_car/models/user.dart';
import 'package:go_car/screens/details.dart';
import 'package:go_car/widgets/bottom_nav_bar.dart';
import 'package:go_car/widgets/drawer.dart';
import 'package:go_car/widgets/most_rented.dart';
import 'package:go_car/widgets/top_brands.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<home> {
  List<items> searchResults = [];
  TextEditingController searchController = TextEditingController();
  Size size = Size.zero;
  ThemeData themeData = ThemeData();
  User? loggedInUser;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    themeData = Theme.of(context);

    void onSearchTextChanged(String text) {
      setState(() {
        if (text.isEmpty) {
          searchResults = [];
        } else {
          searchResults = catalogmodel.product
              .where((item) =>
                  item.model.toLowerCase().contains(text.toLowerCase()))
              .toList();
        }
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
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
      bottomNavigationBar: buildBottomNavBar(1, size, themeData, context),
      backgroundColor: const Color(0xfff8f8f8),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.04,
                left: size.width * 0.05,
                right: size.width * 0.05,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: themeData.cardColor,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.04,
                      ),
                      child: Align(
                        child: Text(
                          'With Corporate Difference',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: themeData.secondaryHeaderColor,
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.01,
                      ),
                      child: Align(
                        child: Text(
                          'Enjoy the fun driving in Enterprise',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: themeData.secondaryHeaderColor,
                            fontSize: size.width * 0.035,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.03,
                        left: size.width * 0.04,
                        bottom: size.height * 0.025,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.8,
                            height: size.height * 0.06,
                            child: TextField(
                              controller: searchController,
                              onChanged: onSearchTextChanged,
                              style: TextStyle(
                                color: themeData.primaryColor,
                              ),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.width * 0.04,
                                  right: size.width * 0.04,
                                ),
                                enabledBorder: textFieldBorder(),
                                focusedBorder: textFieldBorder(),
                                border: textFieldBorder(),
                                hintStyle: TextStyle(
                                  color: themeData.primaryColor,
                                ),
                                hintText: 'Search a car',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (searchResults.isNotEmpty)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              searchResults.length,
                              (index) => ListTile(
                                title: Text(searchResults[index].model),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                        catalog: searchResults[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            buildTopBrands(context, size, themeData),
            buildMostRented(context, size, themeData),
          ],
        ),
      ),
      drawer: mydrawer(),
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1.0,
      ),
    );
  }
}
