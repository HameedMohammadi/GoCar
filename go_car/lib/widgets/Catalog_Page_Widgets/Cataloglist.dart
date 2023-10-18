// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:go_car/screens/details.dart';
import 'Catalogitem.dart';
import 'package:go_car/models/catalog.dart';

class Cataloglist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: catalogmodel.product.length,
      itemBuilder: (BuildContext context, int index) {
        final Catalog = catalogmodel.product[index];
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(catalog: Catalog)),
          ),
          child: Catalogitem(catalog: Catalog),
        );
      },
    );
  }
}
