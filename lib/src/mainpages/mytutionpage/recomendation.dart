import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'mytutionpage.dart';
import 'userdetail.dart';
import '../../models/tution.dart';
import '../../models/user.dart';

import '../alltutionpage/alltutionspage.dart';
import '../notificationpage/notifications.dart';
import '../profilepage/profile.dart';

class RecomendationPage extends StatefulWidget {
  User u;

  Tution tution;
  RecomendationPage(this.u, this.tution);
  @override
  State<StatefulWidget> createState() {
    return Recomendations(u, tution);
  }
}

class Recomendations extends State<RecomendationPage> {
  User u;

  Tution tution;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  Recomendations(this.u, this.tution);
  Future<List<User>> _getUsers() async {
    List<User> users = List();
     databaseReference = database.reference().child("users");
      await databaseReference
        .orderByChild("etuition")
        .equalTo("Yes")
        .once()
        .then((onValue) {
     if (onValue.value.values != null) {
        for (var value in onValue.value.values) {
         User us;
          us = User(
              value["username"],
              value["gender"],
              value["address"],
              value["area"],
              value["department"],
              value["institution"],
              value["mobile"],
              value["password"],
              value["email"],
              value["rating"],
              value["number"],
              value["subject"]);
              u.etuition=value["etuition"];
          if(us.email!=u.email && us.area.contains(tution.area)){
            for(int x=0;x<tution.subject.length;x++){
              if(us.subject.contains(tution.subject[x])){
                us.f='y';
              }
            }
       
            //us.f='y';
          }
          users.add(us);
      }
      
      int i = 0;
      for (var key in onValue.value.keys) {
          users[i].uid = key;
          i++;
      }        
     }
     
      else {
        users = [];
      }
    });

  List<User> recos = List();
  for(int i=0;i<users.length;i++){
    if(users[i].f=='y'){
      recos.add(users[i]);
    }
  }
    return recos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Tuition Hub')),
        body: Container(
            margin: EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: _getUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("No Interested Person"),
                    ),
                  );
                } else {
                  return UserDetails(snapshot.data, u, tution);
                }
              },
            )));
  }
}
