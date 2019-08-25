import 'package:TuitionHub/src/models/rating.dart';
import 'package:TuitionHub/src/models/tution.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:TuitionHub/src/models/complain.dart';
import '../../models/notice.dart';
import '../../models/user.dart';

class MyDialog extends StatefulWidget {
  
  Complain complain;
  MyDialog(this.complain);
  //final String initialValue;
  ///final void Function(String) onValueChange;

  @override
  State createState() => new MyDialogState(complain);
}

class MyDialogState extends State<MyDialog> {
  double rating;
  Complain comp;
  String complain;
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MyDialogState(this.comp);
  @override
  void initState() {
    super.initState();
    rating = 3.5;
  
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
              "Thank you so much for ${comp.tutorname}(${comp.tutoremail})."),
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
  
    databaseReference = database.reference().child("complains/${comp.key}");
    int now = new DateTime.now().millisecondsSinceEpoch;
    databaseReference
        .update({'complain': complain,'rating':rating.toString(), 'time': now.toString()});
    databaseReference = database.reference().child("users");
    databaseReference
        .orderByChild("email")
        .equalTo(comp.tutoremail)
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
       
        // String x = value["number"];
        // u.number = int.parse(x);
        // // u.rating = value["rating"];
        
        for (var key in onValue.value.keys) {
          u.uid = key;

          Rating r = Rating(rating.toString(), comp.uid);
          double x = (double.parse(u.rating) + rating + 5.0) /
              (int.parse(u.number) + 1);
          u.rating = x.toString();
          int y = int.parse(u.number) + 1;
          u.number = y.toString();
          databaseReference =
              database.reference().child("users/${comp.tutorid}");
          databaseReference
              .update({'rating': x.toString(), 'number': y.toString()});
          databaseReference = database
              .reference()
              .child("users")
              .child(comp.tutorid)
              .child('ratings');
          databaseReference.push().set(r.toJson());
          
        }
      }
    }).catchError((onError) {
   
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
                  'Say something about ${comp.tutorname}(${comp.tutoremail})'),
              new TextFormField(
                  decoration: InputDecoration(labelText: ""),
                  onSaved: (val) => complain = val,
                  validator: (String value) {
                    if (value == "") {
                      return "You must write something about ${comp.tutorname}(${comp.tutoremail})";
                    }
                  }),
              new Text('Rate ${comp.tutorname}(${comp.tutoremail})'),
              SmoothStarRating(
                allowHalfRating: false,
                onRatingChanged: (v) {
             
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
              _showDialog2(context);
               Navigator.of(context).pop();
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
