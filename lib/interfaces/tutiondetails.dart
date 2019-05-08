import 'package:flutter/material.dart';
import 'user.dart';
import 'alltutionspage.dart';
import 'tution.dart';
import 'mytutionpage.dart';
import 'profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'userdetail.dart';
import 'addtutionform.dart';
import 'notifications.dart';

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
                value["email"]);
            us.uid = val;
            users.add(us);
          }

        
        }).catchError((onError) {
        
        });
      }
    }
  
    return users;
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Tuition Hub')),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(u.username),
                    accountEmail: Text(u.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? Colors.blue
                              : Colors.white,
                      child: Text(
                        u.username.substring(0, 1),
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Profile"),
                    trailing: Icon(Icons.person),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) => new Profile(u));
                      Navigator.of(context).push(router);
                    },
                  ),
                  ListTile(
                    title: Text("Tutions"),
                    trailing: Icon(Icons.group_work),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new AllTutionPage(u));
                      Navigator.of(context).pushReplacement(router);
                    },
                  ),
                  ListTile(
                    title: Text("My Tutions"),
                    trailing: Icon(Icons.subject),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new MyTutionPage(u));
                      Navigator.of(context).pushReplacement(router);
                    },
                  ),
                  ListTile(
                    title: Text("Add Tutions"),
                    trailing: Icon(Icons.add_circle),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) => new AddTution(u));
                      Navigator.of(context).push(router);
                    },
                  ),
                  ListTile(
                    title: Text("Notifications"),
                    trailing: Icon(Icons.notifications),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Notifications(u));
                      Navigator.of(context).pushReplacement(router);
                    },
                  ),
                ],
              ),
            ),
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
                ))));
  }
}
