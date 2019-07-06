import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/user.dart';
import '../../models/tution.dart';
import '../../models/notice.dart';

class Tutions extends StatelessWidget {
  final List<Tution> tutions;
  User u;
  bool ty = false;
  Tutions(this.tutions, this.u);

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  void add(index, context) {
    if (tutions[index].uid != u.uid) {
      databaseReference = database
          .reference()
          .child("tutions")
          .child(tutions[index].tid)
          .child("interested");
      var user = {"uid": u.uid};
      databaseReference
          .orderByChild("uid")
          .equalTo(u.uid)
          .once()
          .then((onValue) {
        if (onValue.value == null) {
          databaseReference.push().set(user);
          int now = new DateTime.now().millisecondsSinceEpoch;
          String n =
              "You are interested in ${tutions[index].uname}'s(${tutions[index].uemail}) tution";
          Notice noti = Notice(n, now);
          databaseReference = database
              .reference()
              .child("users")
              .child(u.uid)
              .child("notification");
          databaseReference.push().set(noti.toJson());
          String ni = "${u.username}(${u.email}) is interested your tution";
          Notice not = Notice(ni, now);
          databaseReference = database
              .reference()
              .child("users")
              .child(tutions[index].uid)
              .child("notification");
          databaseReference.push().set(not.toJson());
        } else {
          _showDialog(context);
        }
      });
    } else {
      _showDialog2(context);
    }
  }

  Future interested(index) async {
    databaseReference = database
        .reference()
        .child("tutions")
        .child(tutions[index].tid)
        .child("interested");
    var user = {"uid": u.uid};
    databaseReference.orderByChild("uid").equalTo(u.uid).once().then((onValue) {
      if (onValue.value == null) {
        databaseReference.push().set(user);
        int now = new DateTime.now().millisecondsSinceEpoch;
        String n =
            "You are interested in ${tutions[index].uname}'s(${tutions[index].uemail}) tution";
        Notice noti = Notice(n, now);
        String ni = "${u.username}(${u.email}) is interested your tution";
        Notice not = Notice(ni, now);

        databaseReference = database
            .reference()
            .child("users")
            .child(u.uid)
            .child("notification");
        databaseReference.push().set(noti.toJson());
        databaseReference = database
            .reference()
            .child("users")
            .child(tutions[index].uid)
            .child("notification");
        databaseReference.push().set(not.toJson());
      }
    });
  }

  void user() {
    databaseReference = database.reference().child("user");
  }

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Oops!!"),
          content: new Text("You are already interested in this tution"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog2(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Oops!!"),
          content: new Text("You can not be interested in your own tution"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget button(index, context) {
    return InkWell(
      onTap: () {
        add(index, context);
      },
      child: Container(
        width: 130,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Interested',
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget stylishText(text, size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        //fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontFamily: 'Merienda',
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          stylishText(
              'Number Of Students : ${tutions[index].numberofstudent}', 13.0),
          stylishText(tutions[index].cls, 13.0),
          stylishText('Institution : ${tutions[index].institution}', 13.0),
          stylishText('Subject : ${tutions[index].subject}', 13.0),
          stylishText('Salary : ${tutions[index].salary}', 13.0),
          stylishText('Area : ${tutions[index].area}', 13.0),
          stylishText('Detailed Address : ${tutions[index].address}', 13.0),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
          button(index, context),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
        ],
      ),
    );
  }
  Widget buildProductItem(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child:Column(
        children: <Widget>[
Row(
        children: <Widget>[
          Column(
            children: <Widget>[
 stylishText(
              'Number Of Students : ${tutions[index].numberofstudent}', 13.0),
          stylishText(tutions[index].cls, 13.0),
          stylishText('Institution : ${tutions[index].institution}', 13.0),
          stylishText('Subject : ${tutions[index].subject}', 13.0),
            ],
          ),
           Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          Column(children: <Widget>[
 stylishText('Salary : ${tutions[index].salary}', 13.0),
          stylishText('Area : ${tutions[index].area}', 13.0),
          stylishText('Detailed Address : ${tutions[index].address}', 13.0),

          ],)
         
         
         ,
         
        ],
      ),
       button(index, context),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
        ],
      ) 
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: buildProductItem,
      itemCount: tutions.length,
    );
  }
}
