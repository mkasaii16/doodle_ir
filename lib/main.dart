import 'dart:async';

import 'package:dio/dio.dart';
import 'package:doodle_ir/start.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'dashboard.dart';
import 'database.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

int flagfromdatabase, flagauto;
String user, pass;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder(
            future: _query2(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // login();
                if (flagauto == 1) {
                  return Home();
                } else {
                  return Start();
                }
              } else {
                return Container(
                    width: 90,
                    height: 90,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballScale,
                      color: Colors.blue,
                    ));
              }
            }));
  }
}

Future _query2() async {
  DatabaseHelper helper = DatabaseHelper.instance;
  if (await helper.queryWord(1) == null) {
    flagauto = 0;
    return flagauto;
  } else {
    Word userlogin = await helper.queryWord(1);
    Word passlogin = await helper.queryWord(2);
    if (userlogin != null) {
      user = userlogin.word.toString();
      pass = passlogin.word.toString();
      emaillogin = user;
      passwordlogin = pass;
      Dio dio = new Dio();
      dio.options.headers['content-Type'] = 'application/json';
      try {
        var response = await dio.post(
          "https://k.qbox.dev/v1/user/token/",
          data: {"username": user, "password": pass},
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
          ),
        );
        if (response.statusCode == 200) {
          key = Map<String, dynamic>.from(response.data);
          Dio dio = new Dio();
          dio.options.headers['accept'] = 'application/json';
          dio.options.headers["Authorization"] = "Bearer ${key['access']}";
          try {
            var response = await dio.get('https://k.qbox.dev/v1/user/');
            data = Map<String, dynamic>.from(response.data);
            flagauto = 1;
            return flagauto;
            // ignore: unused_catch_clause
          } on DioError catch (e) {}
        } else {
          flagauto = 0;
          return flagauto;
        }
        // ignore: unused_catch_clause
      } on DioError catch (e) {
        flagauto = 0;
        return flagauto;
      }
      // login();
    } else {
      flagauto = 0;
      return flagauto;
    }
  }
}
