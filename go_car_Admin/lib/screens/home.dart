// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:rest_apis/controller/api.dart';
import 'RentCar.dart';

class HomeScreen extends StatelessWidget {
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
                      myApi.addCar(data);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('Add'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the "Show All" button here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('Show All'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RentCar()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('Rent'),
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
