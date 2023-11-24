// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api

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

  Future<void> updateCarAvailability(String carId, bool newStatus) async {
    try {
      await myApi.updateCar({'avail': newStatus}, carId);
    } catch (err) {
      print('Failed to update: $err');
    }
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
                      final bool originalStatus = car['avail'] ?? false;
                      final bool updatedStatus = !originalStatus;
                      await updateCarAvailability(car['_id'], updatedStatus);
                      setState(() {
                        car['avail'] = updatedStatus;
                      });
                    },
                    child: Text(
                      car['avail'] ? 'Rent' : 'UnRent',
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
