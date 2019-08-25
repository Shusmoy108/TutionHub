import 'package:TuitionHub/src/models/complain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import '../../models/user.dart';
import '../alltutionpage/alltutionspage.dart';
import '../mytutionpage/mytutionpage.dart';
import '../notificationpage/notifications.dart';
import '../profilepage/profile.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailsPage extends StatefulWidget {
  User u;
   List<Complain> review;
  DetailsPage(this.u,this.review);
  @override
  State<StatefulWidget> createState() {
    return Details(u,review);
  }
}

class Details extends State<DetailsPage> {
  User u;
 List<Complain> review;
  Details(this.u,this.review);

 
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
              //           //builder: (context) => ProfileEditPage(),
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
                      u.gender,
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
              // Positioned(
              //   top: MediaQuery.of(context).size.height * 0.6 - 27,
              //   left: MediaQuery.of(context).size.width * 0.5 - 60,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(50.0),
              //     child: MaterialButton(
              //       onPressed: () {},
              //       minWidth: 120.0,
              //       height: 35.0,
              //       color: Colors.greenAccent,
              //       textColor: Colors.black87,
              //       child: Text(
              //         'HIRE ME',
              //         style: TextStyle(
              //           letterSpacing: 1.5,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          //   child: Text(
          //       u.gender, 
          //       style: TextStyle(
          //       fontSize: 13.0,
          //       fontStyle: FontStyle.italic,
          //       color: Colors.black54,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
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
                    'Studies CSE in Bangladesh University of Engineering & Technology',
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
                          'RATINGS & REVIEWS',
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
                  getTextWidgets(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget stylishText(text, size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        //fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontFamily: 'Merienda',
      ),
    );
  }

 Widget getTextWidgets()
  {
    List<Widget> list = new List<Widget>();
   
    if(review.length==0){
        list.add(stylishText("No Reviews for the tutor at the moment", 15.0));
    }
    else{
    for(var i = 0; i < review.length; i++){
 
      if(review[i].ratingtype=="tutor")
      {
        list.add( Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                       
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 7.0),
                          child: Text(
                            review[i].uname,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                          child: Row(
                            children: <Widget>[
                               SmoothStarRating(
                        allowHalfRating: false,
                        starCount: 5,
                        rating: double.parse(review[i].rating),
                        size: 11.0,
                        color: Colors.green,
                        borderColor: Colors.green,
                      ),
                            
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 20.0),
                          child: Text(
                            review[i].complain,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic,
                              color: Color.fromRGBO(0, 0, 0, 0.7),
                              wordSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),);
    }
    }
    }
    return new Column(children: list);
    
  }
 
  Widget userField() {
    return ListTile(title: Text("hello"));
  }

  Widget nameField() {
    return ListTile(
        title: Text(
      'Name : ${u.username}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget emailField() {
    return ListTile(
        title: Text(
      'Email : ${u.email}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget insititutionField() {
    return ListTile(
        title: Text(
      'Institution : ${u.institution}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget departmentField() {
    return ListTile(
        title: Text(
      'Department : ${u.department}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget genderField() {
    return ListTile(
        title: Text(
      'Gender : ${u.gender}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget mobileField() {
    return ListTile(
        title: Text(
      'Mobile Number : ${u.mobile}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget areaField() {
    return ListTile(
        title: Text(
      'Area : ${u.area}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }

  Widget addressField() {
    return ListTile(
        title: Text(
      'Detailed Address : ${u.address}',
      style: new TextStyle(fontSize: 15, color: Colors.black),
    ));
  }
}
