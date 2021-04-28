import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'login.dart';

String titleedit, locationedit, noteedit;
int flageditevent;

class Editevent extends StatefulWidget {
  @override
  _EditeventState createState() => _EditeventState();
}

class _EditeventState extends State<Editevent> {
  TextEditingController _controllertitle = new TextEditingController();
  TextEditingController _controllerlocation = new TextEditingController();
  TextEditingController _controllernote = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Container(
              height: 260,
              color: Colors.green[200],
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    width: 250,
                    child: TextField(
                        controller: _controllertitle
                          ..text = events[indexnum]['title'],
                        onChanged: (text) {
                          titleedit = text;
                        },
                        decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: "Title",
                        )),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                      onPressed: () {
                        titleedit = _controllertitle.text;
                        locationedit = _controllerlocation.text;
                        noteedit = _controllernote.text;
                        if (titleedit != '') {
                          if (locationedit != '') {
                            if (noteedit != '') {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialogloading(context),
                              );
                              editevent();
                              Timer(const Duration(seconds: 2), () {
                                Navigator.of(context).pop(false);
                                if (flageditevent == 1) {
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
                        'Edit',
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
                    controller: _controllerlocation
                      ..text = events[indexnum]['timezone'],
                    onChanged: (text) {
                      locationedit = text;
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
                    controller: _controllernote
                      ..text = events[indexnum]['description'],
                    onChanged: (text) {
                      noteedit = text;
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
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Icon(Icons.settings),
          //     MaterialButton(
          //       onPressed: () {}, //settings
          //       child: Text(
          //         'Settings',
          //         textScaleFactor: 1.0,
          //         style: new TextStyle(
          //             fontSize: 11.0,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black,
          //             fontFamily: 'Segoe UI'),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    ));
  }
}

Future editevent() async {
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
  var newevent = await dio.put(
    "https://k.qbox.dev/v1/event/${events[indexnum]['id']}/",
    data: {
      "title": titleedit,
      "description": noteedit,
      "timezone": locationedit,
      "optional_enabled": false
    },
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    ),
  );
  if (newevent.statusCode == 200) {
    titleedit = '';
    locationedit = '';
    noteedit = '';

    flageditevent = 1;
  } else {
    flageditevent = 0;
  }
}

// ignore: unused_element
Widget _dialognote(BuildContext context) {
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
                            noteedit = text;
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
