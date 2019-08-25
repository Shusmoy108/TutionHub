import 'package:TuitionHub/src/mainpages/ratingpage/complainbox.dart';
import 'package:TuitionHub/src/mainpages/mytutionpage/recomendation.dart';
import 'package:TuitionHub/src/models/complain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/tution.dart';
import '../../models/user.dart';
import '../../models/notice.dart';



class RatingMakee extends StatelessWidget {
  final List<Complain> complains;
  User u;
  var rating = 3.5;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String complain;
  List<User> users = List();
  bool ty = false;
  RatingMakee (this.complains, this.u);

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  void add(index) {
    databaseReference = database
        .reference()
        .child("tutions")
        .child(complains[index].key)
        .child("interested");
    databaseReference.push().set(u.uid);
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
              value["email"],
              value["rating"],
              value["number"],
              value["subject"]);
          users.add(us);
        }
      }).catchError((onError) {});
    }
    // var router = new MaterialPageRoute(
    //     builder: (BuildContext context) =>
    //         new TutionDetailsPage(u, alltutions, tutions, t, users));
    // Navigator.of(context).push(router);

    //;
  }

  // void _showDialog(context) {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: new Text("Oops!!"),
  //         content: new Text("The tution is not booked at the moment"),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           new FlatButton(
  //             child: new Text("Ok"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void ratingchangge(v) {
  //   rating = v;
  // }

  // void _showDialog2(index, context) {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: new Text("Thank You"),
  //         content: new Text(
  //             "You have unbooked the tution from ${tutions[index].tutorname}(${tutions[index].tutoremail})."),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           new FlatButton(
  //             child: new Text("Close"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _showComplainbox(index, context) {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: new Text("UNbook Tution!!"),
  //         content: Form(
  //           key: formKey,
  //           child: Column(
  //             children: <Widget>[
  //               new Text(
  //                   'Why you want to unbook the tution from ${tutions[index].tutorname}(${tutions[index].tutoremail})?'),
  //               new TextFormField(
  //                   decoration: InputDecoration(labelText: "Complain"),
  //                   onSaved: (val) => complain = val,
  //                   validator: (String value) {
  //                     if (value == "") {
  //                       return "You must write the reason of unbooking the tution";
  //                     }
  //                   }),
  //               new Text(
  //                   'Rate ${tutions[index].tutorname}(${tutions[index].tutoremail})'),
  //               IconTheme(
  //                 data: IconThemeData(
  //                   color: Colors.amber,
  //                   size: 48,
  //                 ),
  //                 child: StarDisplay(value: 3),
  //               ),
             
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           new FlatButton(
  //             child: new Text("Submit"),
  //             onPressed: () {
  //               if (formKey.currentState.validate()) {
  //                 formKey.currentState.save();
  //                 //unbooktution(index);
  //                 Navigator.of(context).pop();
  //                 formKey.currentState.reset();
  //               }
  //             },
  //           ),
  //           new FlatButton(
  //             child: new Text("Close"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void unbooktution(index) {
  //   //int x = tutions[index].unbooknumber + 1;
  //   databaseReference =
  //       database.reference().child("tutions/${tutions[index].tid}");
  //   databaseReference.update({'status': 'unbooked', 'unbooknumber': x});
  //   int now = new DateTime.now().millisecondsSinceEpoch;
  //   String n =
  //       '${tutions[index].uname}(${tutions[index].uemail}) has unbooked the tution';
  //   Notice noti = Notice(n, now);

  //   for (var val in tutions[index].interested) {
  //     databaseReference =
  //         database.reference().child("users").child(val).child('notification');
  //     databaseReference.push().set(noti.toJson());
  //   }
  //   tutions[index].status = 'unbooked';
  //   Complain com = Complain(
  //       complain,
  //       tutions[index].tutorname,
  //       tutions[index].tutoremail,
  //       tutions[index].tutorid,
  //       tutions[index].uid,
  //       tutions[index].tid);

  //   databaseReference = database
  //       .reference()
  //       .child("tutions")
  //       .child(tutions[index].tid)
  //       .child('complain');
  //   databaseReference.push().set(com.toJson());
  //   databaseReference = database.reference().child("complains");
  //   databaseReference.push().set(com.toJson());
  // }

  // void bookTution(index, context) {
  //   if (tutions[index].status == 'booked') {
  //     _showComplainbox(index, context);
  //   } else {
  //     _showDialog(context);
  //   }
  //   // } else if (t.status == 'booked') {
  //   //   databaseReference = database.reference().child("tutions/${t.tid}");
  //   //   databaseReference.update({'status': 'unbooked'});
  //   //   t.status = 'unbooked';
  //   // }
  // }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      color: Color.fromRGBO(234, 239, 241, 1.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(children: <Widget>[
                  Text(
            '${complains[index].tutorname}',
            style: TextStyle(
                color: Colors.black, fontSize: 15.0, fontFamily: 'Merienda'),
          ),
            Text(
            '${complains[index].tutoremail}',
            style: TextStyle(
                color: Colors.black, fontSize: 15.0, fontFamily: 'Merienda'),
          ),
            
               Text(
            '${complains[index].ratingtype}',
            style: TextStyle(
                color: Colors.black, fontSize: 15.0, fontFamily: 'Merienda'),
          ),
              ],),
              Padding(
                padding: EdgeInsets.only(left: 200),
              ),
  seeintbutton(index, context),
            ],
          )
        
        ],
      ),
    );
  }

  Widget seeintbutton(index, context) {
    return InkWell(
      onTap: () {
         var router = new MaterialPageRoute(
            builder: (BuildContext context) => new MyDialog(complains[index]));
        Navigator.of(context).push(router);
      },
      child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromRGBO(220, 20, 60, 0.8),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Rate',
              style: TextStyle(
                  color: Colors.white, fontSize: 17.0, fontFamily: 'Arcon'),
            ),
          ],
        ),
      ),
    );
  }

  //  void _showDialogUnbooked(context,index) {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: new Text("Thank You"),
  //         content: new Text(
  //             "You have unbooked the tution from ${tutions[index].tutorname}(${tutions[index].tutoremail})."),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           new FlatButton(
  //             child: new Text("Close"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  // Widget unbookbutton(index, context) {
  //   return InkWell(
  //     onTap: () {
  //       if (tutions[index].status == 'booked') {
  //            int x = int.parse(tutions[index].unbooknumber) + 1;
  //   databaseReference = database.reference().child("tutions/${tutions[index].tid}");
  //   databaseReference
  //       .update({'status': 'unbooked', 'unbooknumber': x.toString()});
  //   int now = new DateTime.now().millisecondsSinceEpoch;
  //   String n = '${tutions[index].uname}(${tutions[index].uemail}) has unbooked the tution';
  //   Notice noti = Notice(n, now);
  //   String ni =
  //       'You have unbooked the tution from ${tutions[index].tutorname}(${tutions[index].tutoremail}).';
  //   Notice not = Notice(ni, now);
  //   databaseReference = database
  //       .reference()
  //       .child("users")
  //       .child(tutions[index].uid)
  //       .child('notification');
  //   databaseReference.push().set(not.toJson());
  //   for (var val in tutions[index].interested) {
  //     databaseReference =
  //         database.reference().child("users").child(val).child('notification');
  //     databaseReference.push().set(noti.toJson());
  //   }
  //   tutions[index].status = 'unbooked';
  //         Complain com = Complain("", tutions[index].tutorname, tutions[index].tutoremail,
  //       tutions[index].tutorid, tutions[index].uid, tutions[index].tid,tutions[index].uname,"",0,tutions[index].uemail);
  //       com.ratingtype="tutor";
  //   databaseReference = database
  //       .reference()
  //       .child("tutions")
  //       .child(tutions[index].tid)
  //       .child('complain');
  //   databaseReference.push().set(com.toJson());
  //   databaseReference = database.reference().child("complains");
  //   databaseReference.push().set(com.toJson());
  //    Complain com1 = Complain("", tutions[index].uname,tutions[index].uemail,
  //       tutions[index].uid,  tutions[index].tutorid,tutions[index].tid,tutions[index].tutorname,"",0, tutions[index].tutoremail);
  //       com1.ratingtype="guardian";
  //         databaseReference = database.reference().child("complains");
  //   databaseReference.push().set(com1.toJson());
  //         // var router = new MaterialPageRoute(
  //         //     builder: (BuildContext context) => new MyDialog(tutions[index]));
  //         // Navigator.of(context).push(router);
  //         //_showDialog2(index, context);
  //         //bookTution(index, context);
  //         _showDialogUnbooked(context,index);
  //       } else {
  //         _showDialog(context);
  //       }
  //     },
  //     child: Container(
  //       width: 200,
  //       height: 40,
  //       decoration: BoxDecoration(
  //         color: Colors.blue,
  //         borderRadius: BorderRadius.circular(30.0),
  //         boxShadow: [
  //           //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
  //         ],
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             'Unbook the tution',
  //             style: TextStyle(
  //                 color: Colors.white, fontSize: 15.0, fontFamily: 'Merienda'),
  //           ),
  //           SizedBox(
  //             width: 0.0,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
    Widget stylishText(text, size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        //fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontFamily: 'Arcon',
      ),
    );
  }
 Widget buildProductItem(BuildContext context, int index) {
   return Card(
     child:ListTile(
     title:  stylishText(complains[index].tutorname, 20.0),
     leading: stylishText(complains[index].ratingtype[0].toUpperCase(), 25.0),
     subtitle: stylishText("Please rate ${complains[index].tutorname} as a  ${complains[index].ratingtype} how good he is?", 15.0),
     trailing: seeintbutton(index, context),
   ) ,
   ) ;
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: buildProductItem,
      itemCount: complains.length,
    );
  }
}

