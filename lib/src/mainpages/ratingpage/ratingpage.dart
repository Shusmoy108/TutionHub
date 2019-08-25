import 'package:TuitionHub/src/mainpages/ratingpage/rating.dart';
import 'package:TuitionHub/src/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/complain.dart';
import '../../models/user.dart';
import '../addtutionpage/addtutionform.dart';
import '../alltutionpage/alltutionspage.dart';
import '../notificationpage/notifications.dart';
import '../profilepage/profile.dart';

class RatingPage extends StatefulWidget {
  User u;

  RatingPage(this.u);
  @override
  State<StatefulWidget> createState() {
    return RatingPageState(u);
  }
}

class RatingPageState extends State<RatingPage> {
  User u;
  RatingPageState(this.u);
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  @override
  void initState() {
    setState(() {
      super.initState();
      databaseReference = database.reference().child("complains");
 
    });
  }

  

  Future<List<Complain>> _getMyTution() async {
    List<Complain> _complains = List();
      List<Complain> _mycomplains = List();
    await databaseReference.once().then((DataSnapshot snapshot) {
      if (snapshot.value.values != null) {
        for (var value in snapshot.value.values) {
     
              Complain com = Complain(value["complain"], value["tutorname"], value["tutoremail"], value["tutorid"],
     value["uid"], value["tutionid"],value["uname"],value["rating"],value["time"],value["uemail"]);
    com.ratingtype=value['ratingtype'];
          if (com.uid == u.uid && com.complain=="") {
            com.r = 'm';
          }
           
            _complains.add(com);
      
        }
        int i = 0;
        for (var key in snapshot.value.keys) {
          _complains[i].key = key;
          i++;
        }
        for (var x = 0; x < _complains.length; x++) {
          if (_complains[x].r == 'm') {
            _mycomplains.add(_complains[x]);
          }
        }
      } else {
        _mycomplains = [];
      }
    }).catchError((onError){

    });

    return _mycomplains;
  }

  void addTution() {
    // var router = new MaterialPageRoute(
    //     builder: (BuildContext context) =>
    //         new AddTution(u));
    // Navigator.of(context).push(router);
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: Text('Tuition Hub')),
        
          body: Container(
              margin: EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: _getMyTution(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("You have nothing to rate yet..."),
                      ),
                    );
                  } else {
                    return RatingMakee(snapshot.data, u);
                  }
                },
              )),
         
        );
  }
}
