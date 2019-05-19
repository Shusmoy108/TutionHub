import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/tution.dart';
import '../../models/user.dart';
import '../addtutionpage/addtutionform.dart';
import '../mytutionpage/mytutionpage.dart';
import '../notificationpage/notifications.dart';
import '../profilepage/profile.dart';
import 'tutions.dart';

class AllTutionPage extends StatefulWidget {
  User u;

  AllTutionPage(this.u);
  @override
  State<StatefulWidget> createState() {
    return AllTutionPageState(u);
  }
}

class AllTutionPageState extends State<AllTutionPage> {
  User u;
  AllTutionPageState(this.u);
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  @override
  void initState() {
    setState(() {
      super.initState();
      databaseReference = database.reference().child("tutions");
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit Tuition Hub'),
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

  Future<List<Tution>> _getTution() async {
    List<Tution> _tutions = List();

    await databaseReference.once().then((DataSnapshot snapshot) {
      if (snapshot.value.values != null) {
        for (var value in snapshot.value.values) {
          Tution tution = Tution(
              value['cls'],
              value["subject"],
              value["salary"],
              value["address"],
              value["area"],
              value["institution"],
              value["numberofstudent"]);

          if (value['interested'] != null) {
            for (var value in value['interested'].values) {
              tution.interested.add(value['uid']);
            }
          } else {
            tution.interested = [];
          }

          tution.status = value['status'];
          tution.uid = value['uid'];
          tution.uname = value['uname'];
          tution.uemail = value['uemail'];
          if (tution.status != "booked") {
            _tutions.add(tution);
          }
        }
        int i = 0;
        for (var key in snapshot.value.keys) {
          _tutions[i].tid = key;
          i++;
        }
      } else {
        _tutions = [];
      }
    });
    return _tutions;
  }

  void addTution() {
    var router = new MaterialPageRoute(
        builder: (BuildContext context) => new AddTution(u));
    Navigator.of(context).push(router);
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
                    Navigator.of(context).pushReplacement(router);
                  },
                ),
                ListTile(
                  title: Text(
                    "Tutions",
                    style: new TextStyle(color: Colors.blueAccent),
                  ),
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
                        builder: (BuildContext context) => new MyTutionPage(u));
                    Navigator.of(context).pushReplacement(router);
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
              color: Color.fromRGBO(234, 239, 241, 1.0),
              //margin: EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: _getTution(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text(
                            "There is currently no tutions available. All tutions are booked."),
                      ),
                    );
                  } else {
                    return Tutions(snapshot.data, u);
                  }
                },
              )),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new AddTution(u));
              Navigator.of(context).push(router);
            },
            label: Text(
              'Add Tution',
            ),
            icon: Icon(Icons.add),
            backgroundColor: Color.fromRGBO(220, 20, 60, 0.8),
          ),
        ));
  }
}
