import 'package:flutter/material.dart';
import './signup.dart';

import 'tution.dart';
import 'user.dart';
import 'alltutionspage.dart';
import 'package:firebase_database/firebase_database.dart';

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LogInState();
  }
}

class LogInState extends State<LogIn> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  String _email, _password, _error = "";
  List<User> _users = [];
  List<Tution> tutions = List();
  List<Tution> mytutions = List();

  @override
  void initState() {
    setState(() {
      super.initState();
      databaseReference = database.reference().child("users");
    });

    //databaseReference.onChildAdded.listen(_onEntryAdded);
    //databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("Tuition Hub"),
      ),
      body: new Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              errorField(),
              emailField(),
              passwordField(),
              Container(
                margin: EdgeInsets.only(top: 25),
              ),
              Row(
                children: <Widget>[
                  loginButton(),
                  Padding(
                    padding: EdgeInsets.only(left: 50),
                  ),
                  signupButton()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return new TextFormField(
      decoration: InputDecoration(labelText: "Email"),
      onSaved: (val) => _email = val,
      validator: (String value) {
        if (!value.contains("@")) {
          return "Email must be valid";
        }
      },
    );
  }

  Widget passwordField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Password"),
        onSaved: (val) => _password = val,
        obscureText: true,
        validator: (String value) {
          if (value.length <= 4) {
            return "Password length must be greater than 4";
          }
        });
  }

  Widget loginButton() {
    return RaisedButton(
      color: Colors.green,
      child: Text("Log In"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();

          login();

          formKey.currentState.reset();
          //save form data to the database

        }
      },
    );
  }

  Widget signupButton() {
    return RaisedButton(
      color: Colors.redAccent,
      child: Text("Sign Up"),
      onPressed: () {
        var router = new MaterialPageRoute(
            builder: (BuildContext context) => new SignUp());

        Navigator.of(context).push(router);
      },
    );
  }

  Widget errorField() {
    return new Text(
      _error,
      style: new TextStyle(fontSize: 20, color: Colors.redAccent),
    );
  }

  void login() {
    databaseReference
        .orderByChild("email")
        .equalTo(_email)
        .once()
        .then((onValue) {
      for (var value in onValue.value.values) {
        if (value['password'] == _password) {
          setState(() {
            _error = "";
          });

          User u;
          u = User(
              value["username"],
              value["gender"],
              value["address"],
              value["area"],
              value["department"],
              value["institution"],
              value["mobile"],
              value["password"],
              value["email"]);

          for (var key in onValue.value.keys) {
            u.uid = key;
          }
          var router = new MaterialPageRoute(
              builder: (BuildContext context) => new AllTutionPage(u));
          Navigator.of(context).pushReplacement(router);
        } else {
          setState(() {
            _error = "Incorrect Email or Password";
          });
        }
      }
    }).catchError((onError) {
      setState(() {
        _error = "Incorrect Email or Password";
      });
    });
  }
}
