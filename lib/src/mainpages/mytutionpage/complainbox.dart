import 'package:TuitionHub/src/models/rating.dart';
import 'package:TuitionHub/src/models/tution.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:TuitionHub/src/models/complain.dart';
import '../../models/notice.dart';
import '../../models/user.dart';

class MyDialog extends StatefulWidget {
  Tution tution;
  MyDialog(this.tution);
  //final String initialValue;
  ///final void Function(String) onValueChange;

  @override
  State createState() => new MyDialogState(tution);
}

class MyDialogState extends State<MyDialog> {
  double rating;
  Tution tution;
  String complain;
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MyDialogState(this.tution);
  @override
  void initState() {
    super.initState();
    rating = 3.5;
    print("object233");
  }

  void _showDialog2(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thank You"),
          content: new Text(
              "You have unbooked the tution from ${tution.tutorname}(${tution.tutoremail})."),
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

  void unbooktution() {
    int x = int.parse(tution.unbooknumber) + 1;
    databaseReference = database.reference().child("tutions/${tution.tid}");
    databaseReference
        .update({'status': 'unbooked', 'unbooknumber': x.toString()});
    int now = new DateTime.now().millisecondsSinceEpoch;
    String n = '${tution.uname}(${tution.uemail}) has unbooked the tution';
    Notice noti = Notice(n, now);
    String ni =
        'You have unbooked the tution from ${tution.tutorname}(${tution.tutoremail}).';
    Notice not = Notice(ni, now);
    databaseReference = database
        .reference()
        .child("users")
        .child(tution.uid)
        .child('notification');
    databaseReference.push().set(not.toJson());
    for (var val in tution.interested) {
      databaseReference =
          database.reference().child("users").child(val).child('notification');
      databaseReference.push().set(noti.toJson());
    }
    tution.status = 'unbooked';
    Complain com = Complain(complain, tution.tutorname, tution.tutoremail,
        tution.tutorid, tution.uid, tution.tid,tution.uname,rating.toString(),now,tution.uemail);

    databaseReference = database
        .reference()
        .child("tutions")
        .child(tution.tid)
        .child('complain');
    databaseReference.push().set(com.toJson());
    databaseReference = database.reference().child("complains");
    databaseReference.push().set(com.toJson());
    databaseReference = database.reference().child("users");
    databaseReference
        .orderByChild("email")
        .equalTo(tution.tutoremail)
        .once()
        .then((onValue) {
      for (var value in onValue.value.values) {
        User u;
        u = User(
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
        //print(value);
        // String x = value["number"];
        // u.number = int.parse(x);
        // // u.rating = value["rating"];
        //print(u.number);
        //print(u.rating);
        for (var key in onValue.value.keys) {
          u.uid = key;

          Rating r = Rating(rating.toString(), tution.uid);
          double x = (double.parse(u.rating) + rating + 5.0) /
              (int.parse(u.number) + 1);
          u.rating = x.toString();
          int y = int.parse(u.number) + 1;
          u.number = y.toString();
          databaseReference =
              database.reference().child("users/${tution.tutorid}");
          databaseReference
              .update({'rating': x.toString(), 'number': y.toString()});
          databaseReference = database
              .reference()
              .child("users")
              .child(tution.tutorid)
              .child('ratings');
          databaseReference.push().set(r.toJson());
        }
      }
    }).catchError((onError) {
      print(onError);
      setState(() {
        //_error = "Incorrect Email or Password";
      });
    });
  }

  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text("New Dialog"),
      content: new Container(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              new Text(
                  'Why you want to unbook the tution from ${tution.tutorname}(${tution.tutoremail})?'),
              new TextFormField(
                  decoration: InputDecoration(labelText: "Complain"),
                  onSaved: (val) => complain = val,
                  validator: (String value) {
                    if (value == "") {
                      return "You must write the reason of unbooking the tution";
                    }
                  }),
              new Text('Rate ${tution.tutorname}(${tution.tutoremail})'),
              SmoothStarRating(
                allowHalfRating: false,
                onRatingChanged: (v) {
                  print(v);
                  print(rating);
                  setState(() {
                    rating = v;
                  });
                  // ratingchangge(v);
                  // _showComplainbox(index, context);
                  //Navigator.of(context).pop();
                },
                starCount: 5,
                rating: rating,
                size: 40.0,
                color: Colors.green,
                borderColor: Colors.green,
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Submit"),
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              unbooktution();
              Navigator.of(context).pop();
              _showDialog2(context);
              formKey.currentState.reset();
            }
          },
        ),
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
