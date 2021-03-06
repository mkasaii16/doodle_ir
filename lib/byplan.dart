import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'login.dart';

String title, location, note;
int flagnewevent;

class ByPlan extends StatefulWidget {
  @override
  _ByPlanState createState() => _ByPlanState();
}

class _ByPlanState extends State<ByPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Container(
              height: 160,
              color: Colors.blue[300],
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    width: 250,
                    child: TextField(
                        onChanged: (text) {
                          title = text;
                        },
                        decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: "Title",
                        )),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                      onPressed: () {
                        if (title != '') {
                          if (location != '') {
                            if (note != '') {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialogloading(context),
                              );
                              createnewevent();
                              Timer(const Duration(seconds: 2), () {
                                Navigator.of(context).pop(false);
                                if (flagnewevent == 1) {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialogsecc(context),
                                  );
                                  Timer(const Duration(seconds: 2), () {
                                    Navigator.of(context).pop(false);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()));
                                  });
                                } else {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialogerror(context),
                                  );
                                  Timer(const Duration(seconds: 2), () {
                                    Navigator.of(context).pop(false);
                                  });
                                }
                              });
                            } else {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialoginput(context),
                              );
                              Timer(const Duration(seconds: 2), () {
                                Navigator.of(context).pop(false);
                              });
                            } //note
                          } else {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialoginput(context),
                            );
                            Timer(const Duration(seconds: 2), () {
                              Navigator.of(context).pop(false);
                            });
                          } //location
                        } else {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialoginput(context),
                          );
                          Timer(const Duration(seconds: 2), () {
                            Navigator.of(context).pop(false);
                          });
                        } //title
                      },
                      label: Text(
                        'Create',
                        textScaleFactor: 1.0,
                        style: new TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Segoe UI'),
                      ),
                      icon: Icon(Icons.create_new_folder_outlined)),
                  Spacer()
                ],
              )),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Icon(Icons.location_on),
              Spacer(
                flex: 2,
              ),
              Container(
                width: 300,
                child: TextField(
                    onChanged: (text) {
                      location = text;
                    },
                    decoration: InputDecoration(
                      labelText: 'LOCATION',
                      hintText: "LOCATION",
                    )),
              ),
              Spacer(flex: 4),
            ],
          ),
          Divider(
            color: Colors.grey[200],
            thickness: 1,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Icon(Icons.note),
              Spacer(
                flex: 2,
              ),
              Container(
                width: 300,
                child: TextField(
                    onChanged: (text) {
                      note = text;
                    },
                    decoration: InputDecoration(
                      labelText: 'Note',
                      hintText: "Note",
                    )),
              ),
              Spacer(flex: 4),
            ],
          ),
          Divider(
            color: Colors.grey[200],
            thickness: 1,
          ),
          Spacer(
            flex: 8,
          )
        ],
      ),
    ));
  }
}

Future createnewevent() async {
  Dio dio = new Dio();
  dio.options.headers['accept'] = 'application/json';
  var token = await dio.post(
    "https://k.qbox.dev/v1/user/token/",
    data: {"username": emaillogin, "password": passwordlogin},
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    ),
  );
  key = Map<String, dynamic>.from(token.data);
  dio.options.headers["Authorization"] = "Bearer ${key['access']}";
  // ignore: unused_local_variable
  var newevent = await dio.post(
    "https://k.qbox.dev/v1/event/",
    data: {
      "title": title,
      "description": note,
      "timezone": location,
      "optional_enabled": false
    },
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    ),
  );
  if (newevent.statusCode == 201) {
    title = '';
    location = '';
    note = '';
    flagnewevent = 1;
  } else {
    flagnewevent = 0;
  }
}

// ignore: unused_element
Widget _dialogoption(BuildContext context) {
  return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 56),
      child: AlertDialog(
        // backgroundColor: Color(0x01000000),
        title: Center(
            child: Container(
                width: 250.0,
                child: Row(
                  children: [
                    Container(
                      width: 250,
                      child: TextField(
                          onChanged: (text) {
                            note = text;
                          },
                          decoration: InputDecoration(
                            labelText: 'note',
                            hintText: "note",
                          )),
                    ),
                  ],
                ))),
        actions: [
          new TextButton(
            child: new Text("Set Note", textScaleFactor: 1.0),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ));
}

Widget _buildPopupDialogsecc(BuildContext context) {
  return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        backgroundColor: Color(0x01000000),
        title: Center(
            child: Text(
          'SUCCESSFULLY',
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

Widget _buildPopupDialogerror(BuildContext context) {
  return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        backgroundColor: Color(0x01000000),
        title: Center(
            child: Text(
          'ERROR-Try again',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Segoe UI'),
        )),
      ));
}

Widget _buildPopupDialoginput(BuildContext context) {
  return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        backgroundColor: Color(0x01000000),
        title: Center(
            child: Text(
          'Please enter all fields',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Segoe UI'),
        )),
      ));
}
