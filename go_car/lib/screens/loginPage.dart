// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, use_key_in_widget_constructors, unused_import, unused_element, unused_field, use_build_context_synchronously, duplicate_ignore, avoid_print

import 'package:go_car/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_car/controller/api.dart';
import 'package:go_car/models/user.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _loginState();
}

class _loginState extends State<Login> {
  api myApi = api();
  var namecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  String name = "";
  bool changeButton = false;
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  late Color mycolor;
  late Size mediasize;

  @override
  Widget build(BuildContext context) {
    mycolor = Theme.of(context).primaryColor;
    mediasize = MediaQuery.of(context).size;

    Widget buildTop() {
      return SizedBox(
        width: mediasize.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on_sharp,
              size: 100,
              color: Colors.white,
            ),
            Text(
              "GoCar",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            )
          ],
        ),
      );
    }

    Widget buildGreytext(String text) {
      return Text(
        text,
        style: TextStyle(color: Colors.grey),
      );
    }

    Widget buildform() {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                  color: mycolor, fontSize: 32, fontWeight: FontWeight.w500),
            ),
            buildGreytext("Please Login with your information"),
            SizedBox(height: 60),
            TextFormField(
              controller: namecontroller,
              decoration: InputDecoration(
                  hintText: "Enter Username",
                  labelText: "Username",
                  labelStyle: TextStyle(color: Colors.black38),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.black12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.deepPurple))),
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
              height: 15.0,
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
                      borderSide: BorderSide(color: Colors.black12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.deepPurple))),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Password cannot be Empty.";
                } else if (value != null && value.length < 8) {
                  return "Password Length must be at least 8 characters";
                }
                return null;
              },
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(color: Colors.grey),
                  )),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.deepPurple,
                  child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          changeButton = true;
                        });
                        String? loginUserID = await myApi.loginUser(
                            namecontroller.text, passwordcontroller.text);
                        // ignore: use_build_context_synchronously
                        if (loginUserID != null) {
                          User? loggedInUser =
                              await myApi.fetchUserData(loginUserID);
                          if (loggedInUser != null) {
                            Session.login(loggedInUser);
                            await Navigator.pushNamed(
                                context, MyRoutes.homeRoute);
                          } else {
                            print("Failed to fetch user data");
                          }
                        } else {
                          print("Failed");
                        }
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
                            : Image.asset("assets/images/login_arrow.png")),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont have account?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.signupRoute);
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                    )),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Expanded(
                    child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR")),
                Expanded(
                    child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ))
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _createRoundButton('assets/images/facebook.png', () {}),
                SizedBox(width: 17),
                _createRoundButton('assets/images/insta.png', () {}),
                SizedBox(width: 17),
                _createRoundButton('assets/images/twitter.png', () {}),
                SizedBox(width: 17),
                _createRoundButton('assets/images/gmail.png', () {}),
              ],
            )
          ],
        ),
      );
    }

    Widget buildbottom() {
      return SizedBox(
          width: mediasize.width,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: buildform(),
            ),
          ));
    }

    return Container(
      decoration: BoxDecoration(
        color: mycolor,
        image: DecorationImage(
          image: AssetImage("assets/images/main.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(mycolor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 80, child: buildTop()),
            Positioned(bottom: 0, child: buildbottom())
          ],
        ),
      ),
    );
  }
}

Widget _createRoundButton(String imagePath, Function onTap) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.transparent,
    ),
    child: Center(
      child: InkWell(
        onTap: onTap(),
        child: ClipOval(
          child: Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
