import 'package:doodle_ir/start.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DooDle',
      home: Start(),
    );
  }
}
