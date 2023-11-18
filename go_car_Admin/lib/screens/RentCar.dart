// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:rest_apis/controller/api.dart';

class RentCar extends StatefulWidget {
  @override
  _RentCarState createState() => _RentCarState();
}

class _RentCarState extends State<RentCar> {
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
        title: Text('Rent Car Page'),
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
                      bool currentAvailability = car['availabilty'] ?? false;
                      try {
                        bool updatedStatus = await myApi.carRentStatus(
                            car['_id'], !currentAvailability);
                        setState(() {
                          snapshot.data![index]['availabilty'] = updatedStatus;
                        });
                      } catch (err) {
                        print('Failed to update kehheh: $err');
                      }

                      //myApi.carRentStatus(car['_id'], !currentAvailability);
                    },
                    child: Text(
                      car['availabilty'] ? 'Rent' : 'UnRent',
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
