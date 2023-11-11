// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:math';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_car/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_car/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class Catalogitem extends StatelessWidget {
  final items catalog;

  const Catalogitem({super.key, required this.catalog});
  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        catalog.isRotated
            ? Image.network(catalog.imageURl).box.make().p16().w32(context)
            : Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: Image.network(catalog.imageURl)
                    .box
                    .make()
                    .p16()
                    .w32(context)),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalog.carType.text.lg.color(mytheme.bluish).bold.make(),
            Row(
              children: [
                catalog.company.text.textStyle(context.captionStyle).make(),
                SizedBox(
                  width: 2,
                ),
                catalog.model.text.textStyle(context.captionStyle).make(),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBar(
                  initialRating: catalog.carRating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  ratingWidget: RatingWidget(
                      full: Icon(Icons.star, color: Colors.amber),
                      half: Icon(Icons.star_half, color: Colors.amber),
                      empty: Icon(Icons.star_border, color: Colors.amber)),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                  itemSize: 16.0,
                )
              ],
            )
          ],
        ))
      ],
    )).white.rounded.square(100).make().p16();
  }
}
