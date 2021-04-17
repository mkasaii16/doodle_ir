import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'signup.dart';
import 'forgetpassword.dart';

void main() {
  runApp(Login());
}

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
