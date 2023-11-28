// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types

import 'package:flutter/material.dart';
import 'package:rest_apis/controller/api.dart';
import 'package:rest_apis/screens/updatesinglecar.dart';

class updateCar extends StatefulWidget {
  @override
  _updateCarstate createState() => _updateCarstate();
}

class _updateCarstate extends State<updateCar> {
  final api myApi = api();
  late Future<List<Map<String, dynamic>>> futureCars;

  @override
  void initState() {
    super.initState();
    futureCars = myApi.getAllCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Car Page'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureCars,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cars available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final car = snapshot.data![index];
                return ListTile(
                  leading: Image.network(
                    car['imageURl'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(car['model']),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  updatesingle(carid: car['_id'])),
                        );
                      });
                    },
                    child: Text(
                      'Update',
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
