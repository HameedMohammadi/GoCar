// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, camel_case_types, use_build_context_synchronously, unused_import

import 'package:flutter/material.dart';
import 'package:go_car/utilities/routes.dart';
import 'package:go_car/controller/api.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  api myApi = api();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  String name = "";
  bool changeButton = false;
  bool passwordVisible = false;
  bool ischecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/signup_background.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 60.0),
                  Align(
                    alignment: Alignment(-0.85, 0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                              hintText: "Enter Name",
                              labelText: "Name",
                              labelStyle: TextStyle(color: Colors.black38),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple))),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Username cannot be Empty.";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                              hintText: "Enter Email",
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.black38),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple))),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Username cannot be Empty.";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: phonecontroller,
                          decoration: InputDecoration(
                              hintText: "Enter Phone Number",
                              labelText: "Phone",
                              labelStyle: TextStyle(color: Colors.black38),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple))),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Username cannot be Empty.";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: passwordcontroller,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  )),
                              labelStyle: TextStyle(color: Colors.black38),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple))),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Password cannot be Empty.";
                            } else if (value != null && value.length < 8) {
                              return "Password Length must be at least 8 characters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value:
                                  ischecked, // _isChecked is a boolean variable to control the checkbox state
                              onChanged: (bool? value) {
                                setState(() {
                                  ischecked = value!;
                                });
                              },
                            ),
                            Text(
                              'I agree with',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'privacy',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'and',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'policy',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 90.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.deepPurple,
                              child: InkWell(
                                onTap: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    setState(() {
                                      changeButton = true;
                                    });
                                    await Future.delayed(Duration(seconds: 1));

                                    final Map<String, dynamic> data = {
                                      "name": namecontroller.text,
                                      "email": emailcontroller.text,
                                      "phoneNumber": phonecontroller.text,
                                      "password": passwordcontroller.text,
                                    };
                                    myApi.addUser(data);
                                    Navigator.pop(context);
                                    setState(() {
                                      changeButton = false;
                                    });
                                  }
                                },
                                child: AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                    width: 150,
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: changeButton
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.blue,
                                          )
                                        : Image.asset(
                                            "assets/images/login_arrow.png")),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                      color: Colors.deepPurple, fontSize: 16),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple // Change the button background color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width - 50, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
