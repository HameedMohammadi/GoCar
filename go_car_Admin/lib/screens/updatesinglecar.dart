// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, camel_case_types, avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:rest_apis/controller/api.dart';
import 'package:rest_apis/models/car.dart'; // Import your API class here

class updatesingle extends StatefulWidget {
  final String carid;
  const updatesingle({Key? key, required this.carid}) : super(key: key);

  @override
  State<updatesingle> createState() => _UpdateSingleState();
}

class _UpdateSingleState extends State<updatesingle> {
  api myApi = api();
  var modelcontroller = TextEditingController();
  var companycontroller = TextEditingController();
  var numbercontroller = TextEditingController();
  var carTypecontroller = TextEditingController();
  var currentlocationcontroller = TextEditingController();
  var yearcontroller = TextEditingController();
  var colorcontroller = TextEditingController();
  var pricecontroller = TextEditingController();
  var imageURLcontroller = TextEditingController();
  var isRotatedcontroller = TextEditingController();
  var carRatingcontroller = TextEditingController();
  var carpowercontroller = TextEditingController();
  var peoplecontroller = TextEditingController();
  var bagscontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCarDetails();
  }

  Future<void> updateCarAvailability(String carId, bool newStatus) async {
    try {
      await myApi.updateCar({'status': newStatus}, carId);
    } catch (err) {
      print('Failed to update: $err');
    }
  }

  Future<void> fetchCarDetails() async {
    print(widget.carid);
    try {
      final result = await myApi.fetchCarData(widget.carid);
      setState(() {
        modelcontroller.text = result!.model;
        companycontroller.text = result.company;
        numbercontroller.text = result.number;
        carTypecontroller.text = result.carType;
        currentlocationcontroller.text = result.current_location;
        yearcontroller.text = result.year.toString();
        pricecontroller.text = result.price.toString();
        isRotatedcontroller.text = result.isRotated.toString();
        carRatingcontroller.text = result.carRating.toString();
        carpowercontroller.text = result.carpower.toString();
        peoplecontroller.text = result.people;
        bagscontroller.text = result.bags;
        imageURLcontroller.text = result.imageURl;
      });
    } catch (error) {
      print('Error fetching car details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputField('Model', 'Enter model', modelcontroller),
              _buildInputField('Company', 'Enter company', companycontroller),
              _buildInputField(
                  'Number', 'Enter Plate Number', numbercontroller),
              _buildInputField('Car Type', 'Enter Car type', carTypecontroller),
              _buildInputField('Current Location', 'Enter current location',
                  currentlocationcontroller),
              _buildInputField('Year', 'Enter Year', yearcontroller),
              _buildInputField('Color', 'Enter Color', colorcontroller),
              _buildInputField('Price', 'Enter Price', pricecontroller),
              _buildInputField(
                  'isRotated', 'Enter 0 or 1', isRotatedcontroller),
              _buildInputField(
                  'Car Rating', 'Enter Rating', carRatingcontroller),
              _buildInputField(
                  'Car Power', 'Enter Car Power', carpowercontroller),
              _buildInputField(
                  'People', 'Enter number of People', peoplecontroller),
              _buildInputField('Bags', 'Enter number of Bags', bagscontroller),
              _buildInputField(
                  'Image', 'Select image of Car', imageURLcontroller),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final Map<String, dynamic> data = {
                        "model": modelcontroller.text,
                        "company": companycontroller.text,
                        "number": numbercontroller.text,
                        "carType": carTypecontroller.text,
                        "current_location": currentlocationcontroller.text,
                        "year": yearcontroller.text,
                        "color": colorcontroller.text,
                        "price": pricecontroller.text,
                        "imageURl": imageURLcontroller.text,
                        "isRotated": isRotatedcontroller.text,
                        "carRating": carRatingcontroller.text,
                        "carpower": carpowercontroller.text,
                        "people": peoplecontroller.text,
                        "bags": bagscontroller.text,
                        "avail": true,
                        "status": true
                      };
                      myApi.updateCar(data, widget.carid);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await updateCarAvailability(widget.carid, false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, String hint, TextEditingController textController,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: textController,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.deepPurple),
          ),
        ),
      ),
    );
  }
}
