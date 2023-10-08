import 'package:go_car/models/catalog.dart';
import 'package:go_car/widgets/car_home.dart';
import 'package:go_car/widgets/category.dart';
import 'package:flutter/material.dart';

Widget buildMostRented(Size size, ThemeData themeData) {
  return Column(
    children: [
      buildCategory('Most Rented', size, themeData),
      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.015,
          left: size.width * 0.03,
          right: size.width * 0.03,
        ),
        child: SizedBox(
          height: size.width * 0.55,
          width: catalogmodel.product.length * size.width * 0.5 * 1.03,
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: catalogmodel.product.length,
            itemBuilder: (context, i) {
              return buildCar(
                i,
                size,
                themeData,
              );
            },
          ),
        ),
      ),
    ],
  );
}
