import 'package:flutter/material.dart';
import 'package:animated_drawer/views/animated_drawer.dart';

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
        openIcon: Icon(Icons.apps_outlined, color: Color(0xFF1f186f)),
        closeIcon: Icon(Icons.arrow_back_ios, color: Color(0xFF1f186f)),
        shadowColor: Color(0xFF4c41a3),
        backgroundGradient: LinearGradient(
          colors: [Color(0xFF4F01a3), Color(0xFF2a1f6f)],
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
                  onPressed: () {},
                  label: Text(
                    'LOG OUT',
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
                  color: Color(0xFF5950a0),
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Text(
                  'Your name',
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
                  color: Color(0xFF5950a0),
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
              backgroundColor: Colors.black,
              title: Center(
                  child: Text(
                'Doodle',
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Segoe UI'),
              ))),
          body: SingleChildScrollView(
              child: Center(
            child: Text(
              'for test1',
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: new TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Segoe UI'),
            ),
          )),
        ));
  }
}
