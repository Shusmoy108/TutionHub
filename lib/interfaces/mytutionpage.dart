import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './tution.dart';
import 'mytution.dart';
import 'user.dart';
import 'alltutionspage.dart';
import 'profile.dart';
import 'addtutionform.dart';

class MyTutionPage extends StatefulWidget {
  User u;

  MyTutionPage(this.u);
  @override
  State<StatefulWidget> createState() {
    return MyTutionPageState(u);
  }
}

class MyTutionPageState extends State<MyTutionPage> {
  User u;
  MyTutionPageState(this.u);
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  @override
  void initState() {
    setState(() {
      super.initState();
      databaseReference = database.reference().child("tutions");
      print("hello1");
    });
  }

  void getData() {
    setState(() {
      List<Tution> _tutions = List();
      List<Tution> _mytutions = List();
      databaseReference.once().then((DataSnapshot snapshot) {
        for (var value in snapshot.value.values) {
          Tution tution = Tution(
              value['cls'],
              value["subject"],
              value["salary"],
              value["address"],
              value["area"],
              value["institution"],
              value["numberofstudent"]);
          for (var value in value['interested'].values) {
            tution.interested.add(value);
          }

          tution.uid = value['uid'];
          if (tution.uid == u.uid) {
            _mytutions.add(tution);
          }
          _tutions.add(tution);
        }
        int i = 0;
        for (var key in snapshot.value.keys) {
          _tutions[i].tid = key;
          i++;
        }
        print(_mytutions);
      });
    });
  }

  Future<List<Tution>> _getMyTution() async {
    List<Tution> _mytutions = List();
    await databaseReference.once().then((DataSnapshot snapshot) {
      for (var value in snapshot.value.values) {
        Tution tution = Tution(
            value['cls'],
            value["subject"],
            value["salary"],
            value["address"],
            value["area"],
            value["institution"],
            value["numberofstudent"]);
        for (var value in value['interested'].values) {
          tution.interested.add(value);
        }

        tution.uid = value['uid'];
        if (tution.uid == u.uid) {
          _mytutions.add(tution);
        }
      }
    });
    print(_mytutions.length);
    return _mytutions;
  }

  void addTution() {
    // var router = new MaterialPageRoute(
    //     builder: (BuildContext context) =>
    //         new AddTution(u));
    // Navigator.of(context).push(router);
  }
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit an App'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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
                    trailing: Icon(Icons.person_outline),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new AllTutionPage(u));
                      Navigator.of(context).push(router);
                    },
                  ),
                  ListTile(
                    title: Text("My Tutions"),
                    trailing: Icon(Icons.person_outline),
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
                  future: _getMyTution(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("Loading...."),
                        ),
                      );
                    } else {
                      return MyTution(snapshot.data, u);
                    }
                  },
                ))));
  }
}
