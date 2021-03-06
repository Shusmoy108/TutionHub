import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import '../alltutionpage/alltutionspage.dart';
import '../../models/user.dart';
import '../../models/notice.dart';
import '../mytutionpage/mytutionpage.dart';
import '../profilepage/profile.dart';

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
     
        Notice noti = Notice(val['noti'], val['time']);
    
      
        notifications.add(noti);
      }
    });
    notifications.sort((a, b) => b.time.compareTo(a.time));
 
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
    return Scaffold(
            appBar: AppBar(title: Text('Tuition Hub')),
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
                )));
  }
}

class Notices extends StatelessWidget {
  final List<Notice> notifications;

  User u;
  bool ty = false;
  Notices(this.notifications, this.u);

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('h:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  Widget stylishText(text, size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        //fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Arcon',
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return ListTile(
      trailing: stylishText(readTimestamp(notifications[index].time), 10.0),
      title: stylishText(notifications[index].noti, 20.0),
    );
    // return Card(
    //   child: Text('${notifications[index].noti}',
    //       style: TextStyle(color: Colors.black, fontSize: 20)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: notifications.length,
    );
  }
}
