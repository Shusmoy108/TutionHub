import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './tutions.dart';
import './tution.dart';
import 'addtutionform.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Tution> _tutions = [];
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    databaseReference = database.reference().child("tutions");
    getData();
  }

  void getData() {
    setState(() {
      databaseReference.once().then((DataSnapshot snapshot) {
        print("hello");
        print('Data : ${snapshot.value}');
        for (var value in snapshot.value.values) {
          Tution tution = Tution(
              value['cls'],
              value["subject"],
              value["salary"],
              value["address"],
              value["area"],
              value["institution"],
              value["numberofstudent"]);
          print(value['area']);
          _tutions.add(tution);
        }
        print(_tutions);
        print("datat");
      });
    });
  }
  void addTution(){
      var router = new MaterialPageRoute(
            builder: (BuildContext context) => new AddTution());
        Navigator.of(context).push(router);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: Scaffold(
            appBar: AppBar(title: Text('Tuition Hub')),
            body: Column(children: [
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                          color: Theme.of(context).primaryColor,
                          splashColor: Colors.blueGrey,
                          textColor: Colors.white,
                          onPressed: getData,
                          child: Text('Refresh')),
                      Padding(
                        padding: EdgeInsets.only(left: 185),
                      ),
                      RaisedButton(
                          color: Theme.of(context).primaryColor,
                          splashColor: Colors.blueGrey,
                          textColor: Colors.white,
                          onPressed: addTution,
                          child: Text('Add Tution'))
                    ],
                  )),
              Expanded(child: Tutions(_tutions))
            ])));
  }
}
