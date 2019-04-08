import 'package:flutter/material.dart';
import './signup.dart';

class AddTution extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AddTutionState();
  }
}

class AddTutionState extends State<AddTution> {
  String _name = "";
  final TextEditingController _classcontroller = new TextEditingController();
  final TextEditingController _subjectcontroller = new TextEditingController();
  final TextEditingController _areacontroller = new TextEditingController();
  final TextEditingController _addresscontroller = new TextEditingController();
  final TextEditingController _salarycontroller = new TextEditingController();
  List<String> _locations = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
    'Class 6',
    'Class 7',
    'Class 8',
    'Class 9',
    'Class 10',
    'SSC Examinee',
    'Inter 1st Year',
    'Inter 2nd Year',
    'HSC Examinee'
  ]; // Option 2
  String _selectedLocation; // Option 2
  void handleDrop() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tution Hub"),
        backgroundColor: Colors.lightGreen,
      ),
      body: new Container(
        color: Colors.grey,
        child: new ListView(
          children: <Widget>[
            new Center(
              child: new Image.asset(
                'images/tution.gif',
                width: 200,
                height: 80,
                // color: Colors.grey,
              ),
            ),
            new Container(
              height: 500,
              width: 500,
              color: Colors.white,
              child: new ListView(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.all(1.5),
                      ),
                      new Text(
                        "Class",
                        style: new TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(1.5),
                      ),
                      DropdownButton(
                        hint: Text(
                            'Please choose a Class'), // Not necessary for Option 1
                        value: _selectedLocation,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                          });
                        },
                        items: _locations.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  new TextField(
                    controller: _subjectcontroller,
                    decoration: new InputDecoration(
                        hintText: 'Subjects', icon: new Icon(Icons.subject)),
                  ),
                  new TextField(
                    controller: _salarycontroller,
                    decoration: new InputDecoration(
                        hintText: 'Salary', icon: new Icon(Icons.attach_money)),
                  ),
                  new TextField(
                    controller: _areacontroller,
                    decoration: new InputDecoration(
                        hintText: 'Area', icon: new Icon(Icons.location_city)),
                  ),
                  new TextField(
                    controller: _addresscontroller,
                    decoration: new InputDecoration(
                        hintText: 'Address',
                        icon: new Icon(Icons.local_activity)),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(10.5),
                  ),
                  new Center(
                    child: new Container(
                      margin: new EdgeInsets.only(left: 38.0),
                      child: new RaisedButton(
                        onPressed: handleDrop,
                        color: Colors.redAccent,
                        child: new Text("Add Tution",
                            style: new TextStyle(
                                color: Colors.white, fontSize: 16.9)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(14),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("Welcome $_name !",
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w900))
              ],
            )
          ],
        ),
      ),
    );
  }
}
