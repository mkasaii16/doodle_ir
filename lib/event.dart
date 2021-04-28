import 'dart:async';

import 'package:dio/dio.dart';
import 'package:scaled_list/scaled_list.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'login.dart';

int flagvote, indexoption;

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  void _stateUpdate() {
    setState(() {});
    print('reload');
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
          backgroundColor: Colors.blue[200],
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 90,
                  color: Colors.purple[200],
                  child: Row(
                    children: [
                      Spacer(),
                      Text('Created by  ', textScaleFactor: 1.0),
                      Text(events[indexnum]['owner']['username'],
                          textAlign: TextAlign.center,
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
                      child: Text(events[indexnum]['description'],
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.0,
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Segoe UI')),
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
                    Icon(Icons.location_on),
                    Spacer(
                      flex: 2,
                    ),
                    Container(
                      width: 300,
                      child: Text(events[indexnum]['timezone'],
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.0,
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Segoe UI')),
                    ),
                    Spacer(flex: 4),
                  ],
                ),
                Divider(
                  color: Colors.grey[200],
                  thickness: 1,
                ),
                // Spacer(),
                Icon(Icons.account_tree_outlined),

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
                                events[indexnum]['options'][selectedIndexevent]
                                        ['start_at']
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
                                events[indexnum]['options'][selectedIndexevent]
                                        ['finish_at']
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
                                    minWidth: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22.0)),
                                    onPressed: () {
                                      indexoption = selectedIndexevent;
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            _buildPopupDialogloading(context),
                                      );

                                      addvote();

                                      Timer(const Duration(seconds: 2), () {
                                        Navigator.of(context).pop(false);
                                        if (flagvote == 1) {
                                          // getlistevent();
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) =>
                                                _buildPopupDialogsecc(context),
                                          );
                                          Timer(const Duration(seconds: 2), () {
                                            Navigator.of(context).pop(false);

                                            _stateUpdate();
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
                                    child: Icon(Icons.volunteer_activism),
                                    color: Colors.green[400],
                                    highlightColor: Colors.green,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Vote:  ',
                                    textScaleFactor: 1.0,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'Segoe UI'),
                                  ),
                                  Text(
                                    events[indexnum]['options']
                                            [selectedIndexevent]['voters']
                                        .length
                                        .toString(),
                                    textScaleFactor: 1.0,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'Segoe UI'),
                                  ),
                                  Spacer(),
                                  MaterialButton(
                                    minWidth: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22.0)),
                                    onPressed: () {
                                      indexoption = selectedIndexevent;
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            _buildPopupDialogloading(context),
                                      );

                                      deletevote();

                                      Timer(const Duration(seconds: 2), () {
                                        Navigator.of(context).pop(false);
                                        if (flagvote == 1) {
                                          // getlistevent();
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) =>
                                                _buildPopupDialogsecc(context),
                                          );
                                          Timer(const Duration(seconds: 2), () {
                                            Navigator.of(context).pop(false);

                                            _stateUpdate();
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
                                    child: Icon(Icons.volunteer_activism),
                                    color: Colors.red[400],
                                    highlightColor: Colors.red,
                                    //  Colors.red,
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
            ),
          ),
        ));
  }
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

Future addvote() async {
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
  var addvote = await dio.post(
    "https://k.qbox.dev/v1/event/option/${events[indexnum]['options'][indexoption]['id']}/vote/",
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    ),
  );

  if (addvote.statusCode == 204) {
    flagvote = 1;
  } else {
    flagvote = 0;
  }
  dio.options.headers["Authorization"] = "Bearer ${key['access']}";
  var response = await dio.get('https://k.qbox.dev/v1/event/');
  events = (response.data);
  if (response.statusCode == 200) {
    print('add');
    print(events[indexnum]['options'][indexoption]['voters']);
    return flagvote;
  }
}

Future deletevote() async {
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
  var deletevote = await dio.delete(
    "https://k.qbox.dev/v1/event/option/${events[indexnum]['options'][indexoption]['id']}/vote/",
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    ),
  );

  if (deletevote.statusCode == 204) {
    flagvote = 1;
  } else {
    flagvote = 0;
  }
  dio.options.headers["Authorization"] = "Bearer ${key['access']}";
  var response = await dio.get('https://k.qbox.dev/v1/event/');
  events = (response.data);
  if (response.statusCode == 200) {
    print('delete');
    print(events[indexnum]['options'][indexoption]['voters']);

    return flagvote;
  }
}

// Future getlistevent() async {
//   Dio dio = new Dio();
//   dio.options.headers['accept'] = 'application/json';
//   var token = await dio.post(
//     "https://k.qbox.dev/v1/user/token/",
//     data: {"username": emaillogin, "password": passwordlogin},
//     options: Options(
//       followRedirects: false,
//       validateStatus: (status) {
//         return status < 500;
//       },
//     ),
//   );
//   key = Map<String, dynamic>.from(token.data);
//   dio.options.headers["Authorization"] = "Bearer ${key['access']}";
//   var response = await dio.get('https://k.qbox.dev/v1/event/');
//   events = (response.data);
//   if (response.statusCode == 200) {
//     return events;
//   }
// }
