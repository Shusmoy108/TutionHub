import 'package:flutter/material.dart';
import './signup.dart';
import 'addtution.dart';

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LogInState();
  }
}

class LogInState extends State<LogIn> {
  int _moneyconter = 0;
  void _rain() {
    setState(() {
      _moneyconter = _moneyconter + 1000;
    });
  }

  String _name = "";
  final TextEditingController _usercontroller = new TextEditingController();
  final TextEditingController _passwordcontroller = new TextEditingController();
  void _erase() {
    setState(() {
      _usercontroller.clear();
      _passwordcontroller.clear();
    });
  }

  void _login() {
    setState(() {
      print(_usercontroller.text.isNotEmpty &&
          _passwordcontroller.text.isNotEmpty);
      if (_usercontroller.text.isNotEmpty &&
          _passwordcontroller.text.isNotEmpty) {
        _name = _usercontroller.text;
      } else {
        _name = 'nothing';
      }

      print(_name);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        
        title: new Text("TutionHub"),
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
              ),
            ),
            new Container(
              height: 200,
              width: 500,
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _usercontroller,
                    decoration: new InputDecoration(
                        hintText: 'Username', icon: new Icon(Icons.person)),
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
                            child: new Text("log In",
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 16.9)),
                          ),
                        ),
                        new Container(
                          margin: new EdgeInsets.only(left: 10.0),
                          child: new RaisedButton(
                            onPressed: () {
                              var router = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new SignIn());
                              Navigator.of(context).push(router);
                            },
                            color: Colors.redAccent,
                            child: new Text("Sign Up",
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 16.9)),
                          ),
                        ),
                        new Container(
                          margin: new EdgeInsets.only(left: 10.0),
                          child: new RaisedButton(
                            onPressed: () {
                              var router = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new AddTution());
                              Navigator.of(context).push(router);
                            },
                            color: Colors.redAccent,
                            child: new Text("Add Tution",
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
