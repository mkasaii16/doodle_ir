import 'package:doodle_ir/login.dart';
import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(Start());
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.purple,
        home: Column(
          children: <Widget>[
            Expanded(
                child: Stack(
              children: <Widget>[
                Image.asset(
                  'images/background.png',
                  fit: BoxFit.cover,
                ),
                Center(
                  heightFactor: 10.2,
                  child: Column(
                    children: [
                      Spacer(
                        flex: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          'Get Startet ',
                          textScaleFactor: 1.0,
                          style: new TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontFamily: 'Segoe UI'),
                        ),
                      ),
                      Spacer(
                        flex: 8,
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ],
        ));
  }
}
