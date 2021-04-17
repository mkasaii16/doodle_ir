import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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
                                    decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        hintText: "Full Name",
                                        border: OutlineInputBorder()))),
                            Spacer(flex: 1),
                            Container(
                                width: 250.0,
                                child: TextField(
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: "abc@def.ghi",
                                        border: OutlineInputBorder()))),
                            Spacer(flex: 1),
                            Container(
                                width: 250.0,
                                child: TextField(
                                    obscureText: true,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        hintText: "Password",
                                        border: OutlineInputBorder()))),
                            Spacer(flex: 2),
                            ElevatedButton.icon(
                              onPressed: () {},
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
