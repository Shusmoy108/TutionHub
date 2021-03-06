import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import '../../models/user.dart';
import 'loginpage.dart';

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

  @override
  void initState() {
    setState(() {
      super.initState();
      genderValue = 0;
      gender = "Male";
      user = User("", "", "", [], "", "", "", "", "", "5", "1",[]);
      user.notification = [];
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
              usernameField(),
              genderField(),
              institutionField(),
              departmentField(),
              mobileField(),
              xField(),
              subjectField(),
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

  Widget errorField() {
    return new Text(
      _error,
      style: new TextStyle(fontSize: 20, color: Colors.redAccent),
    );
  }

  Widget xField() {
    return new MultiSelect(
        autovalidate: true,
        titleText: "Area",
        validator: (value) {
          if (value == null) {
            return 'Please select one or more option(s)';
          }
        },
        errorText: 'Please select one or more option(s)',
        dataSource: [
          {
            "display": "Puran Dhaka",
            "value": "Puran Dhaka",
          },
          {
            "display": "Shahbag",
            "value": "Shahbag",
          },
          {
            "display": "Azimpur",
            "value": "Azimpur",
          },
          {
            "display": "Motizeel",
            "value": "Motizeel",
          },
          {
            "display": "Komolapur",
            "value": "Komolapur",
          },
          {
            "display": "MohammadPur",
            "value": "MohammadPur",
          },
          {
            "display": "Khilgaon",
            "value": "Khilgaon",
          },
          {
            "display": "Gulshan",
            "value": "Gulshan",
          },
          {
            "display": "Bonani",
            "value": "Bonani",
          },
          {
            "display": "Uttara",
            "value": "Uttara",
          },
          {
            "display": "Jatrabari",
            "value": "Jatrabari",
          },
          {
            "display": "Cantonment",
            "value": "Cantonment",
          },
          {
            "display": "Shyamoli",
            "value": "Shyamoli",
          },
          {
            "display": "Narayanganj",
            "value": "Narayanganj",
          }
        ],
        textField: 'display',
        valueField: 'value',
        filterable: true,
        required: true,
        value: null,
        onSaved: (value) {
          user.area = value;
        });
  }
Widget subjectField() {
    return new MultiSelect(
        autovalidate: true,
        titleText: "Subject",
        validator: (value) {
          if (value == null) {
            return 'Please select one or more subject(s)';
          }
        },
        errorText: 'Please select one or more subject(s)',
        dataSource: [
          {
            "display": "Bangla",
            "value": "Bangla",
          },
          {
            "display": "English",
            "value": "English",
          },
          {
            "display": "Mathematics",
            "value": "Mathematics",
          },
          {
            "display": "Physics",
            "value": "Physics",
          },
          {
            "display": "Chemistry",
            "value": "Chemistry",
          },
          {
            "display": "All Science Subject",
            "value": "All Science Subject",
          },
          {
            "display": "All Subject",
            "value": "All Subject",
          },
          {
            "display": "All Business Studies Subject",
            "value": "All Business Studies Subject",
          },
          {
            "display": "Economics",
            "value": "Economics",
          },
          {
            "display": "Accounting",
            "value": "Accounting",
          },
          {
            "display": "Business Organization and Management",
            "value": "Business Organization and Management",
          },
          {
            "display": "Finance, Banking, and Insurance",
            "value": "Finance, Banking, and Insurance",
          },
          {
            "display": "Information and Communication Technology",
            "value": "Information and Communication Technology",
          },
         
        ],
        textField: 'display',
        valueField: 'value',
        filterable: true,
        required: true,
        value: null,
        onSaved: (value) {
          user.subject = value;
        });
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
          user.notification = [];
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
                  builder: (BuildContext context) => new LoginPage());
              Navigator.of(context).push(router);
            } else {
              setState(() {
                _error = "Email is already exist";
              });
            }
          }).catchError((onError) {
            setState(() {
              _error = "";
            });
            formKey.currentState.reset();
            //save form data to the database
            databaseReference.push().set(user.toJson());
            var router = new MaterialPageRoute(
                builder: (BuildContext context) => new LoginPage());
            Navigator.of(context).pushReplacement(router);
          });
        }
      },
    );
  }
}
