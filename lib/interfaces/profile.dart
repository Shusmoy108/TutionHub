import 'package:flutter/material.dart';
import 'user.dart';
import 'alltutionspage.dart';
import 'mytutionpage.dart';
import 'addtutionform.dart';

class Profile extends StatelessWidget {
  User u;

  Profile(this.u);
  @override
  Widget build(BuildContext context) {
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
              alignment: Alignment.center,
              child: new ListView(
                children: <Widget>[
                  nameField(),
                  emailField(),
                  genderField(),
                  insititutionField(),
                  departmentField(),
                  mobileField(),
                  areaField(),
                  addressField()
                ],
              ),
            )));
  }

  Widget userField() {
    return ListTile(title: Text("hello"));
  }

  Widget nameField() {
    return ListTile(
        title: Text(
      'Name : ${u.username}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget emailField() {
    return ListTile(
        title: Text(
      'Email : ${u.email}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget insititutionField() {
    return ListTile(
        title: Text(
      'Institution : ${u.institution}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget departmentField() {
    return ListTile(
        title: Text(
      'Department : ${u.department}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget genderField() {
    return ListTile(
        title: Text(
      'Gender : ${u.gender}',
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
      'Area : ${u.area}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget addressField() {
    return ListTile(
        title: Text(
      'Detailed Address : ${u.address}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }
}
