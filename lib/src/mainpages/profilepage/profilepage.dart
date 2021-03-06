import 'package:flutter/material.dart';
import 'package:TuitionHub/src/mainpages/profilepage/editprofile.dart';
import '../../models/user.dart';
import '../alltutionpage/alltutionspage.dart';
import '../mytutionpage/mytutionpage.dart';
import '../notificationpage/notifications.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Profile extends StatefulWidget {
  User u;
  Profile(this.u);
  @override
  State<StatefulWidget> createState() {
    return ProfilePage(u);
  }
}
class ProfilePage extends State<Profile> {
    User u;

  ProfilePage(this.u);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(123, 214, 255, 1.0),
                      Color.fromRGBO(115, 156, 255, 1.0)
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10.0,
                left: 4,
                child: BackButton(
                  color: Colors.white,
                ),
              ),
              // Positioned(
              //   top: 10.0,
              //   right: 4,
              //   child: IconButton(
              //     icon: Icon(Icons.edit),
              //     color: Colors.white,
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) => EditProfile(u),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                heightFactor: 1.4,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/pp.gif'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      u.username,
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      u.address,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                         SmoothStarRating(
                        allowHalfRating: false,
                        starCount: 5,
                        rating: double.parse(u.rating),
                        size: 40.0,
                        color: Colors.green,
                        borderColor: Colors.green,
                      ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.6 - 27,
                left: MediaQuery.of(context).size.width * 0.5 - 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditProfile(u),
                      ),
                    );
                    },
                    minWidth: 120.0,
                    height: 35.0,
                    color: Colors.greenAccent,
                    textColor: Colors.black87,
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Text(
              u.gender,
              style: TextStyle(
                fontSize: 13.0,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.contacts,
                        size: 14.0,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'CONTACT INFORMATION',
                        style: TextStyle(
                          letterSpacing: 1.2,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Mobile:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                    ),
                    Text(
                      u.mobile,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                    ),
                    Text(
                      u.email,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Address:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                      ),
                    ),
                    Container(
                      width: 220,
                      child: Text(
                        u.address,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(0, 0, 0, 0.8),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.school,
                        size: 14.0,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'EDUCATION',
                        style: TextStyle(
                          letterSpacing: 1.2,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                    'Studies ${u.department} in ${u.institution}',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      wordSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.rate_review,
                          size: 14.0,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'PREFERED AREA AND SUBJECT',
                          style: TextStyle(
                            letterSpacing: 1.2,
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
          
                 SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                    "Area: ${u.area}",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      wordSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                    "Subjects: ${u.subject}",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      wordSpacing: 1.0,
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
