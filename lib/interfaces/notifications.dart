import 'package:flutter/material.dart';
import 'user.dart';
import 'alltutionspage.dart';
import 'mytutionpage.dart';
import 'profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'addtutionform.dart';
import 'notice.dart';

class Notifications extends StatefulWidget {
  User u;
  Notifications(this.u);
  @override
  State<StatefulWidget> createState() {
    return NotificationDetails(u);
  }
}

class NotificationDetails extends State<Notifications> {
  User u;

  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  NotificationDetails(this.u);
  Future<List<Notice>> _getNotifications() async {
    List<Notice> notifications = List();
    databaseReference =
        database.reference().child("users").child(u.uid).child('notification');
    await databaseReference.once().then((DataSnapshot snapshot) {
      for (var val in snapshot.value.values) {
        print(val['time']);
        print("hello");
        Notice noti = Notice(val['noti'], val['time']);
        print(noti.toString());
        // noti.noti = val['noti'];
        //noti.time = val['time'];
        print(noti.time);
        print("hello");
        notifications.add(noti);
      }
    });
    notifications.sort((a, b) => b.time.compareTo(a.time));
    print(notifications.length);
    print("hello");
    return notifications;
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to exit Tuition Hub'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(title: Text('Tuition Hub')),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(u.username),
                    accountEmail: Text(u.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? Colors.blue
                              : Colors.white,
                      child: Text(
                        u.username.substring(0, 1),
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Profile"),
                    trailing: Icon(Icons.person),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) => new Profile(u));
                      Navigator.of(context).push(router);
                    },
                  ),
                  ListTile(
                    title: Text("Tutions"),
                    trailing: Icon(Icons.group_work),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new AllTutionPage(u));
                      Navigator.of(context).pushReplacement(router);
                    },
                  ),
                  ListTile(
                    title: Text("My Tutions"),
                    trailing: Icon(Icons.subject),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new MyTutionPage(u));
                      Navigator.of(context).pushReplacement(router);
                    },
                  ),
                  ListTile(
                    title: Text("Add Tutions"),
                    trailing: Icon(Icons.add_circle),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) => new AddTution(u));
                      Navigator.of(context).push(router);
                    },
                  ),
                  ListTile(
                    title: Text("Notifications"),
                    trailing: Icon(Icons.notifications),
                    onTap: () {
                      var router = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new Notifications(u));
                      Navigator.of(context).pushReplacement(router);
                    },
                  ),
                ],
              ),
            ),
            body: Container(
                margin: EdgeInsets.all(10.0),
                child: FutureBuilder(
                  future: _getNotifications(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("No Notifications"),
                        ),
                      );
                    } else {
                      return Notices(snapshot.data, u);
                    }
                  },
                ))));
  }
}

class Notices extends StatelessWidget {
  final List<Notice> notifications;

  User u;
  bool ty = false;
  Notices(this.notifications, this.u);

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Text('${notifications[index].noti}',
          style: TextStyle(color: Colors.black, fontSize: 20)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: notifications.length,
    );
  }
}
