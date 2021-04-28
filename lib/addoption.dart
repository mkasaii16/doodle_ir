import 'dart:async';
import 'dart:ui';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scaled_list/scaled_list.dart';
import 'dashboard.dart';
import 'login.dart';

String start, finish;

int flagaddeventoption;

class Addoption extends StatefulWidget {
  @override
  _AddoptionState createState() => _AddoptionState();
}

class _AddoptionState extends State<Addoption> {
  PersianDate persianDate = PersianDate();

  String _valuestart = '', _valuefinish = '';
  DateTime selectedDate = DateTime.now();

  Future _selectDatestart() async {
    String picked = await jalaliCalendarPicker(
        context: context,
        convertToGregorian: false,
        showTimePicker: true,
        hore24Format: true);
    if (picked != null) setState(() => _valuestart = picked);
  }

  Future _selectDatefinish() async {
    String picked = await jalaliCalendarPicker(
        context: context,
        convertToGregorian: false,
        showTimePicker: true,
        hore24Format: true);
    if (picked != null) setState(() => _valuefinish = picked);
  }

  void _stateUpdateadd() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              events[indexnum]['title'],
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Segoe UI'),
            ),
          ),
          backgroundColor: Colors.blue[100],
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 100,
                  color: Colors.green[200],
                  child: Row(
                    children: [
                      Spacer(),
                      Text('Add option',
                          textAlign: TextAlign.right,
                          textScaleFactor: 1.0,
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Segoe UI')),
                      Spacer(),
                    ],
                  ),
                ),
                Container(
                    // width: 300.0,
                    child: Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        onSurface: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0)),
                      ),
                      onPressed: _selectDatestart,
                      child: Text('Set Start time',
                          textAlign: TextAlign.right,
                          textScaleFactor: 1.0,
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Segoe UI')),
                    ),
                    Text(_valuestart,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.0,
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Segoe UI')),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        onSurface: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0)),
                      ),
                      onPressed: _selectDatefinish,
                      child: Text('Set Finish time',
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.0,
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Segoe UI')),
                    ),
                    Text(_valuefinish,
                        textAlign: TextAlign.right,
                        textScaleFactor: 1.0,
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Segoe UI')),
                    Container(
                      width: 160,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            start = _valuestart;
                            finish = _valuefinish;
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialogloading(context),
                            );
                            addeventoption();
                            Timer(const Duration(seconds: 2), () {
                              Navigator.of(context).pop(false);
                              if (flagaddeventoption == 1) {
                                getlist();
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialogsecc(context),
                                );
                                Timer(const Duration(seconds: 2), () {
                                  Navigator.of(context).pop(false);
                                  _stateUpdateadd();
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
                          },
                          label: Text(
                            'Send',
                            textScaleFactor: 1.0,
                            style: new TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Segoe UI'),
                          ),
                          icon: Icon(Icons.send)),
                    ),
                    ScaledList(
                      selectedCardHeightRatio: .4,
                      unSelectedCardHeightRatio: .3,
                      cardWidthRatio: .7,
                      itemColor: (index2) {
                        return kMixedColors[index2 % kMixedColors.length];
                      },
                      itemBuilder: (index2, selectedIndexevent) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 9, left: 9),
                              alignment: Alignment.center,
                              height: 80,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    events[indexnum]['options']
                                            [selectedIndexevent]['start_at']
                                        .replaceAll(RegExp('[Z T]'), '     '),
                                    textScaleFactor: 1.0,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Segoe UI'),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 9, left: 9),
                              alignment: Alignment.center,
                              height: 80,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    events[indexnum]['options']
                                            [selectedIndexevent]['finish_at']
                                        .replaceAll(RegExp('[Z T]'), '     '),
                                    textScaleFactor: 1.0,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Segoe UI'),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 9, left: 9),
                              alignment: Alignment.bottomCenter,
                              // height: 80,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Center(
                                      child: Row(
                                    children: [
                                      Spacer(),
                                      MaterialButton(
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.delete_forever,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ))),
                            ),
                          ],
                        );
                      },
                      itemCount: events[indexnum]['options'].length,
                    ),
                  ],
                )),
              ],
            ),
          ),
        ));
  }
}

Future addeventoption() async {
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
    "https://k.qbox.dev/v1/event/${events[indexnum]['id']}/option/",
    data: {
      "start_at": start,
      "finish_at": finish,
    },
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    ),
  );

  if (newevent.statusCode == 201) {
    flagaddeventoption = 1;
  } else {
    flagaddeventoption = 0;
  }
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

// ignore: unused_element
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

Future getlist() async {
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
  var response = await dio.get('https://k.qbox.dev/v1/event/');
  events = (response.data);
  if (response.statusCode == 200) {
    return events;
  }
}
