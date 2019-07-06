import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'userdetail.dart';
import '../../models/tution.dart';
import '../../models/user.dart';


class TutionDetailsPage extends StatefulWidget {
  User u;

  Tution tution;
  TutionDetailsPage(this.u, this.tution);
  @override
  State<StatefulWidget> createState() {
    return TutionDetails(u, tution);
  }
}

class TutionDetails extends State<TutionDetailsPage> {
  User u;

  Tution tution;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  TutionDetails(this.u, this.tution);
  Future<List<User>> _getUsers() async {
    List<User> users = List();
    if (tution.interested != null) {
      for (var val in tution.interested) {
        databaseReference = database.reference().child("users");
        await databaseReference
            .orderByKey()
            .equalTo(val)
            .once()
            .then((onValue) {
          for (var value in onValue.value.values) {
            User us = User(
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
            us.uid = val;
            users.add(us);
          }
        }).catchError((onError) {});
      }
    }

    return users;
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
