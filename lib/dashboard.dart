// ignore: unused_import
import 'dart:async';
// ignore: unused_import
import 'dart:convert';
import 'dart:ui';
import 'package:doodle_ir/addoption.dart';
import 'package:doodle_ir/byplan.dart';
import 'package:doodle_ir/edit.dart';
import 'package:doodle_ir/event.dart';

import 'database.dart';
import 'event.dart';
import 'login.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:animated_drawer/views/animated_drawer.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'main.dart';

Map listevent, data, dataget;
List events;
int indexnum, flagdelete;

final List<Color> kMixedColors = [
  Color(0xff71A5D7),
  Color(0xff72CCD4),
  Color(0xffFBAB57),
  Color(0xffF8B993),
  Color(0xff962D17),
  Color(0xffc657fb),
  Color(0xfffb8457),
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return AnimatedDrawer(
      homePageXValue: 150,
      homePageYValue: 80,
      homePageAngle: -0.2,
      homePageSpeed: 250,
      shadowXValue: 122,
      shadowYValue: 110,
      shadowAngle: -0.275,
      shadowSpeed: 550,
      openIcon: Icon(Icons.apps, color: Color(0xFF1f186f)),
      closeIcon: Icon(Icons.close, color: Color(0xFF1f186f)),
      shadowColor: Color(0xaa100003),
      backgroundGradient: LinearGradient(
        colors: [Color(0xaa000003), Color(0xac2a1f6f)],
      ),
      menuPageContent: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 15),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Doo",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "dle",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue[200],
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
              ),
              TextButton.icon(
                onPressed: () {
                  _delete();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                label: Text(
                  'LOG OUT       ',
                  textScaleFactor: 1.0,
                  style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Segoe UI'),
                ),
                icon: Icon(Icons.logout),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
              ),
              Divider(
                color: Color(0xaa100003),
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              Text(
                data['username'],
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: new TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Segoe UI'),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              Divider(
                color: Color(0xaa100003),
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
              ),
              TextButton.icon(
                onPressed: () {},
                label: Text(
                  'Setting                        ',
                  textScaleFactor: 1.0,
                  style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Segoe UI'),
                ),
                icon: Icon(Icons.settings),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
              ),
              TextButton.icon(
                onPressed: () {},
                label: Text(
                  'About                        ',
                  textScaleFactor: 1.0,
                  style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Segoe UI'),
                ),
                icon: Icon(Icons.album_outlined),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
              ),
              TextButton.icon(
                onPressed: () {},
                label: Text(
                  'Share                        ',
                  textScaleFactor: 1.0,
                  style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Segoe UI'),
                ),
                icon: Icon(Icons.share_outlined),
              ),
            ],
          ),
        ),
      ),
      homePageContent: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue[300],
              title: Center(
                  child: Text(
                'Doodle',
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Segoe UI'),
              ))),
          body: SingleChildScrollView(
            child: Container(
                // color: Colors.grey[100],
                child: Center(
              child: Column(children: [
                Text(''),
                Text(
                  'WELCOME ${data['username']},enjoy...',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                  style: new TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff71A5D7),
                      fontFamily: 'Segoe UI'),
                ),
                Text(''),
                FutureBuilder(
                  future: getlist(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                          child: ScaledList(
                        selectedCardHeightRatio: 1,
                        unSelectedCardHeightRatio: .9,
                        // cardWidthRatio: .8,
                        itemColor: (index) {
                          return kMixedColors[index % kMixedColors.length];
                        },
                        itemBuilder: (index, selectedIndex) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 9, left: 9),
                                alignment: Alignment.topLeft,
                                height: 80,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(children: [
                                        Icon(Icons.donut_large_outlined),
                                        MaterialButton(
                                          onPressed: () {
                                            indexnum = selectedIndex;

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Event()));
                                          },
                                          child: Text(
                                            events[selectedIndex]['title'],
                                            textScaleFactor: 1.0,
                                            style: new TextStyle(
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: 'Segoe UI'),
                                          ),
                                        ),
                                      ])),
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
                                      events[selectedIndex]['description'],
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
                                alignment: Alignment.bottomRight,
                                height: selectedIndex == index ? 80 : 80,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      events[selectedIndex]['timezone'],
                                      textScaleFactor: 1.0,
                                      style: new TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'Segoe UI'),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                height: selectedIndex == index ? 80 : 80,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          MaterialButton(
                                              onPressed: () {
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      _buildPopupDialogloading(
                                                          context),
                                                );
                                                indexnum = selectedIndex;
                                                deleteevent();
                                                Timer(
                                                    const Duration(seconds: 2),
                                                    () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                  if (flagdelete == 1) {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          _buildPopupDialogsecc(
                                                              context),
                                                    );
                                                    Timer(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      Navigator.of(context)
                                                          .pop(false);

                                                      setState(() {});
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Home()));
                                                    });
                                                  } else {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          _buildPopupDialogerror(
                                                              context),
                                                    );
                                                    Timer(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    });
                                                  }
                                                });
                                              },
                                              child: Icon(Icons.delete)),
                                          MaterialButton(
                                              onPressed: () {
                                                indexnum = selectedIndex;
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Editevent()));
                                              },
                                              child: Icon(Icons.edit)),
                                          MaterialButton(
                                              onPressed: () {
                                                indexnum = selectedIndex;
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Addoption()));
                                              },
                                              child:
                                                  Icon(Icons.how_to_vote_sharp))
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: events.length,
                      ));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner
                    return Container(
                        width: 90,
                        height: 90,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineScalePulseOutRapid,
                          color: Colors.blue,
                        ));
                  },
                ),
                Text(''),
                Container(
                  width: 460,
                  height: 150,
                  child: Text(
                    '     ${data['username']} make new doodle with float button',
                    textAlign: TextAlign.left,
                    textScaleFactor: 1.0,
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff71A5D7),
                        fontFamily: 'Segoe UI'),
                  ),
                )
              ]),
            )),
          ),
          floatingActionButton: FabCircularMenu(
              ringColor: Colors.blue[500],
              fabOpenColor: Colors.blue[200],
              fabCloseColor: Colors.blue[500],
              ringDiameter: 300,
              ringWidth: 60,
              children: <Widget>[
                IconButton(
                    //by plan
                    icon: Icon(Icons.fact_check_outlined),
                    onPressed: () {}),
                IconButton(
                    //by date
                    icon: Icon(Icons.date_range_outlined),
                    onPressed: () {}),
                IconButton(
                    //by time
                    icon: Icon(Icons.timer),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ByPlan()));
                    }),
              ])),
    );
  }
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

Future deleteevent() async {
  Dio dio = new Dio();
  dio.options.headers['accept'] = 'application/json';
  var token = await dio.post(
    "https://k.qbox.dev/v1/user/token/refresh/",
    data: {"refresh": key['refresh']},
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    ),
  );
  key = Map<String, dynamic>.from(token.data);
  // dio.options.headers['accept'] = '*/*';
  dio.options.headers["Authorization"] = "Bearer ${key['access']}";
  // ignore: unused_local_variable
  var deleteevent = await dio.delete(
    "https://k.qbox.dev/v1/event/${events[indexnum]['id']}/",
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    ),
  );
  if (deleteevent.statusCode == 204) {
    flagdelete = 1;
  } else {
    flagdelete = 0;
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

Future _delete() async {
  final helper = DatabaseHelper.instance;

  int id = await helper.getCount();
  for (var i = 1; i <= id; i++) {
    await helper.deleteWord(i);
  }
}
