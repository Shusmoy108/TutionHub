import 'package:flutter/material.dart';
import 'user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'tution.dart';
import 'notice.dart';

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

  void bookTution(index) {
    if (t.status == 'unbooked') {
      print("jk");
      databaseReference = database.reference().child("tutions/${t.tid}");
      databaseReference.update({'status': 'booked'});

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
    }
  }

  Widget callbutton(index) {
    return RaisedButton(
      color: Colors.blue,
      splashColor: Colors.blueGrey,
      textColor: Colors.white,
      onPressed: () {
        String m = users[index].mobile;
        _launchURL(m);
      },
      child: Text("Call", style: TextStyle(color: Colors.white)),
    );
  }

  Widget bookbutton(index) {
    return RaisedButton(
      color: Colors.blue,
      splashColor: Colors.blueGrey,
      textColor: Colors.white,
      onPressed: () {
        String m = users[index].mobile;
        bookTution(index);
      },
      child: Text('Book', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Text('Username : ${users[index].username}',
              style: TextStyle(color: Colors.black)),
          Text('Email : ${users[index].email}',
              style: TextStyle(color: Colors.black)),
          Text('Institution : ${users[index].institution}',
              style: TextStyle(color: Colors.black)),
          Text('Mobile Number : ${users[index].mobile}',
              style: TextStyle(color: Colors.black)),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 70),
              ),
              callbutton(index),
              Padding(
                padding: EdgeInsets.only(left: 50),
              ),
              bookbutton(index)
            ],
          ),
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
