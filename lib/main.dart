import 'package:flutter/material.dart';
import './src/mainpages/loginsignuppage/loginpage.dart';

void main() {
  runApp(new MaterialApp(
    color: Colors.greenAccent,
    title: 'TuitionHub ',
    debugShowCheckedModeBanner: false,
    //debugShowMaterialGrid: false,
    home: new LoginPage(),
    //title: 'Layouts',
    //home: new Gesture(title: 'Gesture',),
    //home:new Home(),
    //home: new Welcome(),
  ));
  // new Material(
  //   color: Colors.deepOrange,
  //   child: new Center(
  //       child: new Text(
  //     "Hello, there",
  //     textDirection: TextDirection.ltr,
  //     style: new TextStyle(
  //         fontWeight: FontWeight.w800, fontStyle: FontStyle.italic),
  //   ))));
}
