import 'package:TuitionHub/src/mainpages/homepage/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

import 'mainpages/loginsignuppage/loginpage.dart';
import 'models/user.dart';

class App extends StatelessWidget {
  User u;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  String email;

  Future<bool> loadAuthData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    email= sp.getString("email");
    //sp.clear();
  
    return sp.getBool("auth");
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tuition HUB',
      debugShowCheckedModeBanner: false,
      //home: new LoginPage(),
      home: FutureBuilder(
        future: loadAuthData(),
       builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return MainPage(email);
            } else {
              return LoginPage();
            }
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
