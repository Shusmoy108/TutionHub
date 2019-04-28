import 'package:flutter/material.dart';
import 'user.dart';
import 'alltutionspage.dart';
import 'tution.dart';
import 'mytutionpage.dart';
import 'profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'userdetail.dart';
import 'addtutionform.dart';

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
            users.add(us);
          }
          print("object");
        }).catchError((onError) {
          print(onError);
        });
      }
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    print(tution.salary);
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
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
                      Navigator.of(context).push(router);
                    },
                  ),
                  ListTile(
                    title: Text("My Tutions"),
                    trailing: Icon(Icons.group_work),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new MyTutionPage(u));
                      Navigator.of(context).push(router);
                    },
                  ),
                  ListTile(
                    title: Text("Add Tutions"),
                    trailing: Icon(Icons.person_outline),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) => new AddTution(u));
                      Navigator.of(context).push(router);
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
                      return UserDetails(snapshot.data, u);
                    }
                  },
                ))));
  }

  Widget userField() {
    return ListTile(title: Text("hello"));
  }

  Widget nameField() {
    return ListTile(
        title: Text(
      'Number of Student : ${tution.numberofstudent}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget emailField() {
    return ListTile(
        title: Text(
      'Class : ${tution.cls}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget insititutionField() {
    return ListTile(
        title: Text(
      'Institution : ${tution.institution}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget departmentField() {
    return ListTile(
        title: Text(
      'Subject : ${tution.subject}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget genderField() {
    return ListTile(
        title: Text(
      'Salary : ${tution.salary}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget mobileField() {
    return ListTile(
        title: Text(
      'Mobile Number : ${u.mobile}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget areaField() {
    return ListTile(
        title: Text(
      'Area : ${tution.area}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget addressField() {
    return ListTile(
        title: Text(
      'Detailed Address : ${tution.address}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }
}
