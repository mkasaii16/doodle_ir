import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

void main() {
  runApp(Forgetpassword());
}

class Forgetpassword extends StatefulWidget {
  @override
  _ForgetpasswordState createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
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
                            Spacer(flex: 4),
                            Text(
                              ' Forget password?',
                              textScaleFactor: 1.0,
                              style: new TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Segoe UI'),
                            ),
                            Spacer(flex: 1),
                            Container(
                              width: 390.0,
                              child: Text(
                                ' Dont worry,it happens to the best of us.We'
                                'll email you a reset link.',
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.0,
                                style: new TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Segoe UI'),
                              ),
                            ),
                            Spacer(flex: 2),
                            Container(
                                width: 300.0,
                                child: TextField(
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: "abc@def.ghi",
                                        border: OutlineInputBorder()))),
                            Spacer(flex: 1),
                            ElevatedButton.icon(
                              onPressed: () {},
                              label: Text(
                                'RESET PASSWORD',
                                textScaleFactor: 1.0,
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Segoe UI'),
                              ),
                              icon: Icon(Icons.hourglass_top_sharp),
                            ),
                            Spacer(flex: 1),
                          ],
                        )),
                      ),
                    ),
                    Spacer(),
                    Image.asset('images/forgetpassword.png'),
                    Spacer(),
                  ],
                ))));
  }
}
