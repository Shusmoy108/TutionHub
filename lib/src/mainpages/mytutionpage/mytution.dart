import 'package:TuitionHub/src/mainpages/mytutionpage/complainbox.dart';
import 'package:TuitionHub/src/mainpages/mytutionpage/recomendation.dart';
import 'package:TuitionHub/src/models/complain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/tution.dart';
import '../../models/user.dart';
import '../../models/notice.dart';
import 'tutiondetails.dart';


class MyTution extends StatelessWidget {
  final List<Tution> tutions;
  User u;
  var rating = 3.5;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String complain;
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

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Oops!!"),
          content: new Text("The tution is not booked at the moment"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void ratingchangge(v) {
    rating = v;
  }

  void _showDialog2(index, context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thank You"),
          content: new Text(
              "You have unbooked the tution from ${tutions[index].tutorname}(${tutions[index].tutoremail})."),
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

  void _showComplainbox(index, context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("UNbook Tution!!"),
          content: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                new Text(
                    'Why you want to unbook the tution from ${tutions[index].tutorname}(${tutions[index].tutoremail})?'),
                new TextFormField(
                    decoration: InputDecoration(labelText: "Complain"),
                    onSaved: (val) => complain = val,
                    validator: (String value) {
                      if (value == "") {
                        return "You must write the reason of unbooking the tution";
                      }
                    }),
                new Text(
                    'Rate ${tutions[index].tutorname}(${tutions[index].tutoremail})'),
                IconTheme(
                  data: IconThemeData(
                    color: Colors.amber,
                    size: 48,
                  ),
                  child: StarDisplay(value: 3),
                ),
             
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Submit"),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  //unbooktution(index);
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
      },
    );
  }

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

  void bookTution(index, context) {
    if (tutions[index].status == 'booked') {
      _showComplainbox(index, context);
    } else {
      _showDialog(context);
    }
    // } else if (t.status == 'booked') {
    //   databaseReference = database.reference().child("tutions/${t.tid}");
    //   databaseReference.update({'status': 'unbooked'});
    //   t.status = 'unbooked';
    // }
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      color: Color.fromRGBO(234, 239, 241, 1.0),
      child: Column(
        children: <Widget>[
         Align(
           alignment: Alignment.topRight,
           child:  unbookbutton(index, context),
         ),
          Text(
            'Number Of Students : ${tutions[index].numberofstudent}',
            style: TextStyle(
                color: Colors.black, fontSize: 13.0, fontFamily: 'Merienda'),
          ),
          Text(
            tutions[index].cls,
            style: TextStyle(
                color: Colors.black, fontSize: 13.0, fontFamily: 'Merienda'),
          ),
          Text(
            'Institution : ${tutions[index].institution}',
            style: TextStyle(
                color: Colors.black, fontSize: 13.0, fontFamily: 'Merienda'),
          ),
          Text(
            'Subject : ${tutions[index].subject}',
            style: TextStyle(
                color: Colors.black, fontSize: 13.0, fontFamily: 'Merienda'),
          ),
          Text(
            'Salary : ${tutions[index].salary}',
            style: TextStyle(
                color: Colors.black, fontSize: 13.0, fontFamily: 'Merienda'),
          ),
          Text(
            'Area : ${tutions[index].area}',
            style: TextStyle(
                color: Colors.black, fontSize: 13.0, fontFamily: 'Merienda'),
          ),
          Text(
            'Detailed Address : ${tutions[index].address}',
            style: TextStyle(
                color: Colors.black, fontSize: 13.0, fontFamily: 'Merienda'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
          recomendationbutton(index, context),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
          ), 
          seeintbutton(index, context),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
         // unbookbutton(index, context),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
        ],
      ),
    );
  }

  Widget seeintbutton(index, context) {
    return InkWell(
      onTap: () {
        var router = new MaterialPageRoute(
            builder: (BuildContext context) => new TutionDetailsPage(
                  u,
                  tutions[index],
                ));
        Navigator.of(context).push(router);
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
              'Interesteds',
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Arcon'),
            ),
          ],
        ),
      ),
    );
  }
Widget recomendationbutton(index, context) {
    return InkWell(
      onTap: () {
        var router = new MaterialPageRoute(
            builder: (BuildContext context) => new RecomendationPage(
                  u,
                  tutions[index],
                ));
        Navigator.of(context).push(router);
      },
      child: Container(
        width: 120,
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
              'Recomendations',
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Arcon'),
            ),
          ],
        ),
      ),
    );
  }
   void _showDialogUnbooked(context,index) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thank You"),
          content: new Text(
              "You have unbooked the tution from ${tutions[index].tutorname}(${tutions[index].tutoremail})."),
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
  Widget unbookbutton(index, context) {
    return InkWell(
      onTap: () {
        if (tutions[index].status == 'booked') {
             int x = int.parse(tutions[index].unbooknumber) + 1;
    databaseReference = database.reference().child("tutions/${tutions[index].tid}");
    databaseReference
        .update({'status': 'unbooked', 'unbooknumber': x.toString()});
    int now = new DateTime.now().millisecondsSinceEpoch;
    String n = '${tutions[index].uname}(${tutions[index].uemail}) has unbooked the tution';
    Notice noti = Notice(n, now);
    String ni =
        'You have unbooked the tution from ${tutions[index].tutorname}(${tutions[index].tutoremail}).';
    Notice not = Notice(ni, now);
    databaseReference = database
        .reference()
        .child("users")
        .child(tutions[index].uid)
        .child('notification');
    databaseReference.push().set(not.toJson());
    for (var val in tutions[index].interested) {
      databaseReference =
          database.reference().child("users").child(val).child('notification');
      databaseReference.push().set(noti.toJson());
    }
    tutions[index].status = 'unbooked';
    //       Complain com = Complain("", tutions[index].tutorname, tutions[index].tutoremail,
    //     tutions[index].tutorid, tutions[index].uid, tutions[index].tid,tutions[index].uname,"",0,tutions[index].uemail);
    //     com.ratingtype="tutor";
    // databaseReference = database
    //     .reference()
    //     .child("tutions")
    //     .child(tutions[index].tid)
    //     .child('complain');
    // databaseReference.push().set(com.toJson());
    // databaseReference = database.reference().child("complains");
    // databaseReference.push().set(com.toJson());
    //  Complain com1 = Complain("", tutions[index].uname,tutions[index].uemail,
    //     tutions[index].uid,  tutions[index].tutorid,tutions[index].tid,tutions[index].tutorname,"",0, tutions[index].tutoremail);
    //     com1.ratingtype="guardian";
    //       databaseReference = database.reference().child("complains");
    // databaseReference.push().set(com1.toJson());
          // var router = new MaterialPageRoute(
          //     builder: (BuildContext context) => new MyDialog(tutions[index]));
          // Navigator.of(context).push(router);
          //_showDialog2(index, context);
          //bookTution(index, context);
          _showDialogUnbooked(context,index);
        } else {
          _showDialog(context);
        }
      },
      child: Container(
        width: 70,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.redAccent,
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
              'Unbook',
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
          Align(
            alignment: Alignment.topRight,
            child:   unbookbutton(index, context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  stylishText('Number Of Students : ${tutions[index].numberofstudent}', 11.0),   
                  stylishText('Institution : ${tutions[index].institution}', 11.0),
                  stylishText('Subject : ${tutions[index].subject}', 11.0),
                  stylishText('Detailed Address : ${tutions[index].address}', 11.0),
                      ],),

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              seeintbutton(index, context),

              recomendationbutton(index, context),



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

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating(
      {this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
    return new InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}
