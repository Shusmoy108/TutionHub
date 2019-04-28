import 'package:flutter/material.dart';
import 'tution.dart';
import 'user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'tutiondetails.dart';

class MyTution extends StatelessWidget {
  final List<Tution> tutions;
  User u;
  List<User> users = List();
  bool ty = false;
  MyTution(this.tutions, this.u);

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  void add(index) {
    databaseReference = database
        .reference()
        .child("tutions")
        .child(tutions[index].tid)
        .child("interested");
    databaseReference.push().set(u.uid);

    //print("object");
  }

  void user(t, context) {
    for (var val in t.interested) {
      databaseReference = database.reference().child("users");
      databaseReference.orderByKey().equalTo(val).once().then((onValue) {
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
    // var router = new MaterialPageRoute(
    //     builder: (BuildContext context) =>
    //         new TutionDetailsPage(u, alltutions, tutions, t, users));
    // Navigator.of(context).push(router);

    //;
  }

  Widget _buildProductItem(BuildContext context, int index) {
    print(tutions[index].interested);
    print("tuti");
    return ListTile(
      title: Column(
        children: <Widget>[
          Text('Number Of Students : ${tutions[index].numberofstudent}',
              style: TextStyle(color: Colors.black)),
          Text(tutions[index].cls, style: TextStyle(color: Colors.black)),
          Text('Institution : ${tutions[index].institution}',
              style: TextStyle(color: Colors.black)),
          Text('Subject : ${tutions[index].subject}',
              style: TextStyle(color: Colors.black)),
          Text('Salary : ${tutions[index].salary}',
              style: TextStyle(color: Colors.black)),
          Text('Area : ${tutions[index].area}',
              style: TextStyle(color: Colors.black)),
          Text('Detailed Address : ${tutions[index].address}',
              style: TextStyle(color: Colors.black)),
          RaisedButton(
            color: Colors.blue,
            child: Text("See Interesteds"),
            onPressed: () {
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new TutionDetailsPage(
                        u,
                        tutions[index],
                      ));
              Navigator.of(context).push(router);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(tutions);
    print("tut");
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: tutions.length,
    );
  }
}
