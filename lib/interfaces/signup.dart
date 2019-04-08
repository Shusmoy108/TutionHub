import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SignInState();
  }
}

class SignInState extends State<SignIn> {
  int genderValue;
  String gender;
  final TextEditingController _usercontroller = new TextEditingController();
  final TextEditingController _passwordcontroller = new TextEditingController();
  final TextEditingController _idcontroller = new TextEditingController();
  final TextEditingController _institutioncontroller =
      new TextEditingController();
  final TextEditingController _areacontroller = new TextEditingController();
  final TextEditingController _addresscontroller = new TextEditingController();
  final TextEditingController _mobilecontroller = new TextEditingController();
  final TextEditingController _departmentcontroller =
      new TextEditingController();
  void _erase() {
    setState(() {
      _usercontroller.clear();
      _passwordcontroller.clear();
    });
  }

  void handleGender(int value) {
    setState(() {
      if (value == 0) {
        gender = "Female";
        genderValue = 0;
      } else {
        gender = "Male";
        genderValue = 1;
      }
    });
  }

  void _login() {
    setState(() {
      print(_usercontroller.text.isNotEmpty &&
          _passwordcontroller.text.isNotEmpty);
    });
  }

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
                'images/face.png',
                width: 90,
                height: 90,
                color: Colors.lightGreen,
              ),
            ),
            new Container(
              height: 500,
              width: 500,
              color: Colors.white,
              child: new ListView(
                children: <Widget>[
                  new TextField(
                    controller: _usercontroller,
                    decoration: new InputDecoration(
                        hintText: 'Username', icon: new Icon(Icons.person)),
                  ),
                  new TextField(
                    controller: _idcontroller,
                    decoration: new InputDecoration(
                        hintText: 'Student ID/ Roll',
                        icon: new Icon(Icons.perm_identity)),
                  ),
                  new Row(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.all(20.5),
                      ),
                      new Text("Gender",
                          style:
                              new TextStyle(color: Colors.black, fontSize: 16)),
                      new Radio<int>(
                        activeColor: Colors.pink,
                        value: 0,
                        groupValue: genderValue,
                        onChanged: handleGender,
                      ),
                      new Text("Female",
                          style: new TextStyle(color: Colors.black)),
                      new Radio<int>(
                        activeColor: Colors.green,
                        value: 1,
                        groupValue: genderValue,
                        onChanged: handleGender,
                      ),
                      new Text("Male",
                          style: new TextStyle(color: Colors.black)),
                    ],
                  ),
                  new TextField(
                    controller: _institutioncontroller,
                    decoration: new InputDecoration(
                        hintText: 'Institution',
                        icon: new Icon(Icons.location_on)),
                  ),
                  new TextField(
                    controller: _departmentcontroller,
                    decoration: new InputDecoration(
                        hintText: 'Department', icon: new Icon(Icons.subject)),
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
                  new TextField(
                    controller: _mobilecontroller,
                    decoration: new InputDecoration(
                        hintText: 'Mobile', icon: new Icon(Icons.phone)),
                  ),
                  new TextField(
                    controller: _passwordcontroller,
                    decoration: new InputDecoration(
                        hintText: 'Password', icon: new Icon(Icons.lock)),
                    obscureText: true,
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(10.5),
                  ),
                  new Center(
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          margin: new EdgeInsets.only(left: 38.0),
                          child: new RaisedButton(
                            onPressed: _login,
                            color: Colors.redAccent,
                            child: new Text("Sign Up",
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 16.9)),
                          ),
                        ),
                        new Container(
                          margin: new EdgeInsets.only(left: 120.0),
                          child: new RaisedButton(
                            onPressed: _erase,
                            color: Colors.redAccent,
                            child: new Text("Clear",
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 16.9)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
