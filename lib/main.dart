import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.amber,
        home: Column(
          children: <Widget>[
            
            Stack(
                  children: <Widget>[
                    Image.asset(
                      'images/background.png',
                    ),
                    Center(
                      heightFactor: 6.0,
                      child: MaterialButton(
                        color: Colors.black,
                        onPressed: () {},
                        child: Text(
                          'Get Startet ',
                          textScaleFactor: 1.0,
                          style: new TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Segoe UI'),
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ));
  }
}
