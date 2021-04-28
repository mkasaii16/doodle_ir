import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'login.dart';

String name, username, email, password;
Map error;
var errorlist;
int flagsignup;
void main() {
  runApp(Signup());
}

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Spacer(),
                    ClipPath(
                      clipper: SideCutClipper(),
                      child: Container(
                        height: 400,
                        width: 500,
                        color: Colors.blue[300],
                        child: Center(
                            child: Column(
                          children: [
                            Spacer(flex: 2),
                            Text(
                              ' Doodle',
                              textScaleFactor: 1.0,
                              style: new TextStyle(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Segoe UI'),
                            ),
                            Spacer(flex: 2),
                            Container(
                                width: 250.0,
                                child: TextField(
                                    onChanged: (text) {
                                      name = text;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        hintText: "Full Name",
                                        border: OutlineInputBorder()))),
                            Spacer(flex: 1),
                            Container(
                                width: 250.0,
                                child: TextField(
                                    onChanged: (text) {
                                      username = text;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'User Name',
                                        hintText: "User Name",
                                        border: OutlineInputBorder()))),
                            Spacer(flex: 1),
                            Container(
                                width: 250.0,
                                child: TextField(
                                    onChanged: (text) {
                                      email = text;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: "abc@def.ghi",
                                        border: OutlineInputBorder()))),
                            Spacer(flex: 1),
                            Container(
                                width: 250.0,
                                child: TextField(
                                    onChanged: (text) {
                                      password = text;
                                    },
                                    obscureText: true,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        hintText: "Password",
                                        border: OutlineInputBorder()))),
                            Spacer(flex: 2),
                            ElevatedButton.icon(
                              onPressed: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialogloading(context),
                                );
                                signup();
                                Timer(const Duration(seconds: 2), () {
                                  Navigator.of(context).pop(false);
                                  if (flagsignup == 1) {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildPopupDialogsecc(context),
                                    );
                                    Timer(const Duration(seconds: 2), () {
                                      // Navigator.of(context).pop(false);
                                      Navigator.of(context).pop(false);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    });
                                  } else {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildPopupDialogincorrent(context),
                                    );
                                    Timer(const Duration(seconds: 2), () {
                                      Navigator.of(context).pop(false);
                                    });
                                  }
                                });
                              },
                              label: Text(
                                'SIGNUP',
                                textScaleFactor: 1.0,
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Segoe UI'),
                              ),
                              icon: Icon(Icons.favorite),
                            ),
                            Spacer(flex: 1),
                          ],
                        )),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 250.0,
                      child: Image.asset('images/signup.png'),
                    ),
                    Spacer(),
                  ],
                ))));
  }
}

Future signup() async {
  Dio dio = new Dio();
  dio.options.headers['accept'] = 'application/json';
  dio.options.headers['Content-Type'] = 'application/json';
  try {
    var response = await dio.post(
      'https://k.qbox.dev/v1/user/',
      data: {
        "name": name,
        "username": username,
        "email": email,
        "password": password
      },
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
    if (response.statusCode == 201) {
      flagsignup = 1;
    } else {
      flagsignup = 0;
    }

    // ignore: unused_catch_clause
  } on DioError catch (e) {}
}

Widget _buildPopupDialogsecc(BuildContext context) {
  return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        backgroundColor: Color(0x01000000),
        title: Center(
            child: Text(
          'SIGN UP SUCCESSFULLY',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Segoe UI'),
        )),
      ));
}

Widget _buildPopupDialogincorrent(BuildContext context) {
  return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        backgroundColor: Color(0x01000000),
        title: Center(
            child: Text(
          errorlist.toString(),
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Segoe UI'),
        )),
      ));
}

Widget _buildPopupDialogloading(BuildContext context) {
  return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
          backgroundColor: Color(0x01000000),
          title: Center(
            child: Text(
              'Loading ...',
              textScaleFactor: 1.0,
              style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Segoe UI'),
            ),
          )));
}
