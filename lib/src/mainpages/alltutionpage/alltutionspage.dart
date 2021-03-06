import 'package:TuitionHub/src/mainpages/homepage/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/tution.dart';
import '../../models/user.dart';
import '../addtutionpage/addtutionform.dart';

import 'tutions.dart';

class AllTutionPage extends StatefulWidget {
  User u;

  AllTutionPage(this.u);
  @override
  State<StatefulWidget> createState() {
    return AllTutionPageState(u);
  }
}

class AllTutionPageState extends State<AllTutionPage> {
  User u;
  AllTutionPageState(this.u);
  String text="";
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  @override
  void initState() {
    setState(() {
      super.initState();
      databaseReference = database.reference().child("tutions");
     if(u.etuition=="Yes"){
        text="Emergency Tuition Mood";
     }
     appBarTitle = new Text(text);
    });
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

  Future<List<Tution>> _getTution() async {
    List<Tution> _tutions = List();
List<Tution> tutions = List();
    await databaseReference.once().then((DataSnapshot snapshot) {
      if (snapshot.value.values != null) {
        for (var value in snapshot.value.values) {
          Tution tution = Tution(
              value['cls'],
              value["subject"],
              value["salary"],
              value["address"],
              value["area"],
              value["institution"],
              value["numberofstudent"]);

          if (value['interested'] != null) {
            for (var value in value['interested'].values) {
              tution.interested.add(value['uid']);
            }
          } else {
            tution.interested = [];
          }

          tution.status = value['status'];
          tution.uid = value['uid'];
          tution.uname = value['uname'];
          tution.uemail = value['uemail'];
         // if (tution.status != "booked") {
            _tutions.add(tution);
          //}
        }
        int i = 0;
        for (var key in snapshot.value.keys) {
          _tutions[i].tid = key;
          i++;
        }
      } else {
        _tutions = [];
      }
    });

    int i=0;
    for(int j=0;j<_tutions.length;j++){
    if(_tutions[j].status!="booked" && _tutions[j].uid!=u.uid){
      tutions.add(_tutions[i]);
    }
    }
    //similarity search
    for(int j=0;j<tutions.length;j++){
      if(u.area.contains(tutions[j].area)){
        Tution tx=tutions[j];
        tutions[j]=tutions[i];
        tutions[i]=tx;
        i++;
      }
    }
    return tutions;
  }

  void addTution() {
    var router = new MaterialPageRoute(
        builder: (BuildContext context) => new AddTution(u));
    Navigator.of(context).push(router);
  }
  void emergencymood(){
    if(u.etuition=='No'){
     databaseReference = database.reference().child("users/${u.uid}");
    databaseReference
        .update({'etuition': 'Yes'});

    u.etuition="Yes";
    }
    else{
       databaseReference = database.reference().child("users/${u.uid}");
    databaseReference
        .update({'etuition': 'No'});
  
    u.etuition="No";
    }
     var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new MainPage(u.email));
              Navigator.of(context).pushReplacement(router);
  }
  Widget floatButton(){
    if(u.etuition=='No'){
    return FloatingActionButton.extended(
            onPressed: () {
              // var router = new MaterialPageRoute(
              //     builder: (BuildContext context) => new AddTution(u));
              // Navigator.of(context).push(router);
              emergencymood();
            },
            label: Text(
              'Activate Emergency Tuition Mood',
            ),
            icon: Icon(Icons.label_important),
            backgroundColor: Color.fromRGBO(80,200,10, 0.7),
          );
    }
    else{
     
        
      return FloatingActionButton.extended(
            onPressed: () {
              // var router = new MaterialPageRoute(
              //     builder: (BuildContext context) => new AddTution(u));
              // Navigator.of(context).push(router);
              emergencymood();
            },
            label: Text(
              'DeActivate Emergency Tuition Mood',
            ),
            icon: Icon(Icons.close),
            backgroundColor: Color.fromRGBO(220, 20, 60, 0.8),
          );
    
    }
      
  }
  Widget appBarTitle;
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
             centerTitle: true,
        title:appBarTitle,
        actions: <Widget>[
          // new IconButton(icon: actionIcon,onPressed:(){
          // setState(() {
          //            if ( this.actionIcon.icon == Icons.search){
          //             this.actionIcon = new Icon(Icons.close);
          //             this.appBarTitle = new TextField(
          //               style: new TextStyle(
          //                 color: Colors.white,

          //               ),
          //               decoration: new InputDecoration(
          //                 prefixIcon: new Icon(Icons.search,color: Colors.white),
          //                 hintText: "Search...",
          //                 hintStyle: new TextStyle(color: Colors.white)
          //               ),
          //             );}
          //             else {
          //               this.actionIcon = new Icon(Icons.search);
          //               this.appBarTitle = new Text("AppBar Title");
          //             }


          //           })
          //           ;}
          //           )
                    ]),
          body: Container(
              color: Color.fromRGBO(234, 239, 241, 1.0),
              //margin: EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: _getTution(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text(
                            "There is currently no tutions available. All tutions are booked."),
                      ),
                    );
                  } else {
                    return Tutions(snapshot.data, u);
                  }
                },
                
              )),
          floatingActionButton: floatButton()
        );
  }
}
