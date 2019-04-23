import 'package:firebase_database/firebase_database.dart';
import 'loginapp.dart';
import 'user.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sign Up',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  User user;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  int genderValue;
  String gender, _error = "";
  bool uVal = false;
  bool shahVal = false;
  bool aVal = false;
  bool mVal = false;
  bool komVal = false;
  bool khilVal = false;
  bool gVal = false;
  bool bVal = false;
  bool cVal = false;
  bool pdVal = true;
  bool jVal = false;
  bool nVal = false;
  bool shayVal = false;
  bool mohVal = false;
  bool mirVal = false;
  var areas = [];
  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
            setState(() {
              switch (title) {
                case "Uttara":
                  uVal = value;
                  break;
                case "Shahbag":
                  shahVal = value;
                  break;
                case "Ajimpur":
                  aVal = value;
                  break;
                case "Motijheel":
                  mVal = value;
                  break;
                case "Komplapur":
                  komVal = value;
                  break;
                case "Khilgaon":
                  khilVal = value;
                  break;
                case "Gulshan":
                  gVal = value;
                  break;
                case "Bonani":
                  bVal = value;
                  break;
                case "Cantonment":
                  cVal = value;
                  break;
                case "Puran Dhaka":
                  pdVal = value;
                  break;
                case "Jatrabari":
                  jVal = value;
                  break;
                case "Narayanganj":
                  nVal = value;
                  break;
                case "Shyamoli":
                  shayVal = value;
                  break;
                case "MohammadPur":
                  mohVal = value;
                  break;
                case "Mirpur":
                  mirVal = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }

  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };
  @override
  void initState() {
    setState(() {
      super.initState();
      genderValue = 0;
      gender = "Male";
      user = User("", "", "", "", "", "", "", "", "");
      databaseReference = database.reference().child("users");
    });

    //databaseReference.onChildAdded.listen(_onEntryAdded);
    //databaseReference.onChildChanged.listen(_onEntryChanged);
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("Sign Up"),
      ),
      body: new Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              errorField(),
              emailField(),
              usernameField(),
              genderField(),
              institutionField(),
              departmentField(),
              mobileField(),
              areaField(),
              passwordField(),
              addressField(),
              Container(
                margin: EdgeInsets.only(top: 25),
              ),
              submitButton()
            ],
          ),
        ),
      ),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  void addarea() {
    if (uVal) {
      areas.add("Uttara");
    }
    if (shahVal) {
      areas.add("Shahbag");
    }
    if (aVal) {
      areas.add("Ajimpur");
    }
    if (mVal) {
      areas.add("Motijheel");
    }
    if (komVal) {
      areas.add("Komplapur");
    }
    if (jVal) {
      areas.add("Jatrabari");
    }
    if (nVal) {
      areas.add("Narayanganj");
    }
    if (shayVal) {
      areas.add("Shyamoli");
    }
    if (mohVal) {
      areas.add("MohammadPur");
    }
    if (khilVal) {
      areas.add("Khilgaon");
    }
    if (gVal) {
      areas.add("Gulshan");
    }
    if (bVal) {
      areas.add("Bonani");
    }
    if (cVal) {
      areas.add("Cantonment");
    }
    if (pdVal) {
      areas.add("Puran Dhaka");
    }
  }

  Widget errorField() {
    return new Text(
      _error,
      style: new TextStyle(fontSize: 20, color: Colors.redAccent),
    );
  }

  Widget areaField() {
    return Container(
        child: Row(children: <Widget>[
      new Text("Area", style: new TextStyle(color: Colors.black, fontSize: 16)),
      new Padding(
        padding: EdgeInsets.only(left: 10),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              checkbox("Uttara", uVal),
              new Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
              ),
              checkbox("Shahbag", shahVal),
              new Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
              ),
              checkbox("Ajimpur", aVal),
              new Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
              ),
              checkbox("Motijheel", mVal),
              new Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
              ),
              checkbox("Komplapur", komVal),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              checkbox("Jatrabari", jVal),
              new Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
              ),
              checkbox("Narayanganj", nVal),
              new Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
              ),
              checkbox("Shyamoli", shayVal),
              new Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
              ),
              checkbox("MohammadPur", mohVal),
              new Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              checkbox("Khilgaon", khilVal),
              new Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
              ),
              checkbox("Gulshan", gVal),
              new Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
              ),
              checkbox("Bonani", bVal),
              new Padding(
                padding: EdgeInsets.only(left: 3, right: 3),
              ),
              checkbox("Cantonment", cVal),
              new Padding(padding: EdgeInsets.only(left: 3, right: 3)),
              checkbox("Mirpur", mirVal),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              checkbox("Puran Dhaka", pdVal),
            ],
          ),
        ],
      ),
    ]));
  }

  Widget emailField() {
    return new TextFormField(
      decoration: InputDecoration(labelText: "Email"),
      onSaved: (val) => user.email = val,
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
        onSaved: (val) => user.password = val,
        validator: (String value) {
          if (value.length <= 4) {
            return "Password length must be greater than 4";
          }
        });
  }

  Widget usernameField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Username"),
        onSaved: (val) => user.username = val,
        validator: (String value) {
          if (value == "") {
            return "Username is required";
          }
        });
  }

  Widget institutionField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Institution Name"),
        onSaved: (val) => user.institution = val,
        validator: (String value) {
          if (value == "") {
            return "Institution name is required";
          }
        });
  }

  Widget departmentField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Department"),
        onSaved: (val) => user.department = val,
        validator: (String value) {
          if (value == "") {
            return "Department is required";
          }
        });
  }

  Widget mobileField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Mobile"),
        onSaved: (val) => user.mobile = val,
        validator: (String value) {
          if (!isNumeric(value) && value.length == 11) {
            return "Mobile must be a valid";
          }
        });
  }

  Widget genderField() {
    return new Container(
        child: new Row(
      children: <Widget>[
        new Text("Gender",
            style: new TextStyle(color: Colors.black, fontSize: 16)),
        new Radio<int>(
          activeColor: Colors.pink,
          value: 0,
          groupValue: genderValue,
          onChanged: handleGender,
        ),
        new Text("Female", style: new TextStyle(color: Colors.black)),
        new Radio<int>(
          activeColor: Colors.green,
          value: 1,
          groupValue: genderValue,
          onChanged: handleGender,
        ),
        new Text("Male", style: new TextStyle(color: Colors.black)),
      ],
    ));
  }

  Widget addressField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Detail Address"),
        onSaved: (val) => user.address = val,
        validator: (String value) {
          if (value == "") {
            return "Address is required";
          }
        });
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text("Sign Up"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          user.gender = gender;
          addarea();
          user.area = areas;
          formKey.currentState.save();
          databaseReference
              .orderByChild("email")
              .equalTo(user.email)
              .once()
              .then((onValue) {
            if (onValue.value == null) {
              setState(() {
                _error = "";
              });
              formKey.currentState.reset();
              //save form data to the database
              databaseReference.push().set(user.toJson());
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new LogIn());
              Navigator.of(context).push(router);
            } else {
              setState(() {
                _error = "Email is already exist";
              });
            }
          }).catchError((onError) {
            print("xxx");
            setState(() {
              _error = "";
            });
            formKey.currentState.reset();
            //save form data to the database
            databaseReference.push().set(user.toJson());
            var router = new MaterialPageRoute(
                builder: (BuildContext context) => new LogIn());
            Navigator.of(context).push(router);
          });
          print(_error);
          if (_error == "") {}
        }
      },
    );
  }
}
