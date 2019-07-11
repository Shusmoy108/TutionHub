import 'package:TuitionHub/src/mainpages/mytutionpage/detailspage.dart';
import 'package:TuitionHub/src/models/complain.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/tution.dart';
import '../../models/user.dart';
import '../../models/notice.dart';

class UserDetails extends StatelessWidget {
  final List<User> users;
  Tution t;
  User u;
  bool ty = false;
  UserDetails(this.users, this.u, this.t);

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  void add(index) {}

  void user() {
    databaseReference = database.reference().child("user");
  }

  void _launchURL(m) async {
    String url = "tel:" + m;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Oops!!"),
          content: new Text("You had already booked the tution."),
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

  void _showDialog2(context, n) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thank you!!"),
          content: new Text(n),
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

  void bookTution(index, context) {
    if (t.status == 'unbooked') {
      databaseReference = database.reference().child("tutions/${t.tid}");
      databaseReference.update({
        'status': 'booked',
        "tutorname": users[index].username,
        "tutoremail": users[index].email,
        "tutorid": users[index].uid
      });

      int now = new DateTime.now().millisecondsSinceEpoch;
      String n =
          '${t.uname}(${t.uemail}) has booked the tution to ${users[index].username}(${users[index].email})';
      Notice noti = Notice(n, now);
      for (var val in t.interested) {
        databaseReference = database
            .reference()
            .child("users")
            .child(val)
            .child('notification');
        databaseReference.push().set(noti.toJson());
      }
      t.status = 'booked';
      String ni =
          'You have booked the tution to ${users[index].username}(${users[index].email})';
      Notice not = Notice(ni, now);
      databaseReference = database
          .reference()
          .child("users")
          .child(t.uid)
          .child('notification');
      databaseReference.push().set(not.toJson());
      _showDialog2(context, ni);
    } else {
      _showDialog(context);
    }
  }
  Future<List<Complain>> getreviews(User tutor,context) async{
    List<Complain> review=List();
      databaseReference = database.reference().child("complains");
     await databaseReference
        .orderByChild("tutorid")
        .equalTo(tutor.uid)
        .once()
        .then((onValue) {
         
           if (onValue.value != null) {
        for (var value in onValue.value.values) {
          Complain c= new Complain(value['complain'], value["tutorname"], value["tutoremail"], value["tutorid"], value["uid"], value["tutionid"], value["uname"], value["rating"], value["time"], value["uemail"]);
          review.add(c);
        }
           }
           else{
             review=[];
           }

        });
         var router = new MaterialPageRoute(
              builder: (BuildContext context) => new DetailsPage(tutor,review));
              Navigator.of(context).push(router);
     return review;
  }
  Widget callbutton(index) {
    return InkWell(
      onTap: () {
        String m = users[index].mobile;
        _launchURL(m);
      },
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.green,
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
              'Call',
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
          ],
        ),
      ),
    );
  }
   Widget detailsbutton(index,context) {
    return InkWell(
      onTap: () {
     getreviews(users[index],context);
      
      },
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
         color: Color.fromRGBO(220, 20, 60, 0.8),
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
              'Details',
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookbutton(index, context) {
    return InkWell(
      onTap: () {
        bookTution(index, context);
      },
      child: Container(
        width: 80,
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
              'Book',
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Merienda'),
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
      color: Color.fromRGBO(234, 239, 241, 1.0),
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          stylishText('Username : ${users[index].username}', 13.0),
          stylishText('Email : ${users[index].email}', 13.0),
          stylishText('Institution : ${users[index].institution}', 13.0),
          stylishText('Mobile Number : ${users[index].mobile}', 13.0),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20),
              ),
              callbutton(index),
               Padding(
                padding: EdgeInsets.only(left: 20),
              ),
              detailsbutton(index,context),
              Padding(
                padding: EdgeInsets.only(left: 20),
              ),
              bookbutton(index, context)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: users.length,
    );
  }
}
