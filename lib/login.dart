// ignore: unused_import
import 'dart:convert';
import 'dart:ui';
import 'package:doodle_ir/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'signup.dart';
import 'forgetpassword.dart';
import 'dashboard.dart';
import 'package:dio/dio.dart';
import 'dart:async';

void main() {
  runApp(Login());
}

String emaillogin;
// ignore: non_constant_identifier_names
String passwordlogin;
int flag = 0;
Timer timer;
Map key;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                                      emaillogin = text;
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
                                      passwordlogin = text;
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
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialogloading(context),
                                );
                                login();
                                Timer(const Duration(seconds: 4), () {
                                  if (flag == 1) {
                                    Navigator.of(context).pop(false);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()));
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildPopupDialogincorrent(context),
                                    );
                                    Timer(const Duration(seconds: 3), () {
                                      Navigator.of(context).pop(false);
                                      Navigator.of(context).pop(false);
                                    });
                                  }
                                });
                              },
                              label: Text(
                                'LOGIN',
                                textScaleFactor: 1.0,
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Segoe UI'),
                              ),
                              icon: Icon(Icons.login),
                            ),
                            Spacer(flex: 4),
                            Row(
                              children: [
                                Spacer(
                                  flex: 20,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Forgetpassword()));
                                  },
                                  child: Text(
                                    'Forget Password',
                                    textScaleFactor: 1.0,
                                    style: new TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'Segoe UI'),
                                  ),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()));
                                  },
                                  child: Text(
                                    'SIGN UP',
                                    textScaleFactor: 1.0,
                                    style: new TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'Segoe UI'),
                                  ),
                                ),
                                Spacer(
                                  flex: 20,
                                ),
                              ],
                            )
                          ],
                        )),
                      ),
                    ),
                    Spacer(),
                    Image.asset('images/login.png'),
                    Spacer(),
                  ],
                ))));
  }
}

void login() async {
  Dio dio = new Dio();
  dio.options.headers['content-Type'] = 'application/json';
  try {
    var response = await dio.post(
      "https://k.qbox.dev/v1/user/token/",
      data: {"username": emaillogin, "password": passwordlogin},
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      key = Map<String, dynamic>.from(response.data);
      info();
      flag = 1;
    } else {
      flag = 0;
    }
    // ignore: unused_catch_clause
  } on DioError catch (e) {
    flag = 0;
  }
}

void info() async {
  Dio dio = new Dio();
  dio.options.headers['accept'] = 'application/json';
  dio.options.headers["Authorization"] = "Bearer ${key['access']}";
  try {
    var response = await dio.get('https://k.qbox.dev/v1/user/');
    data = Map<String, dynamic>.from(response.data);

    // ignore: unused_catch_clause
  } on DioError catch (e) {}
}

Widget _buildPopupDialogincorrent(BuildContext context) {
  return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        backgroundColor: Color(0x01000000),
        title: Center(
            child: Text(
          'email or password incorrent',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 18.0,
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
