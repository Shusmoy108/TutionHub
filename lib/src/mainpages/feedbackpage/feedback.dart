import 'package:TuitionHub/src/mainpages/homepage/homepage.dart';
import 'package:TuitionHub/src/models/feed.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/tution.dart';
import '../../models/user.dart';
import '../alltutionpage/alltutionspage.dart';


class FeedbackPage extends StatefulWidget {
  User u;
  FeedbackPage(this.u);
  @override
   createState() => FeedbackPageState(u);
}

class FeedbackPageState extends State<FeedbackPage> with TickerProviderStateMixin {
  String email;
  String password;
User u;
FeedbackPageState(this.u);
  final loginFormKey = GlobalKey<FormState>();
  bool _autovalidateLoginform = false;
  bool _shouldObscureText = true;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  String _email, _password, _error = "";


  @override
  void initState() {
    setState(() {
      super.initState();
      databaseReference = database.reference().child("users");
    });
  }

  void toggleObscureFlag() {
    setState(() {
      _shouldObscureText = !_shouldObscureText;
    });
  }

  saveAuthData(bool value, User u) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('auth', value);
    sp.setString("email", u.email);
  }

  void login() {
 
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                color: Colors.white,
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      animatedCcup(),
                      SizedBox(
                        height: 10.0,
                      ),
               
                      emailField(),
                    
                      SizedBox(
                        height: 10.0,
                      ),
                      loginbutton(),
                     
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget animatedCcup() {
    return Container(
      child: Center(
        child: Container(
          // width: 500,
          // height: 100,
          child: Image(
            image: AssetImage(
              'images/logo.jpg',
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Say Something about the app',
    
        icon: Icon(
          Icons.rate_review,
          color: Colors.black87,
        ),
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
      ),
      onSaved:(value){
        _email=value;
      } ,
    );
  }

 

  Widget loginbutton() {
    return InkWell(
      onTap: () {
        if (loginFormKey.currentState.validate()) {
          loginFormKey.currentState.save();
          Feeds feedbacks = Feeds(_email,u.uid,u.username,0,u.email);
       
    databaseReference = database.reference().child("feedbacks");
    databaseReference.push().set(feedbacks.toJson());
       var router = new MaterialPageRoute(
                  builder: (BuildContext context) => new HomePage(u));
              Navigator.of(context).pushReplacement(router);
        } else {
          setState(() {
            _autovalidateLoginform = true;
          });
        }
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Submit',
              style: TextStyle(
                  color: Colors.white, fontSize: 15.0, fontFamily: 'Merienda'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }



 

 
}
