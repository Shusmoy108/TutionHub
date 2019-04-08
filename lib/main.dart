import 'package:flutter/material.dart';
//import './Welcome/welcome.dart';
//import './Welcome/home.dart';
//import './Welcome/appbar.dart';
//import './Welcome/make_it_rain.dart';
//import './Welcome/gesture.dart';
import './interfaces/loginapp.dart';
//import './interfaces/signup.dart';

void main() {
  runApp(new MaterialApp(
    color: Colors.greenAccent,
    title: 'TutionHub ',
    home: new LogIn(),
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
