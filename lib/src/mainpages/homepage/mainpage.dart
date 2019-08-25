import 'package:TuitionHub/src/mainpages/alltutionpage/alltutionspage.dart';
import 'package:TuitionHub/src/mainpages/mytutionpage/mytutionpage.dart';
import 'package:TuitionHub/src/mainpages/notificationpage/notifications.dart';
import 'package:TuitionHub/src/mainpages/profilepage/profilepage.dart';
import 'package:TuitionHub/src/mainpages/ratingpage/ratingpage.dart';
import 'package:TuitionHub/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
class MainPage extends StatefulWidget {
  String email;
  MainPage(this.email);
   @override
  State<StatefulWidget> createState() {
    return _MainPageState(email);;
  }
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  User u;
  String email;
  _MainPageState(this.email);
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  var _pages = [];
  Future<bool> loadAuthData(emial) async {
  
       databaseReference = database.reference().child("users");
       await  databaseReference
        .orderByChild("email")
        .equalTo(email)
        .once()
        .then((onValue) {
      for (var value in onValue.value.values) {
        
          u = User(
              value["username"],
              value["gender"],
              value["address"],
              value["area"],
              value["department"],
              value["institution"],
              value["mobile"],
              value["password"],
              value["email"],
              value["rating"],
              value["number"],
              value["subject"]);
              u.etuition=value["etuition"];
         
          for (var key in onValue.value.keys) {
            u.uid = key;
          }
         _pages=[
          AllTutionPage(u),
          MyTutionPage(u),
          Profile(u),
          RatingPage(u),
          Notifications(u)
        ];
       
    
        }});
        
   
    return true;
  }
   @override
  void initState() {
   
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadAuthData(email),
       builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return Scaffold(
      body: Container(
        child:_pages[_selectedIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Color.fromRGBO(220, 20, 60, 1.0),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group_work,
            ),
            title: Text(
              'Tutors',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin_circle,
            ),
            title: Text(
              'Guardian',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            title: Text(
              'Profile',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.rate_review,
            ),
            title: Text(
              'Ratings',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
            title: Text(
              'Notifications',
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          this.setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      );
  }
}
