// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, avoid_print, depend_on_referenced_packages, camel_case_types, unused_import, unused_local_variable, non_constant_identifier_names, unrelated_type_equality_checks, prefer_const_declarations

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:go_car/controller/api.dart';
import 'package:go_car/models/catalog.dart';
import 'package:go_car/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class bookingScreen extends StatefulWidget {
  final items item;
  const bookingScreen({Key? key, required this.item}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<bookingScreen> {
  api myApi = api();
  bool dropdownValue = true;
  final TextEditingController carnameController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController enumberController = TextEditingController();
  User? loggedInUser;
  int price = 0;

  bool cashOnDelivery = false;
  bool isCardPayment = false;
  final TextEditingController cardnumberController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loggedInUser = Session.loggedInUser;
    carnameController.text = widget.item.model;
    nameController.text = loggedInUser?.name ?? '';
    emailController.text = loggedInUser?.email ?? '';
    phoneNumberController.text = loggedInUser?.phonenumber ?? '';

    fromDateController
        .addListener(calculatePrice); // Listen for 'From' date changes
    toDateController.addListener(calculatePrice);
  }

  DateTime? fromDate;
  DateTime? toDate;

  @override
  void dispose() {
    fromDateController.removeListener(calculatePrice);
    toDateController.removeListener(calculatePrice);
    nameController.dispose();
    enumberController.dispose();
    emailController.dispose();
    carnameController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    cnicController.dispose();
    priceController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    try {
      final String baseURL = "http://localhost:3007/api/car";

      final response = await http.get(Uri.parse(baseURL));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        catalogmodel.product =
            List.from(data).map<items>((item) => items.fromMap(item)).toList();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  void calculatePrice() {
    if (fromDate != null && toDate != null) {
      int bookingDays = toDate!.difference(fromDate!).inDays;
      double itemPrice =
          widget.item.price.toDouble(); // Get the price from widget.item
      double calculatedPrice = itemPrice * bookingDays; // Calculate the price

      setState(() {
        price =
            calculatedPrice.toInt(); // Convert the calculated price to an int
        priceController.text = price.toString();
      });

      print('Booking Days: $bookingDays');
      print('Price: $price');
    }
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
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    Widget buildLicenseDropDown(String label) {
      return DropdownButtonFormField<String>(
        value: dropdownValue ? 'Yes' : 'No',
        onChanged: (String? newValue) {
          setState(() {
            if (newValue == 'Yes') {
              dropdownValue = true;
            } else if (newValue == 'No') {
              dropdownValue = false;
            }
          });
        },
        items:
            <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: InputDecoration(
          enabledBorder: textFieldBorder(),
          focusedBorder: textFieldBorder(),
          border: textFieldBorder(),
          labelText: label,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
        ),
      );
    }

    Widget buildDateFormField(
      BuildContext context,
      String label,
      TextEditingController controller,
      DateTime? selectedDate,
      Function(DateTime?) onDateSelected,
    ) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              style: GoogleFonts.poppins(
                color: themeData.primaryColor,
              ),
              controller: controller,
              readOnly: true,
              decoration: InputDecoration(
                enabledBorder: textFieldBorder(),
                focusedBorder: textFieldBorder(),
                border: textFieldBorder(),
                hintStyle: GoogleFonts.poppins(
                  color: themeData.primaryColor,
                ),
                labelText: label,
                suffixIcon: IconButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime(DateTime.now().year, DateTime.now().month),
                      lastDate: DateTime(
                              DateTime.now().year, DateTime.now().month + 1)
                          .subtract(Duration(days: 1)),
                    );
                    onDateSelected(pickedDate);
                  },
                  icon: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget buildTextFormField(
        String label, TextEditingController controller, bool enables) {
      return TextFormField(
        style: GoogleFonts.poppins(
          color: themeData.primaryColor,
        ),
        enabled: enables,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: size.height * 0.01,
            left: size.width * 0.04,
            right: size.width * 0.04,
          ),
          enabledBorder: textFieldBorder(),
          focusedBorder: textFieldBorder(),
          border: textFieldBorder(),
          hintStyle: GoogleFonts.poppins(
            color: themeData.primaryColor,
          ),
          labelText: label,
        ),
      );
    }

    Widget buildPaymentDetails() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: cashOnDelivery,
                onChanged: (bool? newValue) {
                  setState(() {
                    cashOnDelivery = newValue ?? false;
                    if (!cashOnDelivery) {
                      isCardPayment = false;
                    }
                  });
                },
              ),
              Text('Cash on Delivery'),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: isCardPayment,
                onChanged: (bool? newValue) {
                  setState(() {
                    isCardPayment = newValue ?? false;
                    if (!isCardPayment) {
                      cvcController.clear(); // Clear input if unchecked
                      expiryDateController.clear(); // Clear input if unchecked
                    }
                  });
                },
              ),
              Text('Debit/Credit'),
            ],
          ),
          if (isCardPayment) // Show only if Debit/Credit is selected
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                buildTextFormField('Number', cardnumberController, true),
                SizedBox(height: 20),
                buildTextFormField('CVC', cvcController, true),
                SizedBox(height: 20),
                buildTextFormField('Expiry Date', expiryDateController, true),
              ],
            ),
        ],
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), //appbar size
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
      backgroundColor: const Color(0xfff8f8f8),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'Booking Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              buildDateFormField(
                context,
                'From',
                fromDateController,
                fromDate,
                (DateTime? date) {
                  setState(() {
                    fromDate = date;
                    fromDateController.text = date != null
                        ? DateFormat('yyyy-MM-dd').format(date)
                        : '';
                  });
                },
              ),
              SizedBox(height: 20),
              buildDateFormField(
                context,
                'To',
                toDateController,
                toDate,
                (DateTime? date) {
                  setState(() {
                    toDate = date;
                    toDateController.text = date != null
                        ? DateFormat('yyyy-MM-dd').format(date)
                        : '';
                  });
                },
              ),
              SizedBox(height: 20),
              buildTextFormField('Car', carnameController, false),
              SizedBox(height: 20),
              buildTextFormField('Name', nameController, false),
              SizedBox(height: 20),
              buildTextFormField('Price', priceController, false),
              SizedBox(height: 20),
              buildTextFormField('Email', emailController, false),
              SizedBox(height: 20),
              buildTextFormField('Phone Number', phoneNumberController, false),
              SizedBox(height: 20),
              buildTextFormField('CNIC', cnicController, true),
              SizedBox(height: 20),
              buildLicenseDropDown('Lisence'),
              SizedBox(height: 20),
              buildTextFormField('Emergency Contact', enumberController, true),
              SizedBox(height: 20),
              buildPaymentDetails(),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3b22a1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () async {
                  int bookingDays = toDate!.difference(fromDate!).inDays;
                  if (fromDate != null &&
                      toDate != null &&
                      cnicController.text.isNotEmpty &&
                      enumberController.text.isNotEmpty &&
                      priceController.text.isNotEmpty) {
                    String? loginUserID = await myApi.loginUser(
                        loggedInUser!.name, loggedInUser!.password);
                    String USERID = loginUserID ?? '';
                    final Map<String, dynamic> data = {
                      "user_id": USERID,
                      "bookingDays": bookingDays,
                      "car_id": widget.item.id,
                      "price": priceController.text
                    };
                    String? bookingid = await myApi.bookCar(data);
                    bool licenseValue = dropdownValue == 'Yes';
                    if (bookingid != null) {
                      await myApi.rentHistory(USERID, bookingid);
                    } else {
                      print('Failed to retrieve booking ID');
                    }
                    myApi.updateUser(data, USERID);
                    updateCarAvailability(widget.item.id, false);
                    loadData();
                    Navigator.pop(context);
                  } else {}
                },
                child: Text(
                  'Confirm',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
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
