import 'package:firebase_database/firebase_database.dart';
import 'tutionpage.dart';
import 'tution.dart';
import 'package:flutter/material.dart';

class AddTution extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Add Tution',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new AddTutionPage(),
    );
  }
}

class AddTutionPage extends StatefulWidget {
  @override
  _AddTutionPageState createState() => new _AddTutionPageState();
}

class _AddTutionPageState extends State<AddTutionPage> {
  List<Tution> boardMessages = List();
  Tution tution;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  String _selectedClass;
  String _selectedArea;
  List<String> classes = [
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
    'HSC Examinee',
    'Admission Test'
  ];
  List<String> areas = [
    'Uttara',
    'Shahbag',
    'Ajimpur',
    'Motijheel',
    'Komplapur',
    'Khilgaon',
    'Gulshan',
    'Bonani',
    'Cantonment',
    'Puran Dhaka',
    'Jatrabari',
    'Narayanganj',
    'Shyamoli',
    'MohammadPur',
    'Mirpur'
  ];
  @override
  void initState() {
    super.initState();
    _selectedClass = 'Class 1';
    _selectedArea = 'Shahbag';
    tution = Tution("", "", "", "", "", "", "");
    databaseReference = database.reference().child("tutions");
    //databaseReference.onChildAdded.listen(_onEntryAdded);
    //databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("Tutions"),
      ),
      body: new Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              studentsField(),
              classField(),
              institutionField(),
              subjectField(),
              salaryField(),
              areaField(),
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

  Widget studentsField() {
    return new TextFormField(
      decoration: InputDecoration(labelText: "Number of Students"),
      onSaved: (val) => tution.numberofstudent = val,
      validator: (String value) {
        if (!isNumeric(value)) {
          return "Number of Students must be a number";
        }
      },
    );
  }

  Widget institutionField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Institution Name"),
        onSaved: (val) => tution.institution = val,
        validator: (String value) {
          if (value == "") {
            return "Institution name is required";
          }
        });
  }

  Widget subjectField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Subject"),
        onSaved: (val) => tution.subject = val,
        validator: (String value) {
          if (value == "") {
            return "Subject is required";
          }
        });
  }

  Widget classField() {
    return new ListTile(
      leading: new Text("Class",
          style: new TextStyle(color: Colors.black, fontSize: 16)),
      title: DropdownButton(
        hint: Text('Please choose a Class'), // Not necessary for Option 1
        value: _selectedClass,
        onChanged: (newValue) {
          setState(() {
            _selectedClass = newValue;
          });
        },
        items: classes.map((cls) {
          return DropdownMenuItem(
            child: new Text(cls),
            value: cls,
          );
        }).toList(),
      ),
    );
  }

  Widget salaryField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Salary"),
        onSaved: (val) => tution.salary = val,
        validator: (String value) {
          if (!isNumeric(value)) {
            return "Salary must be a number";
          }
        });
  }

  Widget areaField() {
    return new ListTile(
      leading: new Text("Area",
          style: new TextStyle(color: Colors.black, fontSize: 16)),
      title: DropdownButton(
        hint: Text('Please choose a Area'), // Not necessary for Option 1
        value: _selectedArea,
        onChanged: (newValue) {
          setState(() {
            _selectedArea = newValue;
          });
        },
        items: areas.map((area) {
          return DropdownMenuItem(
            child: new Text(area),
            value: area,
          );
        }).toList(),
      ),
    );
  }

  Widget addressField() {
    return new TextFormField(
        decoration: InputDecoration(labelText: "Detail Address"),
        onSaved: (val) => tution.address = val,
        validator: (String value) {
          if (value == "") {
            return "Address is required";
          }
        });
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text("Add Tution"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          tution.area = _selectedArea;
          tution.cls = _selectedClass;
          _selectedClass = 'Class 1';
          _selectedArea = 'Shahbag';
          formKey.currentState.save();
          formKey.currentState.reset();
          //save form data to the database
          databaseReference.push().set(tution.toJson());
          var router = new MaterialPageRoute(
              builder: (BuildContext context) => new MyApp());
          Navigator.of(context).push(router);
        }
      },
    );
  }
}
