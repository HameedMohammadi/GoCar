import 'dart:math';
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
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: Vx.mH12,
              children: [
                catalog.price.text.make(),
                ElevatedButton(
                  onPressed: () {},
                  child: "Book".text.make(),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(mytheme.bluish)),
                )
              ],
            ).pOnly(left: 2.0)
          ],
        ))
      ],
    )).white.rounded.square(100).make().p16();
  }
}
