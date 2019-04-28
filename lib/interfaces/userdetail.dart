import 'package:flutter/material.dart';
import 'user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetails extends StatelessWidget {
  final List<User> users;
  User u;
  bool ty = false;
  UserDetails(this.users, this.u);

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  void add(index) {
    print("object");
  }

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

  Widget button(index) {
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

  Widget _buildProductItem(BuildContext context, int index) {
    print(users[index]);
    print("tut");
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
          button(index)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(users);
    print("tut");
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: users.length,
    );
  }
}
