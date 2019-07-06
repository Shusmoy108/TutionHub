import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/tution.dart';
import '../../models/user.dart';
import '../addtutionpage/addtutionform.dart';
import '../alltutionpage/alltutionspage.dart';
import '../notificationpage/notifications.dart';
import '../profilepage/profile.dart';
import 'mytution.dart';

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
          tution.unbooknumber = value['unbooknumber'];
          if (tution.status == "booked") {
            tution.tutorname = value['tutorname'];
            tution.tutoremail = value['tutoremail'];
            tution.tutorid = value['tutorid'];
          }
          _tutions.add(tution);
          if (tution.uid == u.uid) {
            tution.f = 'm';
          }
        }
        int i = 0;
        for (var key in snapshot.value.keys) {
          _tutions[i].tid = key;
          i++;
        }
        for (var x = 0; x < _tutions.length; x++) {
          if (_tutions[x].f == 'm') {
            _mytutions.add(_tutions[x]);
          }
        }
      } else {
        _mytutions = [];
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
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: Text('Tuition Hub')),
        
          body: Container(
              margin: EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: _getMyTution(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("You have not posted any tutions yet..."),
                      ),
                    );
                  } else {
                    return MyTution(snapshot.data, u);
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
              'Add Tuition Offer',
            ),
            icon: Icon(Icons.add),
            backgroundColor: Color.fromRGBO(220, 20, 60, 0.8),
          ),
        );
  }
}
