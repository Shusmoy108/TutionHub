import 'package:TuitionHub/src/mainpages/alltutionpage/detailspage.dart';
import 'package:TuitionHub/src/models/complain.dart';
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
  DatabaseReference databaseReference1;
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
  Future<List<Complain>> getreviews(Tution tution,context) async{
    List<Complain> review=List();
    User tutor;
    databaseReference1 = database.reference().child("user");

      databaseReference = database.reference().child("complains");
     await databaseReference
        .orderByChild("tutorid")
        .equalTo(tution.uid)
        .once()
        .then((onValue) {
         
          if (onValue.value != null) {
   
        for (var value in onValue.value.values) {
          Complain c= new Complain(value['complain'], value["tutorname"], value["tutoremail"], value["tutorid"], value["uid"], value["tutionid"], value["uname"], value["rating"], int.parse(value["time"]), value["uemail"]);
          c.ratingtype=value["ratingtype"];
          review.add(c);
        }
           }
           else{
             review=[];
           }
databaseReference1 = database.reference().child("users");
         databaseReference1
            .orderByKey()
            .equalTo(tution.uid)
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
            us.uid = tution.uid;
           tutor=us;
           var router = new MaterialPageRoute(
              builder: (BuildContext context) => new DetailsPage(tutor,review));
              Navigator.of(context).push(router);
          }
        }).catchError((onError) {});
        }).catchError((onError){

        });
         
     return review;
  }
  Widget button(index, context) {
    return InkWell(
      onTap: () {
        add(index, context);
      },
      child: Container(
        width: 80,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
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
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Arcon'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }
 Widget dbutton(index, context) {
    return InkWell(
      onTap: () {
        getreviews(tutions[index], context);
      },
      child: Container(
        width: 70,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Details',
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Arcon'),
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

  
  Widget buildProductItem(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      child:Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  stylishText('Number Of Students : ${tutions[index].numberofstudent}', 11.0),   
                  stylishText('Institution : ${tutions[index].institution}', 11.0),
                  stylishText('Subject : ${tutions[index].subject}', 11.0),
                  stylishText('Detailed Address : ${tutions[index].address}', 11.0),
                      ],),
              Padding(
                padding: EdgeInsets.only(left: 50),
                        ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  stylishText(tutions[index].cls, 11.0),
                  stylishText('Salary : ${tutions[index].salary}', 11.0),
                  stylishText('Area : ${tutions[index].area}', 11.0),
                    ],),
                    ],),
          Padding(
            padding: EdgeInsets.only(bottom: 5)),
          Row(
            children: <Widget>[
              dbutton(index, context),
              Padding(
                padding: EdgeInsets.only(left: 100),),
              button(index, context),
              ],)         
              ],) 
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
